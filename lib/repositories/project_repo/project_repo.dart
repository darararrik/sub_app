import 'package:realm/realm.dart';
import 'package:sub_app/repositories/model/project/project_model.dart';
import 'package:sub_app/repositories/project_repo/project_repo_interface.dart';

class ProjectRepo implements IProjectRepo {
  final Realm realm;

  ProjectRepo(this.realm);

  /// Создать новый проект
  @override
  void createProject(Project newProject) {
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

  /// Обновить проект
  @override
  void updateProject(Project project, {String? newName, String? newFilePath}) {
    realm.write(() {
      if (newName != null) {
        project.name = newName;
      }
      if (newFilePath != null) {
        project.subtitleFilePath = newFilePath;
      }
    });
  }
}
