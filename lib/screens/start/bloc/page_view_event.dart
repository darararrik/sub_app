// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'page_view_bloc.dart';

sealed class OnbordingEvent extends Equatable {
  const OnbordingEvent();

  @override
  List<Object> get props => [];
}

class OnbordingChanged extends OnbordingEvent {
  int index;
  OnbordingChanged({
    required this.index,
  });
}
class OnbordingCompleted extends OnbordingEvent {}
class OnbordingCheckFirstLaunch extends OnbordingEvent {}