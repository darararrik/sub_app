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
    on<SaveSubtitlesToFile>(_save);
  }

  // Сохранение переведённых субтитров
  FutureOr<void> _save(SaveSubtitlesToFile event, emit) async {
    if (state is SubtitlesLoaded) {
      try {
        final project = event.project; // Объект текущего проекта
        final loadedState = state as SubtitlesLoaded;
        final StringBuffer buffer = StringBuffer();
        String translation;
        Map<String, String> updatedTranslations = {};

        for (var subtitle in loadedState.engSubtitles) {
          translation = event.translatedData[subtitle.index - 1] ?? "";
          updatedTranslations[subtitle.index.toString()] = translation;

          buffer.writeln(subtitle.index);
          buffer.writeln('${subtitle.start} --> ${subtitle.end}');
          buffer.writeln(translation.isNotEmpty ? translation : subtitle.data);
          buffer.writeln();
        }

        final directory = await getDownloadsDirectory();
        if (directory != null) {
          final file = File('${directory.path}/${project.name}.srt');
          await file.writeAsString(buffer.toString(), mode: FileMode.write);

          // Обновление прогресса перевода в репозитории
          repo.updateTranslationProgress(
              project, updatedTranslations, "В процессе");
          emit(SubtitlesSaved());
        } else {
          emit(SubtitlesError('Не удалось получить директорию для хранения'));
        }
      } catch (e) {
        emit(SubtitlesError('Ошибка при сохранении файла: $e'));
      }
    }
  }

  // Загрузка субтитров (английских и русских)
  FutureOr<void> _loadSubtitles(LoadSubtitles event, emit) async {
    try {
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
