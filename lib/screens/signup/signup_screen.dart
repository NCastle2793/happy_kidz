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
      backgroundColor: Color(0xffFCFCB8),
      appBar: CustomAppBar(title: 'Sign Up', automaticallyImplyLeading: false),
      bottomNavigationBar: CustomNavBar(screen: routeName),
      body: BlocBuilder<SignupCubit, SignupState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                  _UserInput(
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
                      labelText: 'ZIP Code'),
                  const SizedBox(height: 10),
                  _PasswordInput(),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      context.read<SignupCubit>().signUpWithCredentials();
                      Navigator.pushNamed(context, '/profile');
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      fixedSize: Size(200, 45),
                    ),
                    child: Text(
                      'Register',
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
    /*required this.initValue,*/
  }) : super(key: key);

  final Function(String)? onChanged;
  final String labelText;

  /*final String initValue;*/

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      builder: (context, state) {
        return TextField(
          /*showCursor: true,
          readOnly: true,*/
          autocorrect: false,
          keyboardType: TextInputType.visiblePassword,
          onChanged: onChanged,
          decoration: InputDecoration(labelText: labelText),
          /*initialValue: initValue,*/
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
          autocorrect: false,
          keyboardType: TextInputType.visiblePassword,
          /*showCursor: true,
          readOnly: true,*/
          onChanged: (password) {
            context.read<SignupCubit>().passwordChanged(password);
          },
          decoration: InputDecoration(labelText: 'Password'),
          obscureText: true,
          /*initialValue: "P@ssword1*",*/
        );
      },
    );
  }
}
