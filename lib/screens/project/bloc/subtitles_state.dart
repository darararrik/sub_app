import 'package:equatable/equatable.dart';
import 'package:subtitle/subtitle.dart';

abstract class SubtitlesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SubtitlesInitial extends SubtitlesState {}

class SubtitlesLoaded extends SubtitlesState {
  final List<Subtitle> subtitles;
  final Map<String, String> translations;
  SubtitlesLoaded(this.subtitles, this.translations);

  @override
  List<Object?> get props => [subtitles, translations];
}

class SubtitlesSaving extends SubtitlesState {}

class SubtitlesSaved extends SubtitlesState {}

class SubtitlesError extends SubtitlesState {
  final String message;

  SubtitlesError(this.message);

  @override
  List<Object?> get props => [message];
}

class SubtitlesLoadingState extends SubtitlesState {}
