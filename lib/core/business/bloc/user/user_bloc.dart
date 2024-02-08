import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../../../provider/user/user_provider.dart';
import '../../../repo/user_repository.dart';
import '../../models/user.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  void updateUser(User user) => add(UpdateUserEvent(user));
  void logout() => add(LogoutEvent());
  void getUserData() => add(GetUserData());

  UserBloc() : super(const UserState()) {
    on<UpdateUserEvent>(_updateUser);

    on<GetUserData>(_getUserData);
    on<LogoutEvent>(_logout);
  }

  final _repository = UserRepository(UserProvider());

  void _updateUser(UpdateUserEvent event, Emitter<UserState> emit) {
    emit(state.copyWith(userr: event.user));
  }

  void _getUserData(GetUserData event, Emitter<UserState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final response = await _repository.getUserData();
      if (response.isSuccess) {
        return emit(state.copyWith(isLoading: false, userr: response.user));
      }
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      debugPrint('GetUserData event error: $e');
      emit(state.copyWith(isLoading: false));
    }
  }

  void _logout(LogoutEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      final response = await _repository.logout();
      if (response.isSuccess) {
        return emit(UserLogout());
      }
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      debugPrint('LogoutEvent error: $e');
      emit(state.copyWith(isLoading: false));
    }
  }
}
