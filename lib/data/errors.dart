import 'package:firebase_auth/firebase_auth.dart';

String getFirebaseAuthErrorMessage(FirebaseAuthException error) {
  switch (error.code) {
    case 'invalid-email':
      return 'The email address is badly formatted.';
    case 'user-disabled':
      return 'The user account has been disabled by an administrator.';
    case 'user-not-found':
      return 'There is no user record corresponding to this email.';
    case 'wrong-password':
      return 'The password is invalid.';
    default:
      return 'Firebase authentication error occurred.';
  }
}
