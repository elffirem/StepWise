import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'sign_in_request_model.g.dart';

@JsonSerializable()
class SignInRequestModel extends INetworkModel<SignInRequestModel>
    with EquatableMixin {
  SignInRequestModel({
    this.email,
    this.password,
  });

  final String? email;
  final String? password;

  @override
  SignInRequestModel fromJson(Map<String, dynamic> json) =>
      SignInRequestModel.fromJson(json);

  factory SignInRequestModel.fromJson(Map<String, dynamic> json) =>
      _$SignInRequestModelFromJson(json);

  @override
  Map<String, dynamic>? toJson() => _$SignInRequestModelToJson(this);

  @override
  List<Object?> get props => [email, password];

  SignInRequestModel copyWith({
    String? email,
    String? password,
  }) {
    return SignInRequestModel(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
