import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:realm/realm.dart';
import 'package:sub_app/core/cubit/sub_pick_cubit.dart';
import 'package:sub_app/repositories/auth_repo/auth_repo.dart';
import 'package:sub_app/repositories/model/project/project_model.dart';
import 'package:sub_app/repositories/project_repo/project_repo.dart';
import 'package:sub_app/core/bloc/project_bloc.dart';
import 'package:sub_app/screens/new_project/cubit/pick_image_cubit.dart';
import 'package:sub_app/screens/profile/bloc/auth_bloc.dart';
import 'package:sub_app/screens/project/bloc/subtitles_bloc.dart';
import 'package:sub_app/screens/project/cubit/card_subtitle_cubit.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // Инициализация Realm
  final config = Configuration.local([Project.schema]);
  final realm = Realm(config);

  // Регистрация Realm
  getIt.registerSingleton<Realm>(realm);

  // Регистрация репозитория
  getIt.registerSingleton<ProjectRepo>(ProjectRepo(realm));
// Регистрация экземпляра FirebaseAuth
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  // Регистрация AuthRepository
  getIt.registerSingleton<AuthRepository>(
    AuthRepository(firebaseAuth: getIt<FirebaseAuth>()),
  );

  // Регистрация BLoC
  getIt.registerFactory(() => ProjectBloc(getIt<ProjectRepo>()));
  getIt.registerFactory(() => SubtitlesBloc(getIt<ProjectRepo>()));
  getIt.registerFactory(() => CardSubtitleCubit(getIt<ProjectRepo>()));

  // Регистрация SubPickCubit
  getIt.registerFactory(() => SubPickCubit());
  getIt.registerFactory(() => PickImageCubit());
  getIt.registerFactory(() => AuthBloc(getIt<AuthRepository>()));
}
