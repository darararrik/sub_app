import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subtitle/subtitle.dart';

import 'package:sub_app/core/widgets/shadow_header_delegate.dart';
import 'package:sub_app/repositories/model/project/project_model.dart';
import 'package:sub_app/screens/project/bloc/subtitles_bloc.dart';
import 'package:sub_app/screens/project/bloc/subtitles_event.dart';
import 'package:sub_app/screens/project/bloc/subtitles_state.dart';
import 'package:sub_app/screens/project/widgets/card_subtitle_widget.dart';

class ProjectScreen extends StatefulWidget {
  final Project project;

  const ProjectScreen({
    super.key,
    required this.project,
  });

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  Map<int, String> translatedSubtitles = {};

  @override
  void initState() {
    super.initState();
    context.read<SubtitlesBloc>().add(LoadSubtitles(widget.project));
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (bool pop, dynamic) {
        // Сохраняем прогресс при выходе
        context.read<SubtitlesBloc>().add(Save(
              project: widget.project,
              translatedData: translatedSubtitles,
            ));
        return;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.project.name),
          elevation: 4,
          shadowColor: const Color.fromRGBO(0, 0, 0, 0.2),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Сохранить",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  )),
            )
          ],
        ),
        body: BlocBuilder<SubtitlesBloc, SubtitlesState>(
          builder: (context, state) {
            if (state is SubtitlesLoaded) {
              translatedSubtitles = state.translatedWords;

              return _buildSubtitleList(
                  state.engSubtitles, translatedSubtitles, widget.project);
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
      ),
    );
  }

  Widget _buildSubtitleList(List<Subtitle> subtitles,
      Map<int, String> translatedWords, Project project) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 24),
        itemCount: subtitles.length,
        itemBuilder: (context, index) {
          return CardSubtitleWidget(
            index: index,
            subtitleWord: subtitles[index].data,
            translatedSubtitles: translatedSubtitles,
          );
        },
      ),
    );
  }
}
