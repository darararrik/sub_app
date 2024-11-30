import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:realm/realm.dart';
import 'package:sub_app/repositories/model/project/project_model.dart';
import 'package:sub_app/repositories/project_repo/project_repo_interface.dart';
import 'package:subtitle/subtitle.dart';
part 'project_event.dart';
part 'project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  final IProjectRepo repo;
  ProjectBloc(this.repo) : super(ProjectInitial()) {
    on<AddProjectEvent>(_onAddProject);
    //TODO: сделать для каждого свой блок по хорошему
    on<LoadSubtitlesEvent>(_onLoadSubtitles);
    on<LoadProjectsEvent>(_onLoadProjects);
  }
  // Логика добавления проекта
  Future<void> _onAddProject(
      AddProjectEvent event, Emitter<ProjectState> emit) async {
    try {
      final newProject = Project(ObjectId().toString(), event.name,
          subtitleFilePath: event.subtitleFilePath, translatedSubtitles: []);
      repo.createProject(newProject);

      emit(ProjectAddedState());
    } catch (e) {
      emit(ProjectErrorState(errorMessage: 'Ошибка сохранения проекта: $e'));
    }
  }

  // Логика загрузки субтитров
  Future<void> _onLoadSubtitles(
      LoadSubtitlesEvent event, Emitter<ProjectState> emit) async {
    try {
      final file = File(event.filePath);
      final content = await file.readAsString();

      final controller = SubtitleController(
        provider: SubtitleProvider.fromString(
          data: content,
          type: SubtitleType.srt,
        ),
      );

      await controller.initial();
      emit(SubtitlesLoadedState(subtitles: controller.subtitles));
    } catch (e) {
      emit(ProjectErrorState(errorMessage: 'Ошибка загрузки субтитров: $e'));
    }
  }

  // Обработка события LoadProjectsEvent
  Future<void> _onLoadProjects(
      LoadProjectsEvent event, Emitter<ProjectState> emit) async {
    try {
      final projects = repo.getAllProjects();
      emit(ProjectsLoadedState(projects: projects));
    } catch (e) {
      emit(ProjectErrorState(errorMessage: 'Ошибка загрузки проектов: $e'));
    }
  }
}
