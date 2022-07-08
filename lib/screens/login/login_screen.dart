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
      backgroundColor: Color(0xffFCFCB8),
      appBar: CustomAppBar(title: 'Login', automaticallyImplyLeading: false),
      bottomNavigationBar: CustomNavBar(screen: routeName),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _EmailInput(),
              const SizedBox(height: 10),
              _PasswordInput(),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  context.read<LoginCubit>().logInWithCredentials();
                  Navigator.pushNamed(context, '/profile');
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  fixedSize: Size(200, 45),
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
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  /*final _controller = new TextEditingController(text: 'nicocastle@gmail.com');*/

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return TextField(
          autocorrect: false,
          keyboardType: TextInputType.visiblePassword,
          onChanged: (email) {
            context.read<LoginCubit>().emailChanged(email);
          },
          decoration: const InputDecoration(labelText: 'Email'),
         /* controller: _controller,*/
          /*initialValue: "nicocastle@gmail.com",*/
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  /*final _controller = new TextEditingController(text: 'P@ssword1*');*/

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return TextFormField(
          autocorrect: false,
          keyboardType: TextInputType.visiblePassword,
          onChanged: (password) {
            context.read<LoginCubit>().passwordChanged(password);
          },
          decoration: const InputDecoration(labelText: 'Password'),
          obscureText: true,
          /*initialValue: "P@ssword1*",*/
          /*controller: _controller,*/
        );
      },
    );
  }
}
