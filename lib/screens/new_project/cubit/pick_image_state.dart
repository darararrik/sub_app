part of 'pick_image_cubit.dart';

// Состояния
abstract class PickImageState {}

class ImageInitial extends PickImageState {}

class ImagePicked extends PickImageState {
  final File image;

  ImagePicked(this.image);
}
