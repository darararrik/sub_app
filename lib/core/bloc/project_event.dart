part of 'project_bloc.dart';

sealed class ProjectEvent extends Equatable {}

// Событие для добавления проекта
class CreateProjectEvent extends ProjectEvent {
  final String name;
  final String subtitleFilePath;
  final String status;
  CreateProjectEvent({
    required this.name,
    required this.subtitleFilePath,
    required this.status,
  });

  @override
  List<Object?> get props => [name, subtitleFilePath, status];
}

// Событие для загрузки списка проектов
class GetAllProjectsEvent extends ProjectEvent {
  final Completer? completer;
  GetAllProjectsEvent({
    required this.completer,
  });
  @override
  List<Object?> get props => [completer];
}
