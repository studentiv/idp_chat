import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FacebookAuth facebookSignIn = FacebookAuth.instance;

  Future<bool> checkAuthStatus() async {
    return firebaseAuth.currentUser != null;
  }

  User? getCurrentUser() => firebaseAuth.currentUser;

  Future<Either<User?, String>> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final user = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Left(user.user);
    } on FirebaseException catch (error) {
      return Right(error.errorMessage);
    }
  }

  Future<Either<User?, String>> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final user = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Left(user.user);
    } on FirebaseException catch (error) {
      return Right(error.errorMessage);
    }
  }

  Future<User?> signInWithGoogle() async {
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await firebaseAuth.signInWithCredential(credential).then(
          (value) => value.user,
        );
  }

  Future<Either<User?, String>> signInWithFacebook() async {
    final facebookLogin = await facebookSignIn.login();
    final token = facebookLogin.accessToken?.token;
    if (token != null) {
      final credential = FacebookAuthProvider.credential(token);
      try {
        final userCredential = await firebaseAuth.signInWithCredential(
          credential,
        );
        final user = userCredential.user;
        return Left(user);
      } catch (error) {
        return Right('Failed auth with Facebook: $error');
      }
    } else {
      return Right('Failed auth with Facebook');
    }
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }
}

extension _FirebaseExceptionX on FirebaseException {
  static const userNotFoundCode = 'user-not-found';
  static const wrongEmailFormatCode = 'invalid-email';
  static const wrongPasswordCode = 'wrong-password';
  static const emailAlreadyUseCode = 'email-already-in-use';
  static const weakPasswordCode = 'weak-password';

  String get errorMessage {
    if (code == userNotFoundCode) {
      return 'User not found';
    } else if (code == wrongEmailFormatCode) {
      return 'Email format is invalid';
    } else if (code == wrongPasswordCode) {
      return 'Password is invalid';
    } else if (code == emailAlreadyUseCode) {
      return 'Email already exist';
    } else if (code == weakPasswordCode) {
      return 'Password should be at least 6 characters';
    } else {
      return 'Auth failure';
    }
  }
}
