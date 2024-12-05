import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sub_app/repositories/auth_repo/auth_repo_interface.dart';

class AuthRepository implements IAuthRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AuthRepository({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  static const String defaultAvatarUrl =
      'https://firebasestorage.googleapis.com/v0/b/yourevent0app.appspot.com/o/Avatar.png?alt=media&token=59055445-530a-490c-9101-265c307ecfd4';

  @override
  Future<User?> createUser(
      {required String email, required String password}) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCredential.user?.sendEmailVerification();
      return userCredential.user;
    } catch (e) {
      _handleAuthError(e);
    }
    return null;
  }

  @override
  Future<void> updateName({required String name}) async {
    try {
      final firebaseUser = await getCurrentUser();
      if (firebaseUser != null) {
        await _firestore
            .collection('users')
            .doc(firebaseUser.uid)
            .update({'name': name});
      } else {
        throw Exception('Пользователь не найден');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> saveUserDataToFirestore({required String email}) async {
    try {
      final firebaseUser = _firebaseAuth.currentUser;
      if (firebaseUser != null) {
        await firebaseUser.updatePhotoURL(defaultAvatarUrl);
        await _firestore.collection('users').doc(firebaseUser.uid).set({
          'uid': firebaseUser.uid,
          'email': email,
          'avatarUrl': defaultAvatarUrl,
        });
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateEmail(
      {required String email, required String currentPassword}) async {
    try {
      final firebaseUser = await getCurrentUser();
      if (firebaseUser != null) {
        AuthCredential credential = EmailAuthProvider.credential(
          email: firebaseUser.email!,
          password: currentPassword,
        );
        await firebaseUser.reauthenticateWithCredential(credential);
        await firebaseUser.verifyBeforeUpdateEmail(email);
        await _firestore
            .collection('users')
            .doc(firebaseUser.uid)
            .set({'email': email}, SetOptions(merge: true));
      }
    } catch (e) {
      _handleAuthError(e);
    }
  }

  @override
  Future<User?> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      _handleAuthError(e);
    }
    return null;
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<User?> getCurrentUser() async {
    User? firebaseUser = _firebaseAuth.currentUser;
    await firebaseUser?.reload();
    return firebaseUser;
  }

  void _handleAuthError(dynamic e) {
    if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'email-already-in-use':
          throw FirebaseAuthException(
              message: 'Электронная почта уже используется.', code: e.code);
        case 'weak-password':
          throw FirebaseAuthException(message: 'Слабый пароль.', code: e.code);
        case 'invalid-email':
          throw FirebaseAuthException(
              message: 'Некорректный формат почты.', code: e.code);
        case 'wrong-password':
          throw FirebaseAuthException(
              message: 'Неправильный пароль.', code: e.code);
        case 'user-not-found':
          throw FirebaseAuthException(
              message: 'Пользователь не найден.', code: e.code);
        case 'too-many-requests':
          throw FirebaseAuthException(message: 'Много запросов.', code: e.code);
        default:
          throw FirebaseAuthException(
              message: 'Произошла ошибка.', code: e.code);
      }
    } else {
      throw Exception('Неизвестная ошибка: $e');
    }
  }

  @override
  Future<void> updatePassword(
      {required String newPassword, required String currentPassword}) async {
    try {
      final User? firebaseUser = await getCurrentUser();

      if (firebaseUser != null) {
        AuthCredential credential = EmailAuthProvider.credential(
          email: firebaseUser.email!,
          password: currentPassword,
        );

        await firebaseUser.reauthenticateWithCredential(credential);
        await firebaseUser.updatePassword(newPassword);
        debugPrint('Пароль успешно обновлен');
      } else {
        debugPrint('Ошибка: пользовательский объект null.');
      }
    } catch (e) {
      debugPrint('Ошибка при обновлении пароля: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteAccount({required String currentPassword}) async {
    try {
      final User? firebaseUser = await getCurrentUser();

      if (firebaseUser != null) {
        AuthCredential credential = EmailAuthProvider.credential(
          email: firebaseUser.email!,
          password: currentPassword,
        );

        await firebaseUser.reauthenticateWithCredential(credential);
        await firebaseUser.delete();
        debugPrint('Аккаунт успешно удален');
      } else {
        debugPrint('Ошибка: пользовательский объект null.');
      }
    } catch (e) {
      debugPrint('Ошибка при удалении аккаунта: $e');
      rethrow;
    }
  }
}
