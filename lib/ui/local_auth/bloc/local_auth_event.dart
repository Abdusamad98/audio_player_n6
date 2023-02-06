part of 'local_auth_bloc.dart';

@immutable
abstract class LocalAuthEvent {}

class CheckStatus extends LocalAuthEvent {}

class ValidateCurrentPin extends LocalAuthEvent {
  ValidateCurrentPin({required this.pin});

  final String pin;
}

class UpdateConfirmFields extends LocalAuthEvent {
  final String passwordText;
  final int confirmStep;

  UpdateConfirmFields({
    required this.passwordText,
    required this.confirmStep,
  });
}
