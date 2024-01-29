part of 'login_cubit.dart';

class LoginState {
  final bool isLoading;
  final String? error;
  final String? emailTextFieldController;
  final String? passwordTextFieldController;
  LoginState({
    this.isLoading = false,
    this.error,
    this.emailTextFieldController,
    this.passwordTextFieldController,
  });

  LoginState copyWith({
    bool? isLoading,
    String? error,
    String? emailTextFieldController,
    String? passwordTextFieldController,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      emailTextFieldController:
          emailTextFieldController ?? this.emailTextFieldController,
      passwordTextFieldController:
          passwordTextFieldController ?? this.passwordTextFieldController,
    );
  }
}
