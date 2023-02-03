part of 'local_auth_bloc.dart';

class LocalAuthState extends Equatable {
  final LocalAuthStatus status;
  final String currentPin;
  final bool validPassword;

  LocalAuthState({
    required this.status,
    required this.currentPin,
    required this.validPassword,
  });

  LocalAuthState copyWith({
    LocalAuthStatus? status,
    String? currentPin,
    bool? validPassword,
  }) =>
      LocalAuthState(
        status: status ?? this.status,
        validPassword: validPassword ?? this.validPassword,
        currentPin: currentPin ?? this.currentPin,
      );

  @override
  List<Object?> get props => [
        status,
        currentPin,
        validPassword,
      ];
}

enum LocalAuthStatus {
  localAuthSet,
  localAuthUnset,
  pure,
}
