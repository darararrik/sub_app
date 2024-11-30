import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
part 'pick_image_state.dart';

class PickImageCubit extends Cubit<PickImageState> {
  final ImagePicker _picker = ImagePicker();

  PickImageCubit() : super(ImageInitial());

  // Метод для выбора изображения
  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      emit(ImagePicked(File(pickedFile.path)));
    }
  }

  void resetState() {
    emit(ImageInitial());
  }
}
