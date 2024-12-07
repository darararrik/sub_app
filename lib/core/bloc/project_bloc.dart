import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:realm/realm.dart';
import 'package:sub_app/core/enum/status.dart';
import 'package:sub_app/repositories/model/project/project_model.dart';
import 'package:sub_app/repositories/project_repo/project_repo_interface.dart';

part 'project_event.dart';
part 'project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  final IProjectRepo repo;
  ProjectBloc(this.repo) : super(ProjectInitial()) {
    on<CreateProjectEvent>(_onCreateProject);
    on<GetAllProjectsEvent>(_onGetAllProjects);
    on<UpdateProgressStatus>(_updateStatus);
    on<DeleteProject>(_onDeleteProject);
  }
  // Логика добавления проекта
  Future<void> _onCreateProject(
      CreateProjectEvent event, Emitter<ProjectState> emit) async {
    try {
      final Iterable<int> imageBytes;
      if (event.imageFile == null) {
        ByteData data = await rootBundle.load("assets/placeholder.png");
        imageBytes = data.buffer.asUint8List();
      } else {
        imageBytes = event.imageFile!.readAsBytesSync();
      }

      final newProject = Project(
        ObjectId().toString(),
        event.name,
        event.engSubtitleFilePath,
        imageBytes: imageBytes,
      );
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
      // Отображаем состояние загрузки, только если текущее состояние не загрузка
      if (state is! ProjectLoadingState) {
        emit(ProjectLoadingState());
      }

      // Получаем проекты из репозитория
      final projects = repo.getAllProjects();

      // Проверяем, пуст ли список
      if (projects.isEmpty) {
        emit(ProjectsEmptyState());
      } else {
        // Разделяем проекты по статусу
        final projectsN = projects
            .where(
                (project) => project.status == Status.notTranslated.displayName)
            .toList();
        final projectsI = projects
            .where((project) => project.status == Status.inProgress.displayName)
            .toList();
        final projectsT = projects
            .where((project) => project.status == Status.completed.displayName)
            .toList();

        // Эмитируем состояние с загруженными проектами
        emit(ProjectsLoadedState(
          projectsN: projectsN,
          projectsI: projectsI,
          projectsT: projectsT,
        ));
      }
    } catch (e) {
      // Эмитируем состояние ошибки
      emit(ProjectErrorState(errorMessage: 'Ошибка загрузки проектов: $e'));
    } finally {
      // Завершаем выполнение через Completer, если он задан
      event.completer?.complete();
    }
  }

  FutureOr<void> _updateStatus(
      UpdateProgressStatus event, Emitter<ProjectState> emit) {
    try {
      if (state is! ProjectLoadingState) {
        emit(ProjectLoadingState());
      }
      repo.updateProgressStatus(event.project, event.status);
      final projects = repo.getAllProjects();
      if (projects.isEmpty) {
        emit(ProjectInitial());
      } else {
        final projectsN = projects
            .where(
                (project) => project.status == Status.notTranslated.displayName)
            .toList();
        final projectsI = projects
            .where((project) => project.status == Status.inProgress.displayName)
            .toList();
        final projectsT = projects
            .where((project) => project.status == Status.completed.displayName)
            .toList();
        emit(ProjectsLoadedState(
            projectsI: projectsI, projectsT: projectsT, projectsN: projectsN));
      }
    } catch (e) {
      emit(ProjectErrorState(errorMessage: 'Ошибка при удалении файла: $e'));
    }
  }

  FutureOr<void> _onDeleteProject(
      DeleteProject event, Emitter<ProjectState> emit) async {
    try {
      repo.deleteProject(event.project);
      emit(ProjectDeleted());
    } catch (e) {
      emit(ProjectErrorState(errorMessage: 'Ошибка при удалении файла: $e'));
    }
  }
}
