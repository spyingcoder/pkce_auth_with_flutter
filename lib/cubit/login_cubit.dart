import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState(isLoading: true)) {
    loadInitialData();
  }

  Future<void> loadInitialData() async {
    try {
      emit(state.copyWith(isLoading: true));

      // TODO your code here
      emit(state.copyWith(isLoading: false));
    } catch (error) {
      emit(state.copyWith(error: error.toString()));
    } finally {
      //
    }
  }

  void onEmailTextFieldChanged(String value) {
    emit(state.copyWith(emailTextFieldController: value));
  }

  void onPasswordTextFieldChanged(String value) {
    emit(state.copyWith(passwordTextFieldController: value));
  }
}
