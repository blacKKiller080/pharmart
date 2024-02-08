part of 'user_bloc.dart';

class UserState {
  final User? userr;
  final bool isLoading;

  const UserState({this.userr, this.isLoading = false});

  bool get isAuthorized => userr?.token?.isNotEmpty ?? false;
  User? get user => userr;

  UserState copyWith({User? userr, bool? isLoading}) {
    return UserState(
      userr: userr ?? this.userr,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  String toString() => 'UserState(user: $userr, isLoading: $isLoading)';
}

class UserLogout extends UserState {
  UserLogout({
    super.userr,
  });
}
