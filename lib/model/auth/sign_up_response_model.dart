import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:net_kit/net_kit.dart';

import '../user/user_model.dart';

part 'sign_up_response_model.g.dart';

@JsonSerializable()
class SignUpResponseModel extends INetKitModel with EquatableMixin {
  final String? token;
  final UserModel? user;

  SignUpResponseModel({this.token, this.user});

  @override
  SignUpResponseModel fromJson(Map<String, dynamic> json) =>
      SignUpResponseModel.fromJson(json);

  factory SignUpResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SignUpResponseModelFromJson(json);

  @override
  Map<String, dynamic>? toJson() => _$SignUpResponseModelToJson(this);

  @override
  List<Object?> get props => [user];
}
