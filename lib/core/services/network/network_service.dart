import 'package:net_kit/net_kit.dart';
import 'package:step_wise/core/services/network/model/token_model.dart';

import '../../utils/typedefs.dart';

abstract class NetworkService {
  ResultFuture<T> requestModel<T extends INetKitModel>(
    String path, {
    required T parseModel,
    required RequestMethod method,
    DataMap? body,
    bool? containsAccessToken,
  });

  ResultFuture<List<T>> requestList<T extends INetKitModel>(
    String path, {
    required T parseModel,
    required RequestMethod method,
    DataMap? body,
    bool? containsAccessToken,
  });

  ResultFuture<void> requestVoid(
    String path, {
    required RequestMethod method,
    DataMap? body,
    bool? containsAccessToken,
  });

  void clearHeader();

  void setToken({required TokenModel token});
}
