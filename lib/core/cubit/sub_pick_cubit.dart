import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:subtitle/subtitle.dart';

part 'sub_pick_state.dart';

class SubPickCubit extends Cubit<SubPickState> {
  SubPickCubit() : super(SubPickInitial());

  Future<void> loadSubtitles(String filePath) async {
    try {
      emit(SubPickLoading());

      final file = File(filePath);
      final content = await file.readAsString();

      final controller = SubtitleController(
        provider: SubtitleProvider.fromString(
          data: content,
          type: SubtitleType.srt,
        ),
      );

      await controller.initial();

      emit(SubPickLoaded(subtitles: controller.subtitles));
    } catch (e) {
      emit(SubPickError(errorMessage: 'Ошибка загрузки субтитров: $e'));
    }
  }

  void resetState() {
    emit(SubPickInitial());
  }
}
