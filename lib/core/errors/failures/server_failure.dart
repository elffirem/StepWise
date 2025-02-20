import 'package:net_kit/net_kit.dart';

import 'failure.dart';

final class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
    required super.statusCode,
  });

  ServerFailure.fromException(ApiException exception)
      : this(message: exception.message, statusCode: exception.statusCode);
}
