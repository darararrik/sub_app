import 'dart:typed_data';

import 'package:realm/realm.dart';

part 'project_model.realm.dart';

@RealmModel()
class _Project {
  late String id;
  late String name; // Название проекта
  String? subtitleFilePath; // Путь к файлу субтитров
  List<String> translatedSubtitles = []; // Переведённые субтитры
  late String? status = "Созданный";
  // Массив байтов для изображения
  late List<int> imageBytes;
    // Метод для конвертации байтов в изображение
  Uint8List get image => Uint8List.fromList(imageBytes);
}
