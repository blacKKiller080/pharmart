import 'dart:core';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import '../../../provider/authorization/authorization_provider.dart';
import '../../models/user.dart';

part 'authorization_event.dart';
part 'authorization_state.dart';

class AuthorizationBloc extends Bloc<AuthorizationEvent, AuthorizationState> {
  void login(String phone, String password) => add(LoginEvent(phone, password));
  void registration({
    required String firstName,
    required String lastName,
    required String phone,
    required String email,
    required String password,
  }) =>
      add(RegistrationEvent(firstName, lastName, phone, email, password));

  AuthorizationBloc() : super(AuthorizationInitial()) {
    on<LoginEvent>(_login);
    on<RegistrationEvent>(_registration);
  }

  final _provider = AuthorizationProvider();

  void _login(LoginEvent event, Emitter<AuthorizationState> emit) async {
    if (event.phone.isEmpty || event.password.isEmpty) {
      return emit(LoginErrorState('login credentials in '));
    }

    emit(LoginLoadingState());
    try {
      final response = await _provider.login(event.phone, event.password);
      if (response.isSuccess) {
        await _provider.storage.setToken(response.user!.token);
        emit(LoginLoadedState(response.user!));
        return;
      }
      emit(LoginErrorState(response.error ?? 'something went wrong'));
    } catch (e) {
      debugPrint('Login Bloc error: $e');
      emit(LoginErrorState('something went wrong while login'));
    }
  }

  void _registration(
      RegistrationEvent event, Emitter<AuthorizationState> emit) async {
    if (event.firstName.isEmpty) {
      print('name empty');
      emit(RegistrationErrorState('Username is empty'));
      return;
    }
    if (event.email.isEmpty) {
      // ||
      //     RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      //             .hasMatch(event.email) ==
      //         false) {
      emit(RegistrationErrorState('invalid email'));
      return;
    }

    emit(RegistrationLoading());
    // return emit(RegistrationLoaded());
    try {
      final response = await _provider.registration(
        event.firstName,
        event.lastName,
        event.phone,
        event.email,
        event.password,
      );
      if (response.isSuccess) {
        await _provider.storage.setToken(response.user!.token);
        emit(RegistrationLoaded(response.user!));
        return;
      }
      emit(RegistrationErrorState(response.error ?? 'something went wrong'));
    } catch (e) {
      debugPrint('RegistrationEvent error: $e');
      emit(RegistrationErrorState('something went wrong while registration'));
    }
  }
}
