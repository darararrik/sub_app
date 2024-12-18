import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sub_app/screens/auth/sign_in_screen.dart';
import 'package:sub_app/screens/auth/sign_up_screen.dart';
import 'package:sub_app/screens/change_password_screen/change_password_screen.dart';
import 'package:sub_app/screens/delete_account/delete_account_screen.dart';
import 'package:sub_app/screens/new_project/new_project_screen.dart';
import 'package:sub_app/screens/profile/profile_screen.dart';
import 'package:sub_app/screens/project/project_screen.dart';
import 'package:sub_app/screens/projects/projects_screen.dart';
import 'package:sub_app/screens/start/start.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/', // начальный экран
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const ProjectsScreen(),
      routes: [
        GoRoute(
          path: 'newproject',
          builder: (context, state) => const NewProjectScreen(),
        ),
        GoRoute(
          path: 'start',
          builder: (context, state) => const StartScreen(),
        ),
        GoRoute(
          path: 'project',
          builder: (context, state) {
            final id = state.extra as String;
            return ProjectScreen(projectId: id);
          },
        ),
        GoRoute(
          path: 'signin',
          builder: (context, state) => const SignInScreen(),
        ),
        GoRoute(
          path: 'signup',
          builder: (context, state) => SignUpScreen(),
        ),
        GoRoute(
          path: 'profile',
          builder: (context, state) => const ProfileScreen(),
          routes: [
            GoRoute(
              path: 'delete', // Это теперь относительный путь к /profile/delete
              builder: (context, state) => DeleteAccountScreen(),
            ),
            GoRoute(
              path:
                  'changepassword', // Это теперь относительный путь к /profile/changepassword
              builder: (context, state) => ChangePasswordScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
