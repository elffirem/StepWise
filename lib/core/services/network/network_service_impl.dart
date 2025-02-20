import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:net_kit/net_kit.dart';
import 'package:step_wise/core/errors/failures/server_failure.dart';
import 'package:step_wise/core/services/network/network_service.dart';
import 'package:step_wise/core/utils/typedefs.dart';

import '../../constants/api_const.dart';
import 'logger/network_logger.dart';
import 'model/token_model.dart';

class NetworkServiceImpl implements NetworkService {
  NetworkServiceImpl() {
    _manager = _initManager();
  }

  late INetKitManager _manager;
  String _accessToken = '';
  String _refreshToken = '';

  @override
  ResultFuture<T> requestModel<T extends INetKitModel>(
    String path, {
    required T parseModel,
    required RequestMethod method,
    DataMap? body,
    bool? containsAccessToken,
  }) async {
    try {
      final result = await _manager.requestModel<T>(
        path: path,
        model: parseModel,
        method: method,
        body: body,
        containsAccessToken: containsAccessToken,
      );
      return Right(result);
    } on ApiException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<T>> requestList<T extends INetKitModel>(
    String path, {
    required T parseModel,
    required RequestMethod method,
    DataMap? body,
    bool? containsAccessToken,
  }) async {
    try {
      final result = await _manager.requestList<T>(
        path: path,
        model: parseModel,
        method: method,
        body: body,
        containsAccessToken: containsAccessToken,
      );
      return Right(result);
    } on ApiException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> requestVoid(
    String path, {
    required RequestMethod method,
    DataMap? body,
    bool? containsAccessToken,
  }) async {
    try {
      await _manager.requestVoid(
        path: path,
        method: method,
        body: body,
        containsAccessToken: containsAccessToken,
      );
      return const Right(null);
    } on ApiException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  NetKitManager _initManager({bool isCleaned = false}) {
    /// Create a new manager
    return NetKitManager(
      baseUrl: APIConst.baseUrl,
      testMode: kReleaseMode == false,
      baseOptions:
          BaseOptions(headers: isCleaned ? _jsonHeader : _headersAppJson()),
      refreshTokenPath: APIConst.refreshToken,
      logger: NetworkLogger(),
      onTokenRefreshed: (token) {
        // _authLocalService.setToken(
        // TokenModel(
        //   accessToken: token.accessToken ?? '',
        //   refreshToken: token.refreshToken ?? '',
        //   ),
        // );
        _accessToken = token.accessToken ?? '';
        _refreshToken = token.refreshToken ?? '';
      },
      errorParams: const NetKitErrorParams(),
    );
  }

  @override
  void clearHeader() {
    _manager.clearAllHeaders();
    _accessToken = '';
    _refreshToken = '';

    _manager = _recreateManager(isCleaned: true);
  }

  @override
  void setToken({required TokenModel token}) {
    _accessToken = token.accessToken;
    _refreshToken = token.refreshToken;
    _manager
      ..setAccessToken(_accessToken)
      ..setRefreshToken(_refreshToken);
  }

  NetKitManager _recreateManager({bool isCleaned = false}) {
    _manager.dispose();

    return _initManager(isCleaned: isCleaned);
  }

  Map<String, String> get _jsonHeader {
    return <String, String>{'Content-type': 'application/json'};
  }

  Map<String, String> _headersAppJson() {
    return <String, String>{
      'Content-type': 'application/json',
      'Authorization': 'Bearer $_accessToken',
    };
  }
}
