part of 'authorization_bloc.dart';

@immutable
abstract class AuthorizationEvent {}

class LoginEvent extends AuthorizationEvent {
  final String phone;
  final String password;
  LoginEvent(this.phone, this.password);
}

class RegistrationEvent extends AuthorizationEvent {
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String password;

  RegistrationEvent(
    this.firstName,
    this.lastName,
    this.phone,
    this.email,
    this.password,
  );
}
