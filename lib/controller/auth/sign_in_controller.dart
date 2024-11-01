import 'package:get/get.dart';
import 'package:step_wise/core/services/local_storage/shared_preferences_manager.dart';
import 'package:step_wise/core/services/network/network_service.dart';
import 'package:step_wise/model/auth/sign_in_request_model.dart';
import 'package:step_wise/service/auth/auth_service.dart';
import 'package:step_wise/service/auth/auth_service_impl.dart';
import 'package:step_wise/service/roadmap/roadmap_service.dart';
import 'package:step_wise/service/roadmap/roadmap_service_impl.dart';
import 'package:step_wise/ui/views/main_scaffold.dart';

import '../../core/init/service_locator/service_locator.dart';

class SignInController extends GetxController {
  final AuthService _authService =
      AuthServiceImpl(networkService: sl<NetworkService>());

  RxBool isLoading = false.obs;

  final RoadmapService roadmapService =
      RoadmapServiceImpl(networkService: sl<NetworkService>());

  SignInRequestModel _signInRequestModel = SignInRequestModel();

  void setEmail(String email) {
    _signInRequestModel = _signInRequestModel.copyWith(email: email);
  }

  void setPassword(String password) {
    _signInRequestModel = _signInRequestModel.copyWith(password: password);
  }

  Future<void> signIn() async {
    isLoading.value = true;

    final signInResult = await _authService.signIn(_signInRequestModel);
    String? errorReturn;

    signInResult.fold(
      (error) {
        errorReturn = error.message;
        isLoading.value = false;
      },
      (response) async {
        if (response.token == null) {
          errorReturn = 'An error occurred';
          isLoading.value = false;
          return;
        }
        sl<NetworkService>().setToken(response.token!);

        // Save token and username to local
        final sharedPreferencesManager = SharedPreferencesManager();
        await sharedPreferencesManager.setString('token', response.token!);
        await sharedPreferencesManager.setString(
            'username', response.user?.fullName ?? '');
        Get.off(() => const MainScaffold());
      },
    );

    if (errorReturn != null) {
      Get.snackbar('Error', errorReturn ?? 'An error occurred');
    }
  }
}
