import 'package:sub_app/repositories/model/project/project_model.dart';

abstract interface class IProjectRepo {
  void createProject(Project newProject);
  void deleteProject(Project project);
  void deleteAllProjects();
  List<Project> getAllProjects();
  void updateProject(Project project, {String? newName, String? newFilePath});
}
