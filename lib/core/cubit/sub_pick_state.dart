part of 'sub_pick_cubit.dart';

abstract class SubPickState extends Equatable {
  const SubPickState();

  @override
  List<Object> get props => [];
}

class SubPickInitial extends SubPickState {}

class SubPickLoading extends SubPickState {}

class SubPickLoaded extends SubPickState {
  final List<Subtitle> subtitles;
  const SubPickLoaded({required this.subtitles});

  @override
  List<Object> get props => [subtitles];
}

class SubPickError extends SubPickState {
  final String errorMessage;
  const SubPickError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
