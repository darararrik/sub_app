import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sub_app/core/service_locator.dart';
import 'package:sub_app/core/bloc/project_bloc.dart';
import 'package:sub_app/screens/projects/projects_screen.dart';
import 'package:sub_app/core/theme.dart';

void main() {
  // Настройка GetIt
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Получение ProjectBloc через GetIt
        BlocProvider(create: (context) => getIt<ProjectBloc>()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: lightTheme,
        home: const ProjectsScreen(),
      ),
    );
  }
}
