part of 'project_bloc.dart';

sealed class ProjectState extends Equatable {}

final class ProjectInitial extends ProjectState {
  @override
  List<Object?> get props => [];
}

// Состояние при добавлении проекта
class ProjectAddedState extends ProjectState {
  @override
  List<Object?> get props => [];
}

// Состояние ошибки
class ProjectErrorState extends ProjectState {
  final String errorMessage;

  ProjectErrorState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

// Состояние для отображения списка проектов
class ProjectsLoadedState extends ProjectState {
  final List<Project> projectsN;
  final List<Project> projectsT;
  final List<Project> projectsI;

  ProjectsLoadedState({
    required this.projectsN,
    required this.projectsT,
    required this.projectsI,
  });

  @override
  List<Object?> get props => [projectsN, projectsT, projectsI];
}

class ProjectLoadingState extends ProjectState {
  @override
  List<Object?> get props => [];
}

class ProjectSaved extends ProjectState {
  @override
  List<Object?> get props => [];
}

class UpdateProgressStatus extends ProjectEvent {
  final Project project;
  final String status;
  UpdateProgressStatus({
    required this.status,
    required this.project,
  });
  @override
  List<Object?> get props => [project];
}

class ProjectsEmptyState extends ProjectState {
  @override
  List<Object?> get props => [];
}

class ProjectDeleted extends ProjectState {
  @override
  List<Object?> get props => [];
}
