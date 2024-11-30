import 'package:get_it/get_it.dart';
import 'package:realm/realm.dart';
import 'package:sub_app/repositories/model/project/project_model.dart';
import 'package:sub_app/repositories/project_repo/project_repo.dart';
import 'package:sub_app/core/bloc/project_bloc.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // Инициализация Realm
  final config = Configuration.local([Project.schema]);
  final realm = Realm(config);

  // Регистрация Realm
  getIt.registerSingleton<Realm>(realm);

  // Регистрация репозитория
  getIt.registerSingleton<ProjectRepo>(ProjectRepo(realm));

  // Регистрация BLoC
  getIt.registerFactory(() => ProjectBloc(getIt<ProjectRepo>()));
}
