import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart'; // Для выбора файла
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io'; // Для работы с файлами
import 'package:subtitle/subtitle.dart'; // Для работы с субтитрами

class NewProjectScreen extends StatefulWidget {
  const NewProjectScreen({super.key});

  @override
  _NewProjectScreenState createState() => _NewProjectScreenState();
}

class _NewProjectScreenState extends State<NewProjectScreen> {
  final TextEditingController nameProject = TextEditingController();
  late SubtitleController controller; // Контроллер для работы с субтитрами
  List<Subtitle> subtitles = []; // Список субтитров
  String filePath = '';
  Map<int, String> translations =
      {}; // Карта для хранения перевода для каждого субтитра

  // Метод для выбора и чтения файла
  Future<void> _pickSubtitleFile() async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.isNotEmpty) {
      filePath = result.files.single.path!;
      final file = File(filePath);

      // Чтение содержимого файла
      final content = await file.readAsString();

      // Инициализация контроллера с данными субтитров
      controller = SubtitleController(
        provider: SubtitleProvider.fromString(
          data: content,
          type: SubtitleType.srt,
        ),
      );

      await controller.initial();
      setState(() {
        subtitles = controller.subtitles; // Загружаем субтитры
      });
    }
  }

  // Метод для обновления перевода
  void _updateTranslation(int index, String translation) {
    setState(() {
      translations[index] =
          translation; // Сохраняем перевод для текущего субтитра
    });
  }

  Future<void> saveFileToAppSpecificDir(String fileName, String content) async {
    try {
      // Получаем директорию, специфичную для приложения
      final directory = await getExternalStorageDirectory();
      if (directory == null) {
        throw Exception('Не удалось получить директорию для хранения файлов');
      }

      // Создаём файл в этой директории
      final file = File('${directory.path}/$fileName');
      await file.writeAsString(content, mode: FileMode.write);

      print('Файл сохранён: ${file.path}');
    } catch (e) {
      print('Ошибка сохранения файла: $e');
    }
  }

  Future<void> _saveSubtitleWithTranslation() async {
    final StringBuffer buffer = StringBuffer();

    // Форматируем субтитры
    for (var subtitle in subtitles) {
      buffer.writeln(subtitle.index);
      buffer.writeln('${subtitle.start} --> ${subtitle.end}');
      buffer.writeln(subtitle.data);
      buffer.writeln(translations[subtitle.index] ?? '');
      buffer.writeln();
    }

    try {
      await saveFileToAppSpecificDir(
          'translated_subtitles.srt', buffer.toString());

      // Показываем уведомление об успехе
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Файл успешно сохранён')),
      );
    } catch (e) {
      // Показываем уведомление об ошибке
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка при сохранении файла: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Новый проект"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameProject,
              decoration: const InputDecoration(
                hintText: "Введите название проекта",
                label: Text("Название проекта"),
              ),
            ),
            const SizedBox(height: 36),
            const Text(
              "Ресурсы",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Файл субтитров",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.subtitles,
                    size: 32,
                  ),
                  onPressed: _pickSubtitleFile, // Открытие диалога выбора файла
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (subtitles.isNotEmpty)
              // Если субтитры загружены, отображаем их
              Expanded(
                child: ListView.builder(
                  itemCount: subtitles.length,
                  itemBuilder: (context, index) {
                    final subtitle = subtitles[index];
                    final translation = translations[index] ?? '';
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '(${subtitle.index}) ${subtitle.start} --> ${subtitle.end}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(subtitle.data), // Текст субтитра
                          const SizedBox(height: 8),
                          TextField(
                            onChanged: (value) {
                              _updateTranslation(
                                  subtitle.index, value); // Обновление перевода
                            },
                            decoration: const InputDecoration(
                              hintText: "Введите перевод",
                              labelText: "Перевод",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            // Кнопка для сохранения файла с переведенными субтитрами
            ElevatedButton(
              onPressed: _saveSubtitleWithTranslation,
              child: const Text("Сохранить субтитры с переводом"),
            ),
          ],
        ),
      ),
    );
  }
}
