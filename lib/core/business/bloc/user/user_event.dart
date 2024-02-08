part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class UpdateUserEvent extends UserEvent {
  final User user;
  UpdateUserEvent(this.user);
}

class GetUserData extends UserEvent {}

class LogoutEvent extends UserEvent {}
