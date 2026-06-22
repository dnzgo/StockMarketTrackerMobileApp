import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // current logged in user
  User? get currentUser {
    return _auth.currentUser;
  }

  // sign in existing user
  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) {
    return _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // create new user
  Future<UserCredential> signUp({
    required String email,
    required String password,
  }) {
    return _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // sign out user
  Future<void> signOut() {
    return _auth.signOut();
  }

  // change password user
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {

    final user = _auth.currentUser;

    if (user == null) {
      throw Exception("User not found");
    }

    final credential =
    EmailAuthProvider.credential(
      email: user.email!,
      password: currentPassword,
    );

    await user.reauthenticateWithCredential(
      credential,
    );

    await user.updatePassword(
      newPassword,
    );
  }
}