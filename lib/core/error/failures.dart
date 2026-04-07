abstract class Failure {
  final String message;
  Failure([this.message = 'An unexpected error occurred']);
}

class ServerFailure extends Failure {
  ServerFailure([super.message]);
}

class NetworkFailure extends Failure {
  NetworkFailure([super.message = 'Please check your internet connection']);
}

class AuthFailure extends Failure {
  AuthFailure([super.message = 'Authentication failed']);
}
