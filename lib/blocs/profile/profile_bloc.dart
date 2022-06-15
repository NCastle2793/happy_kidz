import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:happy_kidz/blocs/blocs.dart';
import 'package:equatable/equatable.dart';
import 'package:happy_kidz/models/models.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:happy_kidz/repositories/repositories.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthBloc _authBloc;
  final UserRepository _userRepository;
  StreamSubscription? _authSubscription;

  ProfileBloc({
    required AuthBloc authBloc,
    required UserRepository userRepository,
  })  : _authBloc = authBloc,
        _userRepository = userRepository,
        super(ProfileLoading()) {
    on<LoadProfile>(_onLoadProfile);
    on<UpdateProfile>(_onUpdateProfile);

    _authSubscription = _authBloc.stream.listen((state) {
      if (state.user != null) {
        add(LoadProfile(state.authUser));
      }
    });
  }

  void _onLoadProfile(LoadProfile event, Emitter<ProfileState> emit,) {
    if (event.authUser != null) {
      _userRepository.getUser(event.authUser!.uid).listen((user) {
        add(UpdateProfile(user));
      });
    } else {
      emit(ProfileUnauthenticated());
    }
  }

  void _onUpdateProfile(UpdateProfile event, Emitter<ProfileState> emit,) {
    emit(ProfileLoaded(user: event.user));
  }

  @override
  Future<void> close() async {
    _authSubscription?.cancel();
    super.close();
  }
}