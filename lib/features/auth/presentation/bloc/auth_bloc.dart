import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pns_mobile/features/auth/domain/entities/user.dart';
import 'package:pns_mobile/features/auth/domain/usecases/request_login.dart';
import 'package:pns_mobile/features/auth/domain/usecases/verify_login.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RequestLogin _requestLogin;
  final VerifyLogin _verifyLogin;

  AuthBloc({
    required RequestLogin requestLogin,
    required VerifyLogin verifyLogin,
  })  : _requestLogin = requestLogin,
        _verifyLogin = verifyLogin,
        super(AuthInitial()) {
    on<AuthRequestLogin>(_onAuthRequestLogin);
    on<AuthVerifyToken>(_onAuthVerifyToken);
  }

  void _onAuthRequestLogin(
    AuthRequestLogin event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final res = await _requestLogin(
      RequestLoginParams(identifier: event.identifier),
    );

    res.fold(
      (failure) => emit(AuthFailureState(failure.message)),
      (_) => emit(AuthRequestSent(event.identifier)),
    );
  }

  void _onAuthVerifyToken(
    AuthVerifyToken event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final res = await _verifyLogin(
      VerifyLoginParams(token: event.token),
    );

    res.fold(
      (failure) => emit(AuthFailureState(failure.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }
}
