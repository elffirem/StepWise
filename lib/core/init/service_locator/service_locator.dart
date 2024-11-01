import 'package:get_it/get_it.dart';
import 'package:step_wise/core/services/network/network_service.dart';
import 'package:step_wise/core/services/network/network_service_impl.dart';

final sl = GetIt.instance;

class ServiceLocator {
  ServiceLocator._();

  static ServiceLocator? _instance;

  static ServiceLocator get instance => _instance ??= ServiceLocator._();

  Future<void> init() async {
    sl

        /// Network
        .registerLazySingleton<NetworkService>(() => NetworkServiceImpl());
  }
}
