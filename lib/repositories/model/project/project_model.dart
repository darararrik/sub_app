import 'package:realm/realm.dart';

part 'project_model.realm.dart';

@RealmModel()
class _Project {
  late String id;
  late String name; // Название проекта
  String? subtitleFilePath; // Путь к файлу субтитров
  List<String> translatedSubtitles = []; // Переведённые субтитры
}
