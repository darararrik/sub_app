import 'package:realm/realm.dart';

part 'project_model.realm.dart';

@RealmModel()
class _Project {
  @PrimaryKey()
  late String id;
  late String name; // Название проекта
  late String engSubtitleFilePath; // Путь к файлу субтитров
  late Map<String, String> translatedWords; // Путь к файлу субтитров
  late Map<String, String> syllablesNotTranslated = {};
  late Map<String, String> syllablesTranslated = {};

  late Map<String, bool> isExpanded = {};
  late String status = "Не переведено";

  late List<int> imageBytes; // Массив байтов для изображения
}
