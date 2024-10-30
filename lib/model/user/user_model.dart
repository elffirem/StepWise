import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends INetworkModel<UserModel> with EquatableMixin {
  UserModel({
    this.fullName,
    this.purpose,
    this.professionalBackground,
    this.aim,
  });

  final String? fullName;
  final String? purpose;
  final String? professionalBackground;
  final String? aim;

  @override
  UserModel fromJson(Map<String, dynamic> json) => UserModel.fromJson(json);

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  @override
  Map<String, dynamic>? toJson() => _$UserModelToJson(this);

  @override
  List<Object?> get props => [fullName, purpose, professionalBackground, aim];

  UserModel copyWith({
    String? fullName,
    String? purpose,
    String? professionalBackground,
    String? aim,
  }) {
    return UserModel(
      fullName: fullName ?? this.fullName,
      purpose: purpose ?? this.purpose,
      professionalBackground:
          professionalBackground ?? this.professionalBackground,
      aim: aim ?? this.aim,
    );
  }
}
