import 'package:equatable/equatable.dart';

import 'package:sub_app/repositories/model/project/project_model.dart';

abstract class SubtitlesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadSubtitles extends SubtitlesEvent {
  final Project project;

  LoadSubtitles(this.project);

  @override
  List<Object?> get props => [project];
}

class UpdateTranslation extends SubtitlesEvent {
  final int index;
  final String translation;

  UpdateTranslation(this.index, this.translation);

  @override
  List<Object?> get props => [index, translation];
}

class SaveSubtitlesToFile extends SubtitlesEvent {
  final Project project;
  final Map<int, String> translatedData;
  SaveSubtitlesToFile({
    required this.project,
    required this.translatedData,
  });
  @override
  List<Object?> get props => [project, translatedData];
}

class Save extends SubtitlesEvent {
  final Project project;
  Save({
    required this.project,
  });
}
