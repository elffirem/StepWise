import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

import '../../../errors/failures/failure.dart';

part 'custom_error_model.g.dart';

@JsonSerializable()
class CustomErrorModel extends Failure
    implements INetworkModel<CustomErrorModel> {
  const CustomErrorModel({super.statusCode, super.message});

  factory CustomErrorModel.fromJson(Map<String, dynamic> json) {
    return _$CustomErrorModelFromJson(json);
  }

  @override
  CustomErrorModel fromJson(Map<String, dynamic> json) =>
      CustomErrorModel.fromJson(json);

  @override
  Map<String, dynamic>? toJson() => _$CustomErrorModelToJson(this);

  @override
  List<Object?> get props => [statusCode, message];
}
