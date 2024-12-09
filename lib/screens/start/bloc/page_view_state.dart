// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'page_view_bloc.dart';

sealed class OnbordingState extends Equatable {
  const OnbordingState();

  @override
  List<Object> get props => [];
}

final class OnbordingInitial extends OnbordingState {}

class OnbordingUpdated extends OnbordingState {
  int pageIndex;
  OnbordingUpdated({
    required this.pageIndex,
  });
}

class OnbordingSkipped extends OnbordingState {}

class OnbordingUpdating extends OnbordingState {}

class StartOnbording extends OnbordingState {}
