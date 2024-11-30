import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:realm/realm.dart';
import 'package:sub_app/repositories/model/project/project_model.dart';
import 'package:sub_app/repositories/project_repo/project_repo_interface.dart';

part 'project_event.dart';
part 'project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  final IProjectRepo repo;
  ProjectBloc(this.repo) : super(ProjectInitial()) {
    on<CreateProjectEvent>(_onCreateProject);
    on<GetAllProjectsEvent>(_onGetAllProjects);
  }
  // Логика добавления проекта
  void _onCreateProject(CreateProjectEvent event, Emitter<ProjectState> emit) {
    try {
      final imageBytes = event.imageFile.readAsBytesSync();
      final newProject = Project(ObjectId().toString(), event.name,
          engSubtitleFilePath: event.engSubtitleFilePath,
          translatedSubtitles: [],
          imageBytes: imageBytes);
      repo.createProject(newProject);
      emit(ProjectAddedState());
    } catch (e) {
      emit(ProjectErrorState(errorMessage: 'Ошибка сохранения проекта: $e'));
    }
  }

  // Обработка события LoadProjectsEvent
  Future<void> _onGetAllProjects(
      GetAllProjectsEvent event, Emitter<ProjectState> emit) async {
    try {
      if (state is! ProjectLoadingState) {
        emit(ProjectLoadingState());
      }
      final projects = repo.getAllProjects();
      emit(ProjectsLoadedState(projects: projects));
    } catch (e) {
      emit(ProjectErrorState(errorMessage: 'Ошибка загрузки проектов: $e'));
    } finally {
      event.completer?.isCompleted;
    }
  }
}
