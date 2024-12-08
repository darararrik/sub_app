import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sub_app/core/bloc/project_bloc.dart';
import 'package:sub_app/core/cubit/sub_pick_cubit.dart';
import 'package:sub_app/core/utils/get_it.dart';
import 'package:sub_app/core/utils/theme.dart';
import 'package:sub_app/router.dart';
import 'package:sub_app/screens/new_project/cubit/pick_image_cubit.dart';
import 'package:sub_app/screens/profile/bloc/auth_bloc.dart';
import 'package:sub_app/screens/project/bloc/subtitles_bloc.dart';
import 'package:sub_app/screens/project/cubit/card_subtitle_cubit.dart';
import 'package:sub_app/screens/start/bloc/page_view_bloc.dart';

class SubApp extends StatelessWidget {
  const SubApp({
    super.key,
  });
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
        BlocProvider(
          create: (context) =>
              getIt<OnbordingBloc>()..add(OnbordingCheckFirstLaunch()),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: appRouter,
        title: 'SubApp',
        theme: lightTheme,
      ),
    );
  }
}
