import 'package:equatable/equatable.dart';
import 'package:sub_app/repositories/model/project/project_model.dart';
import 'package:subtitle/subtitle.dart';

abstract class SubtitlesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SubtitlesInitial extends SubtitlesState {}

class SubtitlesLoaded extends SubtitlesState {
  final List<Subtitle> engSubtitles;
  final Project project;

  SubtitlesLoaded(
    this.engSubtitles,
    this.project,
  );

  @override
  List<Object?> get props => [engSubtitles, project];
}

class Loading extends SubtitlesState {}

class SubtitlesSaved extends SubtitlesState {}

class SubtitlesError extends SubtitlesState {
  final String message;

  SubtitlesError(this.message);

  @override
  List<Object?> get props => [message];
}

