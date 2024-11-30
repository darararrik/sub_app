// import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class ProjectScreen extends StatelessWidget {
  const ProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// class ProjectScreen extends StatelessWidget {
//   const ProjectScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: ListView.builder(
//         itemCount: subtitles.length,
//         itemBuilder: (context, index) {
//           final subtitle = subtitles[index];
//           final translation = translations[index] ?? '';
//           return Padding(
//             padding: const EdgeInsets.only(bottom: 16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   '(${subtitle.index}) ${subtitle.start} --> ${subtitle.end}',
//                   style: const TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(subtitle.data), // Текст субтитра
//                 const SizedBox(height: 8),
//                 TextField(
//                   onChanged: (value) {
//                     _updateTranslation(
//                         subtitle.index, value); // Обновление перевода
//                   },
//                   decoration: const InputDecoration(
//                     hintText: "Введите перевод",
//                     labelText: "Перевод",
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }



  // // Метод для обновления перевода
  // void _updateTranslation(int index, String translation) {
  //   setState(() {
  //     translations[index] =
  //         translation; // Сохраняем перевод для текущего субтитра
  //   });
  // }

  // Future<void> saveFileToAppSpecificDir(String fileName, String content) async {
  //   try {
  //     // Получаем директорию, специфичную для приложения
  //     final directory = await getExternalStorageDirectory();
  //     if (directory == null) {
  //       throw Exception('Не удалось получить директорию для хранения файлов');
  //     }

  //     // Создаём файл в этой директории
  //     final file = File('${directory.path}/$fileName');
  //     await file.writeAsString(content, mode: FileMode.write);

  //     print('Файл сохранён: ${file.path}');
  //   } catch (e) {
  //     print('Ошибка сохранения файла: $e');
  //   }
  // }

  // Future<void> _saveSubtitleWithTranslation() async {
  //   final StringBuffer buffer = StringBuffer();

  //   // Форматируем субтитры
  //   for (var subtitle in subtitles) {
  //     buffer.writeln(subtitle.index);
  //     buffer.writeln('${subtitle.start} --> ${subtitle.end}');
  //     buffer.writeln(subtitle.data);
  //     buffer.writeln(translations[subtitle.index] ?? '');
  //     buffer.writeln();
  //   }

  //   try {
  //     await saveFileToAppSpecificDir(
  //         'translated_subtitles.srt', buffer.toString());

  //     // Показываем уведомление об успехе
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Файл успешно сохранён')),
  //     );
  //   } catch (e) {
  //     // Показываем уведомление об ошибке
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Ошибка при сохранении файла: $e')),
  //     );
  //   }
  // }
