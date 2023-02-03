part of 'local_auth_bloc.dart';

@immutable
abstract class LocalAuthEvent {}

class CheckStatus extends LocalAuthEvent{}

class ValidateCurrentPin extends LocalAuthEvent{
  ValidateCurrentPin({required  this.pin});
  final String pin;
}
