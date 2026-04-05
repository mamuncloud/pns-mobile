import 'package:fpdart/fpdart.dart';
import 'package:pns_mobile/core/error/failures.dart';
import 'package:pns_mobile/core/usecase/usecase.dart';
import 'package:pns_mobile/features/auth/domain/repositories/auth_repository.dart';

class RequestLogin implements UseCase<void, RequestLoginParams> {
  final AuthRepository repository;

  RequestLogin(this.repository);

  @override
  Future<Either<Failure, void>> call(RequestLoginParams params) async {
    return await repository.requestLogin(params.identifier);
  }
}

class RequestLoginParams {
  final String identifier;

  RequestLoginParams({required this.identifier});
}
