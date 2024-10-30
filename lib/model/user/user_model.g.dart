// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      fullName: json['fullName'] as String?,
      purpose: json['purpose'] as String?,
      professionalBackground: json['professionalBackground'] as String?,
      aim: json['aim'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'fullName': instance.fullName,
      'purpose': instance.purpose,
      'professionalBackground': instance.professionalBackground,
      'aim': instance.aim,
    };
