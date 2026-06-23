import 'package:social_media_app/features/auth/domain/entities/app_user.dart';

abstract class AuthState {}

class AuthIniial implements AuthState {}

class AuthLoading implements AuthState {}

class Authenticated implements AuthState {
  final AppUser user;
  Authenticated(this.user);
}

class UnAuthenticated implements AuthState {}

class AuthError implements AuthState {
  final String message;
  AuthError(this.message);
}
