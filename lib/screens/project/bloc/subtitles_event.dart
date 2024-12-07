part of 'subtitles_bloc.dart';

abstract class SubtitlesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadSubtitles extends SubtitlesEvent {
  final String projectId;

  LoadSubtitles(this.projectId);

  @override
  List<Object?> get props => [projectId];
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
  SaveSubtitlesToFile({
    required this.project,
  });
  @override
  List<Object?> get props => [
        project,
      ];
}

class Save extends SubtitlesEvent {
  final Project project;
  final Map<int, String> translatedData;
  final Map<int, String> syllablesTranslated;

  final Map<int, String> syllablesNotTranslated;

  Save({
    required this.syllablesTranslated,
    required this.syllablesNotTranslated,
    required this.project,
    required this.translatedData,
  });
  @override
  List<Object?> get props =>
      [project, translatedData, syllablesNotTranslated, syllablesTranslated];
}
