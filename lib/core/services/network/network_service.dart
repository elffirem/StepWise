import 'package:vexana/vexana.dart';

import '../../utils/typedefs.dart';

abstract class NetworkService {
  ResultFuture<R> send<T extends INetworkModel<T>, R>(
    String path, {
    required T parseModel,
    required RequestType method,
    dynamic data,
  });

  void clearHeader();

  void setToken(String token);
}
