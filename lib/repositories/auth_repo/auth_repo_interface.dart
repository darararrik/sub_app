import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthRepository {
  Future<User?> createUser({required String email, required String password});
  Future<void> updateName({required String name});
  Future<void> saveUserDataToFirestore({required String email});
  Future<void> updateEmail(
      {required String email, required String currentPassword});
  Future<User?> signInWithEmailAndPassword(
      {required String email, required String password});
  Future<void> signOut();
  Future<User?> getCurrentUser();
  Future<void> updatePassword(
      {required String newPassword, required String currentPassword});
  Future<void> deleteAccount({required String currentPassword});
}
