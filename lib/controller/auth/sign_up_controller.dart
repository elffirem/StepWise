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

  void setUserFullName(String fullName) {
    _signUpRequestModel = _signUpRequestModel.copyWith(fullName: fullName);
  }

  void setEmail(String email) {
    _signUpRequestModel = _signUpRequestModel.copyWith(email: email);
  }

  void setPassword(String password) {
    _signUpRequestModel = _signUpRequestModel.copyWith(password: password);
  }

  void setPurpose(String purpose) {
    _signUpRequestModel = _signUpRequestModel.copyWith(purpose: purpose);
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
    Get.to(() => const LoadingView());

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
        ));

        // Save token and username to local
        final sharedPreferencesManager = SharedPreferencesManager();
        await sharedPreferencesManager.setString('token', response.token!);
        await sharedPreferencesManager.setString(
            'username', response.user?.fullName ?? '');

        if (response.token != null) {
          await roadmapService.createRoadmap(_createRoadmapRequestModel);

          /// Waiting for the roadmap to be created
          await Future.delayed(const Duration(seconds: 35));
          final userRoadmap = await roadmapService.getRoadmap();
          userRoadmap.fold(
            (error) {
              errorReturn = error.message;
            },
            (roadmap) {
              Get.off(() => TimelineView(roadmapModel: roadmap));
            },
          );
        }
      },
    );

    if (errorReturn != null) {
      Get.snackbar('Error', errorReturn ?? 'An error occurred');
      Get.back(); // Get back if there is error
    }
  }
}
