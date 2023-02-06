part of 'local_auth_bloc.dart';

class LocalAuthState extends Equatable {
  final LocalAuthStatus status;
  final String currentPin;
  final String confirmPassword;
  final int confirmStep;
  final bool validPassword;

  const LocalAuthState({
    required this.confirmPassword,
    required this.confirmStep,
    required this.status,
    required this.currentPin,
    required this.validPassword,
  });

  LocalAuthState copyWith({
    LocalAuthStatus? status,
    String? currentPin,
    String? confirmPassword,
    int? confirmStep,
    bool? validPassword,
  }) =>
      LocalAuthState(
        status: status ?? this.status,
        validPassword: validPassword ?? this.validPassword,
        confirmPassword: confirmPassword ?? this.confirmPassword,
        confirmStep: confirmStep ?? this.confirmStep,
        currentPin: currentPin ?? this.currentPin,
      );

  @override
  List<Object?> get props => [
        status,
        currentPin,
        validPassword,
        confirmPassword,
        confirmStep,
      ];
}

enum LocalAuthStatus {
  localAuthSet,
  localAuthUnset,
  pure,
}
