import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_kidz/cubits/cubits.dart';
import 'package:happy_kidz/cubits/login/login_cubit.dart';
import 'package:happy_kidz/widgets//widgets.dart';


class LoginScreen extends StatelessWidget {
  static const String routeName = '/login';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => LoginScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Login'),
      bottomNavigationBar: CustomNavBar(screen: routeName),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _EmailInput(),
            const SizedBox(height: 10),
            _PasswordInput(),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(),
                primary: Colors.black,
                fixedSize: Size(200, 40),
              ),
              child: Text(
                'Login',
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return TextField(
          onChanged: (email) {
            context.read<LoginCubit>().emailChanged(email);
          },
          decoration: const InputDecoration(labelText: 'Email'),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return TextField(
          onChanged: (password) {
            context.read<LoginCubit>().passwordChanged(password);
          },
          decoration: const InputDecoration(labelText: 'Password'),
          obscureText: true,
        );
      },
    );
  }
}
