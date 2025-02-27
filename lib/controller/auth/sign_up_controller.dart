import 'package:get/get.dart';
import 'package:step_wise/core/services/local_storage/shared_preferences_manager.dart';
import 'package:step_wise/core/services/network/network_service.dart';
import 'package:step_wise/model/auth/sign_up_request_model.dart';
import 'package:step_wise/model/roadmap/create_roadmap_request_model.dart';
import 'package:step_wise/service/auth/auth_service.dart';
import 'package:step_wise/service/auth/auth_service_impl.dart';
import 'package:step_wise/service/roadmap/roadmap_service.dart';
import 'package:step_wise/service/roadmap/roadmap_service_impl.dart';
import 'package:step_wise/ui/views/loading/loading_view.dart';
import 'package:step_wise/ui/views/main_scaffold.dart';
import 'package:step_wise/ui/views/onboarding/timeline_view.dart';

import '../../core/init/service_locator/service_locator.dart';
import '../../core/services/network/model/token_model.dart';

class SignUpController extends GetxController {
  final AuthService _authService =
      AuthServiceImpl(networkService: sl<NetworkService>());

  final RoadmapService roadmapService =
      RoadmapServiceImpl(networkService: sl<NetworkService>());

  SignUpRequestModel _signUpRequestModel = SignUpRequestModel();
  CreateRoadmapRequestModel _createRoadmapRequestModel =
      CreateRoadmapRequestModel();

  void setSignUpRequestModel(SignUpRequestModel signUpRequestModel) {
    _signUpRequestModel = signUpRequestModel;
  }

  void setCreateRoadmapRequestModel(
      CreateRoadmapRequestModel createRoadmapRequestModel) {
    _createRoadmapRequestModel = createRoadmapRequestModel;
  }

  // "purpose" alanı kaldırıldığı için ilgili metod da kaldırıldı.
  void setFullName(String fullName) {
    _signUpRequestModel = _signUpRequestModel.copyWith(fullName: fullName);
  }

  void setEmail(String email) {
    _signUpRequestModel = _signUpRequestModel.copyWith(email: email);
  }

  void setPassword(String password) {
    _signUpRequestModel = _signUpRequestModel.copyWith(password: password);
  }

  void setProfessionalBackground(String professionalBackground) {
    _createRoadmapRequestModel = _createRoadmapRequestModel.copyWith(
        professionalBackground: professionalBackground);
  }

  void setGoal(String goal) {
    _createRoadmapRequestModel =
        _createRoadmapRequestModel.copyWith(goal: goal);
  }

  Future<void> signUp() async {
     //Get.to(() => const LoadingView());

    final signUpResult = await _authService.signUp(_signUpRequestModel);
    String? errorReturn;

    signUpResult.fold(
      (error) {
        errorReturn = error.message;
      },
      (response) async {
        if (response.token == null) {
          return;
        }
        sl<NetworkService>().setToken(
          token: TokenModel(
            accessToken: response.token!,
            refreshToken: '',
          ),
        );

        // Token ve kullanıcı adını local alana kaydet
        final sharedPreferencesManager = SharedPreferencesManager();
        await sharedPreferencesManager.setString('token', response.token!);
        await sharedPreferencesManager.setString(
          'username', response.user?.fullName ?? '',
        );

        if (response.token != null) {
           Get.offAll(() => const MainScaffold());
        
        }
      },
    );

    if (errorReturn != null) {
      Get.snackbar('Error', errorReturn ?? 'An error occurred');
      Get.back(); // Hata durumunda geri dön
    }
  }
}
