import 'package:equatable/equatable.dart';
import 'package:subtitle/subtitle.dart';

abstract class SubtitlesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SubtitlesInitial extends SubtitlesState {}

class SubtitlesLoaded extends SubtitlesState {
  final List<Subtitle> engSubtitles;
  final List<Subtitle>? ruSubtitles;

  SubtitlesLoaded(
    this.engSubtitles,
    this.ruSubtitles,
  );

  @override
  List<Object?> get props => [engSubtitles, ruSubtitles];
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
