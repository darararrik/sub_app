import 'package:realm/realm.dart';
import 'package:sub_app/repositories/model/project/project_model.dart';
import 'package:sub_app/repositories/project_repo/project_repo_interface.dart';

class ProjectRepo implements IProjectRepo {
  final Realm realm;

  ProjectRepo(this.realm);

  /// Создать новый проект
  @override
  Future<void> createProject(Project newProject) async {
    realm.write(() => realm.add(newProject));
  }

  /// Удалить все проекты
  @override
  void deleteAllProjects() {
    realm.write(() => realm.deleteMany(realm.all<Project>()));
  }

  /// Удалить конкретный проект
  @override
  void deleteProject(Project project) {
    realm.write(() => realm.delete(project));
  }

  /// Получить все проекты
  @override
  List<Project> getAllProjects() {
    return realm.all<Project>().toList();
  }

  @override
  Project? getProject(Project project) {
    return realm.find(project.id);
  }

  /// Обновить проект
  @override
  void updateProject(Project project, {String? newName, String? newFilePath}) {
    realm.write(() {
      if (newName != null) {
        project.name = newName;
      }
      if (newFilePath != null) {
        project.engSubtitleFilePath = newFilePath;
      }
    });
  }
}
    // Получаем директорию для сохранения файла
    // final appDocDir = await getApplicationDocumentsDirectory();
    // final newSubtitlePath = '${appDocDir.path}/subtitles/${newProject.id}.srt';

    // // Создаём папку, если она ещё не существует
    // final subtitleDir = Directory('${appDocDir.path}/subtitles');
    // if (!await subtitleDir.exists()) {
    //   await subtitleDir.create();
    // }
    // Копируем файл субтитров из оригинального местоположения в защищённую папку
    // try {
    //   final subtitleFile = File(newProject.engSubtitleFilePath!);
    //   if (await subtitleFile.exists()) {
    //     // Копирование файла
    //     await subtitleFile.copy(newSubtitlePath);
    //   }
    // } on PlatformException catch (e) {
    //   // Обработка ошибок
    //   debugPrint("Ошибка при копировании файла: $e");
    // }

    // Сохраняем проект в Realm