import 'package:net_kit/net_kit.dart';
import 'package:step_wise/core/constants/api_const.dart';
import 'package:step_wise/core/utils/typedefs.dart';
import 'package:step_wise/model/auth/sign_in_request_model.dart';
import 'package:step_wise/model/auth/sign_in_response_model.dart';
import 'package:step_wise/model/auth/sign_up_request_model.dart';
import 'package:step_wise/model/auth/sign_up_response_model.dart';
import 'package:step_wise/service/auth/auth_service.dart';

import '../../core/services/network/network_service.dart';

class AuthServiceImpl extends AuthService {
  AuthServiceImpl({required NetworkService networkService})
      : _networkService = networkService;

  final NetworkService _networkService;

  @override
  ResultFuture<SignUpResponseModel> signUp(
      SignUpRequestModel signUpRequest) async {
    return _networkService.requestModel<SignUpResponseModel>(
      APIConst.signUp,
      parseModel: SignUpResponseModel(),
      method: RequestMethod.post,
      body: signUpRequest.toJson(),
    );
  }

  @override
  ResultFuture<SignInResponseModel> signIn(SignInRequestModel signInRequest) {
    return _networkService.requestModel<SignInResponseModel>(
      APIConst.signIn,
      parseModel: SignInResponseModel(),
      method: RequestMethod.post,
      body: signInRequest.toJson(),
    );
  }
}
