import 'package:sub_app/repositories/model/project/project_model.dart';

abstract interface class IProjectRepo {
  void createProject(Project newProject);
  void deleteProject(Project project);
  void deleteAllProjects();
  List<Project> getAllProjects();
  Project? getProject(String projectId);
  void updateTranslationProgress(
      Project project, Map<String, String> translations, String status);
  void updateProgressStatus(Project project, String status);
  void updateExpansionState(
    Project project,
    Map<String, bool> isExpanded,
  );
}
