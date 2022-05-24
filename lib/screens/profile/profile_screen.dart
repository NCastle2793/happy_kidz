import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_kidz/blocs/blocs.dart';
import 'package:happy_kidz/repositories/auth/auth_repository.dart';
import 'package:happy_kidz/repositories/repositories.dart';
import 'package:happy_kidz/widgets/widgets.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = '/profile';

  static Route route() {
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName),
        builder: (context) => BlocProvider<ProfileBloc>(
              create: (context) => ProfileBloc(
                authBloc: context.read<AuthBloc>(),
                userRepository: context.read<UserRepository>(),
              )..add(
                  LoadProfile(
                    context.read<AuthBloc>().state.authUser,
                  ),
                ),
              child: ProfileScreen(),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Profile'),
      bottomNavigationBar: CustomNavBar(screen: routeName),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return Center(
              child: CircularProgressIndicator(color: Colors.black),
            );
          }
          if (state is ProfileLoaded) {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  context.read<AuthRepository>().signOut();
                },
                child: Text('Sign Out'),
              ),
            );
          }
          if (state is ProfileUnauthenticated) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      'You\'re not logged in',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(),
                    primary: Colors.black,
                    fixedSize: Size(200, 40),
                  ),
                  child: Text(
                    'Login',
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(),
                    primary: Colors.white,
                    fixedSize: Size(200, 40),
                  ),
                  child: Text(
                    'Signup',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
              ],
            );
          } else {
            return Text('Something went wrong');
          }
        },
      ),
    );
  }
}
