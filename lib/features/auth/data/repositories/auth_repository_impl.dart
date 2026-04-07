import 'package:fpdart/fpdart.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pns_mobile/core/constants/app_constants.dart';
import 'package:pns_mobile/core/error/failures.dart';
import 'package:pns_mobile/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:pns_mobile/features/auth/domain/entities/user.dart';
import 'package:pns_mobile/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final FlutterSecureStorage secureStorage;

  AuthRepositoryImpl(this.remoteDataSource, this.secureStorage);

  @override
  Future<Either<Failure, void>> requestLogin(String identifier) async {
    try {
      await remoteDataSource.requestLogin(identifier);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> verifyLogin(String token) async {
    try {
      final result = await remoteDataSource.verifyLogin(token);

      final accessToken = result['access_token'];
      final user = result['user'] as User;

      // Save token securely
      await secureStorage.write(key: AppConstants.tokenKey, value: accessToken);

      return Right(user);
    } on ServerException catch (e) {
      return Left(AuthFailure(e.message));
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }
}
