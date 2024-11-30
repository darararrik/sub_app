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

class SaveSubtitlesToFile extends SubtitlesEvent {}