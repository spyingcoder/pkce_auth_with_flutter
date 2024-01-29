import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pkce_auth_with_flutter/cubit/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenCubit = LoginCubit();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Login Here",
        ),
      ),
      body: BlocConsumer<LoginCubit, LoginState>(
        bloc: screenCubit,
        // buildWhen: (previous, current) => previous.isLoading != current.isLoading,
        listener: (BuildContext context, LoginState state) {
          if (state.error != null) {
            // TODO your code here
          }
        },
        builder: (BuildContext context, LoginState state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return buildBody(state);
        },
      ),
    );
  }

  Widget buildBody(LoginState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 30,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(),
          TextFormField(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {},
              child: const Text("Login"),
            ),
          )
        ],
      ),
    );
  }
  //
}
