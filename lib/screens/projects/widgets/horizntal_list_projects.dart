import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sub_app/core/bloc/project_bloc.dart';
import 'package:sub_app/core/widgets/card_widget.dart';
import 'package:sub_app/repositories/model/project/project_model.dart';
import 'package:sub_app/screens/project/bloc/subtitles_bloc.dart';
import 'package:sub_app/core/status.dart';

class HorizntalListProjects extends StatelessWidget {
  const HorizntalListProjects({
    super.key,
    required this.projects,
    required this.name,
  });

  final String name;
  final List<Project> projects;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 250,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              scrollDirection: Axis.horizontal,
              itemCount: projects.length,
              itemBuilder: (context, index) {
                final project = projects[index];
                return GestureDetector(
                  onLongPress: () {
                    showMenu(
                      context: context,
                      position: const RelativeRect.fromLTRB(
                          100, 100, 100, 100), // Adjust position as needed
                      items: [
                        PopupMenuItem<String>(
                          onTap: () {
                            context
                                .read<SubtitlesBloc>()
                                .add(SaveSubtitlesToFile(project: project));
                          },
                          child: const Text('Импортировать'),
                        ),
                        PopupMenuItem<String>(
                          child: const Text('Изменить прогресс'),
                          onTap: () {
                            _showProgressBottomSheet(context, project);
                          },
                        ),
                        PopupMenuItem<String>(
                          child: const Text('Удалить'),
                          onTap: () {
                            context
                                .read<ProjectBloc>()
                                .add(DeleteProject(project: project));
                          },
                        ),
                      ],
                    );
                  },
                  child: CardWidget(project: project),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showProgressBottomSheet(BuildContext context, Project project) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        String selectedStatus = project.status;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Изменить прогресс',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ...Status.values.map((status) {
                bool isSelected = selectedStatus ==
                    status.displayName; // Проверка, выбран ли статус
                return ListTile(
                  splashColor: Colors.blue.withOpacity(0.2),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 32),
                  tileColor: isSelected
                      ? Colors.blue.withOpacity(0.2)
                      : null, // Цвет фона для выбранного статуса
                  leading: Icon(status.icon),
                  title: Text(status.displayName),
                  onTap: () {
                    selectedStatus =
                        status.displayName; // Устанавливаем выбранный статус
                    Navigator.pop(context); // Закрытие модального окна
                    context.read<ProjectBloc>().add(
                          UpdateProgressStatus(
                            project: project,
                            status: status.displayName,
                          ),
                        );
                  },
                );
              }),
            ],
          ),
        );
      },
    );
  }
}
