import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sub_app/core/bloc/project_bloc.dart';

class NewProjectScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  NewProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String filePath = "";

    return Scaffold(
      appBar: AppBar(title: const Text("Новый проект")),
      body: BlocListener<ProjectBloc, ProjectState>(
        listener: (context, state) {
          if (state is ProjectAddedState) {
            Navigator.pop(context); // Возврат на предыдущий экран
          } else if (state is ProjectErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration:
                    const InputDecoration(labelText: "Название проекта"),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  final result = await FilePicker.platform.pickFiles();

                  if (result != null && result.files.isNotEmpty) {
                    filePath = result.files.single.path!;
                    context
                        .read<ProjectBloc>()
                        .add(LoadSubtitlesEvent(filePath: filePath));
                  }
                },
                child: const Text("Выбрать файл субтитров"),
              ),
              BlocBuilder<ProjectBloc, ProjectState>(
                builder: (context, state) {
                  if (state is SubtitlesLoadedState) {
                    return Text(
                        "Субтитров загружено: ${state.subtitles.length}");
                  }
                  return const SizedBox();
                },
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  final name = nameController.text.trim();
                  if (name.isNotEmpty) {
                    context.read<ProjectBloc>().add(
                          AddProjectEvent(
                            name: name,
                            subtitleFilePath:
                                filePath, // Передайте путь к субтитрам
                          ),
                        );
                  }
                },
                child: const Text("Создать проект"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
