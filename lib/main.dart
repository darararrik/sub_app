import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sub_app/core/cubit/sub_pick_cubit.dart';
import 'package:sub_app/core/service_locator.dart';
import 'package:sub_app/core/bloc/project_bloc.dart';
import 'package:sub_app/screens/projects/projects_screen.dart';
import 'package:sub_app/core/theme.dart';

void main() {
  // Настройка GetIt
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
        BlocProvider(create: (context) => getIt<SubPickCubit>()),
      ],
      child: MaterialApp(
        title: 'SubApp',
        theme: lightTheme,
        home: const ProjectsScreen(),
      ),
    );
  }
}
