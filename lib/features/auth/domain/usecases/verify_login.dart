import 'package:fpdart/fpdart.dart';
import 'package:pns_mobile/core/error/failures.dart';
import 'package:pns_mobile/core/usecase/usecase.dart';
import 'package:pns_mobile/features/auth/domain/entities/user.dart';
import 'package:pns_mobile/features/auth/domain/repositories/auth_repository.dart';

class VerifyLogin implements UseCase<User, VerifyLoginParams> {
  final AuthRepository repository;

  VerifyLogin(this.repository);

  @override
  Future<Either<Failure, User>> call(VerifyLoginParams params) async {
    return await repository.verifyLogin(params.token);
  }
}

class VerifyLoginParams {
  final String token;

  VerifyLoginParams({required this.token});
}
