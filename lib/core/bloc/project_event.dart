part of 'project_bloc.dart';

sealed class ProjectEvent extends Equatable {}

// Событие для добавления проекта
class AddProjectEvent extends ProjectEvent {
  final String name;
  final String subtitleFilePath;

  AddProjectEvent({required this.name, required this.subtitleFilePath});

  @override
  List<Object?> get props => [name, subtitleFilePath];
}

// Событие для загрузки субтитров
class LoadSubtitlesEvent extends ProjectEvent {
  final String filePath;

  LoadSubtitlesEvent({required this.filePath});

  @override
  List<Object?> get props => [filePath];
}

// Событие для загрузки списка проектов
class LoadProjectsEvent extends ProjectEvent {
  @override
  List<Object?> get props => [];
}
