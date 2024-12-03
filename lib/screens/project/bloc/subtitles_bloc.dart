import 'dart:async';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sub_app/repositories/project_repo/project_repo_interface.dart';
import 'package:subtitle/subtitle.dart';
import 'subtitles_event.dart';
import 'subtitles_state.dart';

class SubtitlesBloc extends Bloc<SubtitlesEvent, SubtitlesState> {
  final IProjectRepo repo;

  SubtitlesBloc(this.repo) : super(SubtitlesInitial()) {
    on<LoadSubtitles>(_loadSubtitles);
    on<SaveSubtitlesToFile>(_localeSave);
  }

  // Сохранение переведённых субтитров
  FutureOr<void> _localeSave(SaveSubtitlesToFile event, emit) async {
    if (state is SubtitlesLoaded) {
      try {
        final project = event.project;
        final loadedState = state as SubtitlesLoaded;
        final Map<String, String> updatedTranslations = {
          for (var entry in event.translatedData.entries)
            entry.key.toString(): entry.value
        };

        // Сохраняем перевод в проект
        repo.updateTranslationProgress(
            project, updatedTranslations, "В процессе");
      } catch (e) {
        emit(SubtitlesError('Ошибка при сохранении файла: $e'));
      }
    }
  }

  // Загрузка субтитров (английских и русских)
  FutureOr<void> _loadSubtitles(LoadSubtitles event, emit) async {
    try {
      emit(Loading());
      final engSubtitlesPath = event.project.engSubtitleFilePath;
      final directory = await getExternalStorageDirectory();
      if (directory == null) {
        emit(SubtitlesError('Не удалось получить директорию для субтитров'));
        return;
      }
      final engFile = File(engSubtitlesPath);
      if (!await engFile.exists()) {
        emit(SubtitlesError('Не удалось найти английские субтитры'));
        return;
      }
      final engSubtitlesData = await engFile.readAsString();
      // Создание контроллеров для субтитров
      var controller = SubtitleController(
        provider: SubtitleProvider.fromString(
          data: engSubtitlesData,
          type: SubtitleType.srt,
        ),
      );
      await controller.initial();
      emit(SubtitlesLoaded(controller.subtitles, event.project));
    } catch (e) {
      emit(SubtitlesError('Ошибка при загрузке субтитров: $e'));
    }
  }
}
