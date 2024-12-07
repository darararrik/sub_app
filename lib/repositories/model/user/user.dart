import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:sub_app/core/enum/status.dart';
import 'package:sub_app/core/utils/get_it.dart';
import 'package:sub_app/repositories/project_repo/project_repo.dart';
import 'package:sub_app/repositories/project_repo/project_repo_interface.dart';

class User {
  final String id;
  final String email;
  final String displayName;
  final String photoURL;
  final int createdProjects;
  final int projects;
  final int translatedProjects;
  final int inProgressProjects;

  User({
    required this.id,
    required this.email,
    required this.displayName,
    required this.photoURL,
    required this.projects,
    required this.createdProjects,
    required this.translatedProjects,
    required this.inProgressProjects,
  });

  // Создание User из FirebaseAuth User
  factory User.fromFirebaseUser(firebase_auth.User user) {
    IProjectRepo repo = getIt<ProjectRepo>();

    final projects = repo.getAllProjects();
    final projectsI = projects
        .where((project) => project.status == Status.inProgress.displayName)
        .toList();
    final projectsT = projects
        .where((project) => project.status == Status.completed.displayName)
        .toList();
    return User(
      id: user.uid,
      email: user.email ?? '',
      displayName: user.displayName ?? '',
      photoURL: user.photoURL ?? '',
      createdProjects: repo.getTotalProjectsCreated(),
      translatedProjects: projectsT.length,
      inProgressProjects: projectsI.length,
      projects: projects.length,
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
