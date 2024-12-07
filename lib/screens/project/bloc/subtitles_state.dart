part of 'subtitles_bloc.dart';

abstract class SubtitlesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SubtitlesInitial extends SubtitlesState {}

class SubtitlesLoaded extends SubtitlesState {
  final List<Subtitle> engSubtitles;
  final Map<int, String> translatedWords;
  final Map<int, String> syllablesTranslated;
  final Map<int, String> syllablesNotTranslated;

  final Project project;
  SubtitlesLoaded(
    this.engSubtitles,
    this.translatedWords,
    this.project,
    this.syllablesTranslated,
    this.syllablesNotTranslated,
  );

  @override
  List<Object?> get props => [
        engSubtitles,
        translatedWords,
        project,
        syllablesNotTranslated,
        syllablesTranslated
      ];
}

class Loading extends SubtitlesState {}

class SubtitlesError extends SubtitlesState {
  final String message;

  SubtitlesError(this.message);

  @override
  List<Object?> get props => [message];
}

class SubtitlesSaved extends SubtitlesState {}
