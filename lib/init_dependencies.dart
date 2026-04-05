import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:pns_mobile/core/network/api_client.dart';
import 'package:pns_mobile/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:pns_mobile/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:pns_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:pns_mobile/features/auth/domain/usecases/request_login.dart';
import 'package:pns_mobile/features/auth/domain/usecases/verify_login.dart';
import 'package:pns_mobile/features/auth/presentation/bloc/auth_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  // Core
  serviceLocator.registerLazySingleton(() => const FlutterSecureStorage());
  serviceLocator.registerLazySingleton(() => Dio());
  serviceLocator.registerLazySingleton(
    () => ApiClient(serviceLocator(), serviceLocator()),
  );

  _initAuth();
  _initCounter();
}

void _initAuth() {
  // Data Source
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(serviceLocator<ApiClient>().dio),
  );

  // Repository
  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(serviceLocator(), serviceLocator()),
  );

  // Use Cases
  serviceLocator.registerFactory(() => RequestLogin(serviceLocator()));
  serviceLocator.registerFactory(() => VerifyLogin(serviceLocator()));

  // Bloc
  serviceLocator.registerLazySingleton(
    () =>
        AuthBloc(requestLogin: serviceLocator(), verifyLogin: serviceLocator()),
  );
}

void _initCounter() {
  // Counter dependencies
}
