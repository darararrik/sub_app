import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'page_view_event.dart';
part 'page_view_state.dart';

class OnbordingBloc extends Bloc<OnbordingEvent, OnbordingState> {
  final SharedPreferences sharedPreferences =
      GetIt.instance<SharedPreferences>();

  OnbordingBloc() : super(OnbordingInitial()) {
    on<OnbordingCheckFirstLaunch>((event, emit) {
      final isFirstLaunch = sharedPreferences.getBool('isFirstLaunch') ?? true;
      if (isFirstLaunch) {
        emit(StartOnbording());
        emit(OnbordingUpdated(pageIndex: 0));
      } else {
        emit(OnbordingSkipped());
      }
    });

    on<OnbordingCompleted>((event, emit) {
      sharedPreferences.setBool('isFirstLaunch', false);
      emit(OnbordingSkipped());
    });
    on<OnbordingChanged>((event, emit) {
      emit(OnbordingUpdating());
      emit(OnbordingUpdated(pageIndex: event.index));
    });
  }
}
