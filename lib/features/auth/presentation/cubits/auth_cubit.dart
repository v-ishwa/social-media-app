import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/features/auth/domain/entities/app_user.dart';
import 'package:social_media_app/features/auth/presentation/cubits/auth_states.dart';
import 'package:social_media_app/features/auth/domain/repositories/auth_repo.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;
  late AppUser _currentUser;

  AuthCubit({required this.authRepo}) : super(AuthIniial());

  void checkAuth() async {
    final AppUser? user = await authRepo.getCurrentUser();

    if (user != null) {
      _currentUser = user;
      emit(Authenticated(user));
    } else {
      emit(UnAuthenticated());
    }
  }

  AppUser? get currentUser => _currentUser;

  Future<void> login(String email, String password) async {
    try {
      emit(AuthLoading());
      AppUser user = await authRepo.loginWithEmailPassword(email, password);
      _currentUser = user;
      emit(Authenticated(user));
    } catch (error) {
      emit(AuthError(error.toString())); 
    }
  }

  Future<void> register (String name, String email, String password) async {
    try {
      emit(AuthLoading());
      AppUser user = await authRepo.registerWithEmailPassword(name, email, password);
      _currentUser = user;
      emit(Authenticated(user));
    } catch (error) {
      emit(AuthError(error.toString())); 
    }
  } 

  Future<void> logout () async {
    try {
      emit(AuthLoading());
      await authRepo.logout();
      emit(UnAuthenticated());
    } catch (error) {
      emit(AuthError(error.toString())); 
    }
  }
}
