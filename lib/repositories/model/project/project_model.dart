import 'package:realm/realm.dart';

part 'project_model.realm.dart';

@RealmModel()
class _Project {
  late String id;
  late String name; // Название проекта
  String? engSubtitleFilePath; // Путь к файлу субтитров
  String? japSubtitleFilePath; // Путь к файлу субтитров

  List<String> translatedSubtitles = []; // Переведённые субтитры
  late String? status = "Не переведено";

  late List<int> imageBytes; // Массив байтов для изображения
}
