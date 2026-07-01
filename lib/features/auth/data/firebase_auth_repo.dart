import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/features/auth/domain/entities/app_user.dart';
import 'package:social_media_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthRepo implements AuthRepo {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<AppUser> registerWithEmailPassword(
    String name,
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      AppUser user = AppUser(
        uid: userCredential.user!.uid,
        email: email,
        name: name,
      );

      await firebaseFirestore
          .collection('users')
          .doc(user.uid)
          .set(user.toJson());

      return user;
    } catch (error) {
      // print("Error in Signup: $error");
      throw Exception('Signup Failed: $error');
    }
  }

  @override
  Future<AppUser> loginWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      AppUser user = AppUser(
        uid: userCredential.user!.uid,
        email: email,
        name: '',
      );

      return user;
    } catch (error) {
      // print("Error in login: $error");
      throw Exception('Login Failed: $error');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await firebaseAuth.signOut();
    } catch (error) {
      // print("Error logging out: $error");
      throw Exception('Logout Failed: $error');
    }
  }

  @override
  Future<AppUser?> getCurrentUser() async {
    final firebaseUser = firebaseAuth.currentUser;
    AppUser? currentUser;

    if (firebaseUser == null) {
      return null;
    } else {
      currentUser = AppUser(
        uid: firebaseUser.uid,
        email: firebaseUser.email!,
        name: '',
      );
    }

    return currentUser;
  }
}
