part of 'auth_bloc.dart';

//We first define an enum which is the authStatus.
//We basically have three potential statuses for the user: unknown, authenticated or unauthenticated.
enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthState extends Equatable {
  final AuthStatus status;
  final auth.User? authUser;
  final User? user;

  const AuthState._({
    this.status = AuthStatus.unknown,
    this.authUser,
    this.user,
  });

  const AuthState.unknown() : this._();

  const AuthState.authenticated({
    required auth.User authUser,
    required User user,
  }) : this._(
          status: AuthStatus.authenticated,
          authUser: authUser,
          user: user,
        );

  const AuthState.unauthenticated()
      : this._(
          status: AuthStatus.unauthenticated,
        );

  @override
  List<Object?> get props => [status, authUser, user];
}
