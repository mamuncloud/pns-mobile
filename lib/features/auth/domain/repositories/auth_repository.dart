import 'package:fpdart/fpdart.dart';
import 'package:pns_mobile/core/error/failures.dart';
import 'package:pns_mobile/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> requestLogin(String identifier);
  Future<Either<Failure, User>> verifyLogin(String token);
}
