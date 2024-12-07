import 'dart:async';
import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sub_app/repositories/model/project/project_model.dart';
import 'package:sub_app/repositories/project_repo/project_repo_interface.dart';
import 'package:subtitle/subtitle.dart';
part 'subtitles_event.dart';
part 'subtitles_state.dart';

class SubtitlesBloc extends Bloc<SubtitlesEvent, SubtitlesState> {
  final IProjectRepo repo;

  SubtitlesBloc(this.repo) : super(SubtitlesInitial()) {
    on<SaveSubtitlesToFile>(_fileSave);
    on<Save>(_localeSave);
    on<LoadSubtitles>(_loadSubtitles);
  }

  FutureOr<void> _localeSave(Save event, emit) async {
    if (state is SubtitlesLoaded) {
      try {
        final project = event.project;
        final Map<String, String> updatedTranslations = {
          for (var entry in event.translatedData.entries)
            entry.key.toString(): entry.value
        };
        final Map<String, String> syllTranslated = {
          for (var entry in event.syllablesTranslated.entries)
            entry.key.toString(): entry.value
        };
        final Map<String, String> syllNotTranslated = {
          for (var entry in event.syllablesNotTranslated.entries)
            entry.key.toString(): entry.value
        };
        // Сохраняем перевод в проект
        repo.updateTranslationProgress(project, updatedTranslations,
            "В процессе", syllTranslated, syllNotTranslated);
      } catch (e) {
        emit(SubtitlesError('Ошибка при сохранении файла: $e'));
      }
    }
  }

  // Загрузка субтитров (английских и русских)
  FutureOr<void> _loadSubtitles(LoadSubtitles event, emit) async {
    try {
      emit(Loading());
      final project = repo.getProject(event.projectId);
      if (project == null) {
        emit(SubtitlesError('Не удалось найти проект субтитры'));
      } else {
        final engSubtitlesPath = project.engSubtitleFilePath;
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
        var controller = SubtitleController(
          provider: SubtitleProvider.fromString(
            data: engSubtitlesData,
            type: SubtitleType.srt,
          ),
        );
        await controller.initial();
        final translatedWord = {
          for (var entry in project.translatedWords.entries)
            int.parse(entry.key): entry.value
        };
        final syllTranslated = {
          for (var entry in project.syllablesTranslated.entries)
            int.parse(entry.key): entry.value
        };
        final syllNotTranslated = {
          for (var entry in project.syllablesNotTranslated.entries)
            int.parse(entry.key): entry.value
        };
        emit(SubtitlesLoaded(controller.subtitles, translatedWord, project,
            syllTranslated, syllNotTranslated));
      }
    } catch (e) {
      emit(SubtitlesError('Ошибка при загрузке субтитров: $e'));
    }
  }

  FutureOr<void> _fileSave(
      SaveSubtitlesToFile event, Emitter<SubtitlesState> emit) async {
    try {
      final loadedState = state as SubtitlesLoaded;
      final StringBuffer buffer = StringBuffer();
      String translation;
      Map<String, String> updatedTranslations = {};

      for (var subtitle in loadedState.engSubtitles) {
        translation =
            event.project.translatedWords[(subtitle.index - 1).toString()] ??
                "";
        updatedTranslations[subtitle.index.toString()] = translation;

        buffer.writeln(subtitle.index);
        buffer.writeln('${subtitle.start} --> ${subtitle.end}');
        buffer.writeln(translation.isNotEmpty ? translation : subtitle.data);
        buffer.writeln();
      }
      final directory = await getDownloadsDirectory();
      if (directory != null) {
        final file = File('${directory.path}/${event.project.name}.srt');
        await file.writeAsString(buffer.toString(), mode: FileMode.write);
      }
      emit(SubtitlesSaved());
    } catch (e) {
      emit(SubtitlesError('Ошибка при сохранении файла: $e'));
    }
  }
}
