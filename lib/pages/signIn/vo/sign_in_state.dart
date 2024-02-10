import 'dart:io';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:routine_app/databases/todo_database.dart';

part 'sign_in_state.freezed.dart';

final signInProvider = StateNotifierProvider<SignInNotifier, SignInState>(
    (ref) => SignInNotifier());

class SignInNotifier extends StateNotifier<SignInState> {
  SignInNotifier() : super(const SignInState()) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      state = state.copyWith(user: user);
    });
  }

  Future<void> onTapSignIn() async {
    await _signInWithGoogle();
  }

  Future<void> onTapSignOut() async {
    state = state.copyWith(isLoading: true);
    await FirebaseAuth.instance.signOut();
    state = state.copyWith(isLoading: false);
  }

  Future<bool> onTapBackup() async {
    state = state.copyWith(isLoading: true);
    final storageRef = FirebaseStorage.instance.ref();
    final dbRef = storageRef.child('${state.user!.uid}.db');

    File file = File(await TodoDatabase.databasePath);
    try {
      await dbRef.putFile(file);
      state = state.copyWith(isLoading: false);
      return true;
    } on Exception {
      return false;
    }
  }

  Future<bool> onTapRestore({
    required VoidCallback refresh,
  }) async {
    state = state.copyWith(isLoading: true);
    final storageRef = FirebaseStorage.instance.ref();
    final dbRef = storageRef.child('${state.user!.uid}.db');

    File file = File(await TodoDatabase.databasePath);
    try {
      await TodoDatabase.restoreDatabase(dbRef.writeToFile(file));
      refresh();

      state = state.copyWith(isLoading: false);
      return true;
    } on Exception {
      return false;
    }
  }

  Future<UserCredential> _signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    if (googleAuth == null) {
      throw LoginException('ログインに失敗しました');
    }

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    final result = await FirebaseAuth.instance.signInWithCredential(credential);

    return result;
  }
}

@freezed
class SignInState with _$SignInState {
  const factory SignInState({
    @Default(false) bool isLoading,
    @Default(null) User? user,
  }) = _SignInState;
}

class LoginException implements Exception {
  final String message;

  LoginException(this.message);

  @override
  String toString() => message;
}
