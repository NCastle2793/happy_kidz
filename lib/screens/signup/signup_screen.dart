import 'package:flutter/material.dart';
import 'package:happy_kidz/widgets//widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_kidz/cubits/cubits.dart';

class SignupScreen extends StatelessWidget {
  static const String routeName = '/signup';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => SignupScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SignupCubit, SignupState>(
          builder: (context, state) {
            return Column(
              children: [
                _UserInput(
                    onChanged: (value) {
                      context.read<SignupCubit>().userChanged(
                            state.user!.copyWith(email: value),
                          );
                    },
                    labelText: 'Email'),
                _UserInput(
                    onChanged: (value) {
                      context.read<SignupCubit>().userChanged(
                            state.user!.copyWith(fullName: value),
                          );
                    },
                    labelText: 'Full Name'),
               /* _UserInput(
                    onChanged: (value) {
                      context.read<SignupCubit>().userChanged(
                            state.user!.copyWith(city: value),
                          );
                    },
                    labelText: 'City'),
                _UserInput(
                    onChanged: (value) {
                      context.read<SignupCubit>().userChanged(
                            state.user!.copyWith(address: value),
                          );
                    },
                    labelText: 'Address'),
                _UserInput(
                    onChanged: (value) {
                      context.read<SignupCubit>().userChanged(
                            state.user!.copyWith(zipCode: value),
                          );
                    },
                    labelText: 'ZIP Code'),*/
                _PasswordInput(),
                ElevatedButton(
                  onPressed: () {
                    context.read<SignupCubit>().signUpWithCredentials();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    fixedSize: Size(200, 40),
                  ),
                  child: Text(
                    'Signup',
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: Colors.white),
                  ),
                ),
              ],
            );
          },
        ),
    );
  }
}

class _UserInput extends StatelessWidget {
  const _UserInput({
    Key? key,
    required this.onChanged,
    required this.labelText,
  }) : super(key: key);

  final Function(String)? onChanged;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      builder: (context, state) {
        return TextField(
          onChanged: onChanged,
          decoration: InputDecoration(labelText: labelText),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      builder: (context, state) {
        return TextField(
          onChanged: (password) {
            context.read<SignupCubit>().passwordChanged(password);
          },
          decoration: InputDecoration(labelText: 'Password'),
          obscureText: true,
        );
      },
    );
  }
}
