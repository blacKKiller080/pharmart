part of 'authorization_bloc.dart';

@immutable
abstract class AuthorizationState {
  get user => null;
}

class AuthorizationInitial extends AuthorizationState {}

class LoginErrorState extends AuthorizationState {
  final String error;
  LoginErrorState(this.error);
}

class LoginLoadingState extends AuthorizationState {}

class LoginLoadedState extends AuthorizationState {
  final User user;
  LoginLoadedState(this.user);

  @override
  String toString() {
    return 'LoginLoadedState(user: $user)';
  }
}

class RegistrationLoading extends AuthorizationState {}

class RegistrationLoaded extends AuthorizationState {
    final User user;
  RegistrationLoaded(this.user);

  @override
  String toString() {
    return 'RegistrationLoaded(user: $user)';
  }
}

class RegistrationErrorState extends AuthorizationState {
  final String error;
  RegistrationErrorState(this.error);
}
