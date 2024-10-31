import 'package:step_wise/model/auth/sign_in_response_model.dart';
import 'package:step_wise/model/auth/sign_up_request_model.dart';
import 'package:step_wise/model/auth/sign_up_response_model.dart';

import '../../core/utils/typedefs.dart';
import '../../model/auth/sign_in_request_model.dart';

abstract class AuthService {
  ResultFuture<SignUpResponseModel> signUp(SignUpRequestModel signUpRequest);

  ResultFuture<SignInResponseModel> signIn(SignInRequestModel signInRequest);
}
