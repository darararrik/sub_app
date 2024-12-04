import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class User {
  final String id;
  final String email;
  final String displayName;
  final String photoURL;

  User({
    required this.id,
    required this.email,
    required this.displayName,
    required this.photoURL,
  });

  // Создание User из FirebaseAuth User
  factory User.fromFirebaseUser(firebase_auth.User user) {
    return User(
      id: user.uid,
      email: user.email ?? '',
      displayName: user.displayName ?? '',
      photoURL: user.photoURL ?? '',
    );
  }

  // Преобразование User в JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'displayName': displayName,
      'photoURL': photoURL,
    };
  }
}
