import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure({
    required this.statusCode,
    this.message,
  });

  final String? message;
  final int? statusCode;

  @override
  List<dynamic> get props => [message, statusCode];
}
