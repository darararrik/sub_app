import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sub_app/core/cubit/sub_pick_cubit.dart';
import 'package:sub_app/core/service_locator.dart';
import 'package:sub_app/core/bloc/project_bloc.dart';
import 'package:sub_app/screens/new_project/cubit/pick_image_cubit.dart';
import 'package:sub_app/screens/profile/bloc/auth_bloc.dart';
import 'package:sub_app/screens/project/bloc/subtitles_bloc.dart';
import 'package:sub_app/screens/projects/projects_screen.dart';
import 'package:sub_app/core/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  // Ensure that Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupServiceLocator();
  runApp(const SubApp());
}

class SubApp extends StatelessWidget {
  const SubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Получение ProjectBloc через GetIt
        BlocProvider(create: (context) => getIt<ProjectBloc>()),
        BlocProvider(create: (context) => getIt<SubtitlesBloc>()),
        BlocProvider(create: (context) => getIt<PickImageCubit>()),
        BlocProvider(create: (context) => getIt<SubPickCubit>()),
        BlocProvider(create: (context) => getIt<AuthBloc>()),
      ],
      child: MaterialApp(
        title: 'SubApp',
        theme: lightTheme,
        home: const ProjectsScreen(),
      ),
    );
  }
}
