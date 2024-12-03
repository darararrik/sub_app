import 'package:realm/realm.dart';

part 'project_model.realm.dart';

@RealmModel()
class _Project {
  @PrimaryKey()
  late String id;
  late String name; // Название проекта
  late String engSubtitleFilePath; // Путь к файлу субтитров
  late String? ruSubtitleFilePath; // Путь к файлу субтитров
  late Map<String, String> syllables = {};

  late String status = "Не переведено";

  late List<int> imageBytes; // Массив байтов для изображения
}
