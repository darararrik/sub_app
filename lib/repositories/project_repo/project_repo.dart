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

  @override
  Project? getProject(String projectId) {
    return realm.find(projectId);
  }

  @override
  void updateTranslationProgress(
      Project project, Map<String, String> translations, String status) {
    try {
      // Открытие транзакции Realm
      realm.write(() {
        // Обновляем переведенные данные и статус проекта
        project.translatedWords.addAll(translations);
        project.status = status;

        // Обновляем проект в базе данных
        realm.add(project, update: true);
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  void updateProgressStatus(Project project, String status) {
    try {
      realm.write(() {
        project.status = status;
        realm.add(project, update: true);
      });
    } catch (e) {
      rethrow;
    }
  }

  /// Обновить состояние раскрытия строк
  @override
  void updateExpansionState(Project project, Map<String, bool> isExpanded) {
    realm.write(() {
      project.isExpanded.addAll(isExpanded);
      realm.add(project, update: true); // Записываем изменения
    });
  }
}
