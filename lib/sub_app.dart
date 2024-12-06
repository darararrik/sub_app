import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sub_app/core/bloc/project_bloc.dart';
import 'package:sub_app/core/cubit/sub_pick_cubit.dart';
import 'package:sub_app/core/service_locator.dart';
import 'package:sub_app/core/theme.dart';
import 'package:sub_app/router.dart';
import 'package:sub_app/screens/new_project/cubit/pick_image_cubit.dart';
import 'package:sub_app/screens/profile/bloc/auth_bloc.dart';
import 'package:sub_app/screens/project/bloc/subtitles_bloc.dart';
import 'package:sub_app/screens/project/cubit/card_subtitle_cubit.dart';

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
        BlocProvider(create: (context) => getIt<CardSubtitleCubit>()),
      ],
      child: MaterialApp.router(
        routerConfig: appRouter,
        title: 'SubApp',
        theme: lightTheme,
      ),
    );
  }
}