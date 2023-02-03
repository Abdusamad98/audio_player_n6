import 'dart:async';

import 'package:audio_player_n6/data/storage.dart';
import 'package:audio_player_n6/main.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'local_auth_event.dart';

part 'local_auth_state.dart';

class LocalAuthBloc extends Bloc<LocalAuthEvent, LocalAuthState> {
  LocalAuthBloc()
      : super(LocalAuthState(
          status: LocalAuthStatus.pure,
          currentPin: "",
          validPassword: false,
        )) {
    on<CheckStatus>(_checkStatus);
    on<ValidateCurrentPin>(_validateCurrentPin);
  }

  _checkStatus(CheckStatus event, Emitter<LocalAuthState> emit) async {
    await Future.delayed(const Duration(seconds: 3));
    String localPassword = StorageRepository.getString("local_pin");
    if (localPassword.isNotEmpty) {
      emit(state.copyWith(
        status: LocalAuthStatus.localAuthSet,
        currentPin: localPassword,
      ));
    }
  }

  _validateCurrentPin(
      ValidateCurrentPin event, Emitter<LocalAuthState> emit) async {
    if (event.pin == state.currentPin) {
      emit(state.copyWith(validPassword: true));
      getMyToast(message: "Success");
    }else{
      getMyToast(message: "No'tog'ri password");
    }
  }
}
