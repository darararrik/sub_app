import 'package:bloc/bloc.dart';

class CardSubtitleCubit extends Cubit<bool> {
  CardSubtitleCubit() : super(true);

  // Переключение состояния раскрытия
  void toggleExpansion() => emit(!state);
}
