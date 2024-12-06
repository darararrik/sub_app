import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sub_app/repositories/model/project/project_model.dart';
import 'package:subtitle/subtitle.dart';
import 'package:sub_app/screens/project/bloc/subtitles_bloc.dart';
import 'package:sub_app/screens/project/widgets/card_subtitle_widget.dart';

class ProjectScreen extends StatefulWidget {
  final String projectId;

  const ProjectScreen({
    super.key,
    required this.projectId,
  });

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  Map<int, String> translatedSubtitles = {};

  @override
  void initState() {
    super.initState();
    // Загружаем субтитры для проекта
    context.read<SubtitlesBloc>().add(LoadSubtitles(widget.projectId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<SubtitlesBloc, SubtitlesState>(
          builder: (context, state) {
            if (state is SubtitlesLoaded) {
              return Text(state.project.name); // Используем имя проекта
            }
            return const Text("Проект");
          },
        ),
        elevation: 4,
        shadowColor: const Color.fromRGBO(0, 0, 0, 0.2),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ElevatedButton(
              onPressed: () {
                context.pop();
              },
              child: const Text(
                "Сохранить",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<SubtitlesBloc, SubtitlesState>(
        builder: (context, state) {
          if (state is SubtitlesLoaded) {
            translatedSubtitles = state.translatedWords;
            final project = state.project;

            return PopScope(
              onPopInvokedWithResult: (bool pop, dynamic) {
                context.read<SubtitlesBloc>().add(Save(
                      project: project,
                      translatedData: translatedSubtitles,
                    ));
                return;
              },
              child: _buildSubtitleList(
                state.engSubtitles,
                translatedSubtitles,
                project,
              ),
            );
          }

          if (state is Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is SubtitlesError) {
            return Center(
              child: Text(state.message),
            );
          }

          return const Center(
            child: Text("Неизвестное состояние"),
          );
        },
      ),
    );
  }

  Widget _buildSubtitleList(
    List<Subtitle> subtitles,
    Map<int, String> translatedWords,
    Project project,
  ) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      itemCount: subtitles.length,
      itemBuilder: (context, index) {
        return CardSubtitleWidget(
          index: index,
          subtitleWord: subtitles[index].data,
          translatedSubtitles: translatedSubtitles,
          project: project,
        );
      },
    );
  }
}
