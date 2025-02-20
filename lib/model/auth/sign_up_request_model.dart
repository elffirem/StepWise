import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:net_kit/net_kit.dart';

part 'sign_up_request_model.g.dart';

@JsonSerializable()
class SignUpRequestModel extends INetKitModel with EquatableMixin {
  SignUpRequestModel({
    this.email,
    this.password,
    this.fullName,
    this.purpose,
  });

  final String? email;
  final String? password;
  final String? fullName;
  final String? purpose;

  @override
  SignUpRequestModel fromJson(Map<String, dynamic> json) =>
      SignUpRequestModel.fromJson(json);

  factory SignUpRequestModel.fromJson(Map<String, dynamic> json) =>
      _$SignUpRequestModelFromJson(json);

  @override
  Map<String, dynamic>? toJson() => _$SignUpRequestModelToJson(this);

  @override
  List<Object?> get props => [email, password, fullName, purpose];

  SignUpRequestModel copyWith({
    String? email,
    String? password,
    String? fullName,
    String? purpose,
  }) {
    return SignUpRequestModel(
      email: email ?? this.email,
      password: password ?? this.password,
      fullName: fullName ?? this.fullName,
      purpose: purpose ?? this.purpose,
    );
  }
}
