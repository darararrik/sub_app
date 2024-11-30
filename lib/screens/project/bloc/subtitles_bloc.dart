import 'dart:async';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sub_app/repositories/project_repo/project_repo_interface.dart';
import 'package:subtitle/subtitle.dart';
import 'subtitles_event.dart';
import 'subtitles_state.dart';

class SubtitlesBloc extends Bloc<SubtitlesEvent, SubtitlesState> {
  final IProjectRepo repo;
  SubtitlesBloc(this.repo) : super(SubtitlesInitial()) {
    on<LoadSubtitles>(_loadSubtitles);

    on<UpdateTranslation>(_update);

    // on<SaveSubtitlesToFile>(_save);
  }

  FutureOr<void> _update(event, emit) {
    if (state is SubtitlesLoaded) {
      final loadedState = state as SubtitlesLoaded;
      final updatedTranslations =
          Map<String, String>.from(loadedState.translations);

      // Обновляем перевод для указанного индекса
      updatedTranslations[event.index.toString()] = event.translation;

      // Эмитим новое состояние с обновленным переводом
      emit(SubtitlesLoaded(loadedState.subtitles, updatedTranslations));
    }
  }

  // FutureOr<void> _save(event, emit) async {
  //   if (state is SubtitlesLoaded) {
  //     emit(SubtitlesSaving());
  //     try {
  //       final loadedState = state as SubtitlesLoaded;
  //       final StringBuffer buffer = StringBuffer();

  //       for (var subtitle in loadedState.subtitles) {
  //         buffer.writeln(subtitle.index);
  //         buffer.writeln('${subtitle.start} --> ${subtitle.end}');
  //         buffer.writeln(subtitle.data);
  //         buffer.writeln(loadedState.translations[subtitle.index] ?? '');
  //         buffer.writeln();
  //       }

  //       final directory = await getExternalStorageDirectory();
  //       if (directory != null) {
  //         final file = File('${directory.path}/translated_subtitles.srt');
  //         await file.writeAsString(buffer.toString(), mode: FileMode.write);
  //         emit(SubtitlesSaved());
  //       } else {
  //         emit(SubtitlesError('Не удалось получить директорию для хранения'));
  //       }
  //     } catch (e) {
  //       emit(SubtitlesError('Ошибка при сохранении файла: $e'));
  //     }
  //   }
  // }

  FutureOr<void> _loadSubtitles(LoadSubtitles event, emit) async {
    try {
      emit(SubtitlesLoadingState());

      final subtitlesPath = event.project.engSubtitleFilePath;
      // Загружаем содержимое файла субтитров
      final subtitlesData = await File(subtitlesPath).readAsString();

      // Создаём SubtitleController
      var controller = SubtitleController(
        provider: SubtitleProvider.fromString(
          data: subtitlesData,
          type: SubtitleType.srt,
        ),
      );
      await controller.initial();
      emit(SubtitlesLoaded(controller.subtitles, const {}));
    } catch (e) {
      emit(SubtitlesError('Ошибка при загрузке субтитров: $e'));
    }
  }
}
