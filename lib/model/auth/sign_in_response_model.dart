import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:step_wise/model/user/user_model.dart';
import 'package:vexana/vexana.dart';

part 'sign_in_response_model.g.dart';

@JsonSerializable()
class SignInResponseModel extends INetworkModel<SignInResponseModel>
    with EquatableMixin {
  SignInResponseModel({
    this.token,
    this.user,
  });

  final String? token;
  final UserModel? user;

  @override
  SignInResponseModel fromJson(Map<String, dynamic> json) =>
      SignInResponseModel.fromJson(json);

  factory SignInResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SignInResponseModelFromJson(json);

  @override
  Map<String, dynamic>? toJson() => _$SignInResponseModelToJson(this);

  @override
  List<Object?> get props => [token, user];

  SignInResponseModel copyWith({
    String? token,
    UserModel? user,
  }) {
    return SignInResponseModel(
      token: token ?? this.token,
      user: user ?? this.user,
    );
  }
}
