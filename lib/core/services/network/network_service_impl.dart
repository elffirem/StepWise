import 'package:dartz/dartz.dart';
import 'package:step_wise/core/errors/failures/exceptions/server_exception.dart';
import 'package:step_wise/core/services/network/model/custom_error_model.dart';
import 'package:step_wise/core/services/network/network_service.dart';
import 'package:step_wise/core/utils/typedefs.dart';
import 'package:vexana/vexana.dart';

import '../../constants/api_const.dart';
import '../../errors/failures/server_failure.dart';

class NetworkServiceImpl implements NetworkService {
  NetworkServiceImpl() {
    _networkManager = _getNetworkService(token: _token);
  }

  late INetworkManager<CustomErrorModel> _networkManager;

  String _token = '';

  @override
  void clearHeader() {
    _networkManager.clearHeader();
    _token = '';
    _networkManager = _getNetworkService(token: '', isCleaned: true);
  }

  @override
  ResultFuture<R> send<T extends INetworkModel<T>, R>(String path,
      {required T parseModel, required RequestType method, data}) async {
    try {
      final result = await _networkManager.send<T, R>(
        path,
        method: method,
        parseModel: parseModel,
        data: data,
      );

      if (result.error != null || result.data == null) {
        throw ServerException(
          message: result.error?.model?.message ?? '',
          statusCode: result.error?.statusCode ?? 500,
        );
      }
      return Right(result.data as R);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  void setToken(String token) {
    _networkManager = _getNetworkService(token: token);
    _token = token;
  }

  NetworkManager<CustomErrorModel> _getNetworkService({
    required String token,
    bool isCleaned = false,
  }) {
    return NetworkManager<CustomErrorModel>(
      errorModel: const CustomErrorModel(),
      isEnableLogger: false,
      skippingSSLCertificate: true,
      options: BaseOptions(
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        sendTimeout: const Duration(seconds: 60),
        baseUrl: APIConst.baseUrl,
        headers: isCleaned ? _jsonHeader : _headersAppJson(token),
      ),
    );
  }

  Map<String, String> get _jsonHeader {
    return <String, String>{'Content-type': 'application/json'};
  }

  Map<String, String> _headersAppJson(String token) {
    return <String, String>{
      'Content-type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }
}
