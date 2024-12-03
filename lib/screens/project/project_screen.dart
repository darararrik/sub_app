// ignore_for_file: public_member_api_docs, sort_constructors_first
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
    return BlocListener<SubtitlesBloc, SubtitlesState>(
      listener: (context, state) {
        if (state is SubtitlesLoaded) {
          for (var entry in state.project.translatedWords.entries) {
            int keyAsInt = int.parse(entry.key); // Безопасное преобразование
            translatedSubtitles[keyAsInt] = entry.value;
            print('Key as Int: $keyAsInt, Value: ${entry.value}');
          }
        }
      },
      child: PopScope(
        onPopInvokedWithResult: (bool didPop, Object? result) async {
          context.read<SubtitlesBloc>().add(SaveSubtitlesToFile(
                project: widget.project,
                translatedData: translatedSubtitles,
              ));
          return;
        },
        child: Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                title: Text(widget.project.name),
                pinned: true,
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          context.read<SubtitlesBloc>().add(SaveSubtitlesToFile(
                                project: widget.project,
                                translatedData: translatedSubtitles,
                              ));
                        },
                        child: const Text(
                          "Сохранить",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        )),
                  )
                ],
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: ShadowHeaderDelegate(),
              ),
              BlocBuilder<SubtitlesBloc, SubtitlesState>(
                builder: (context, state) {
                  if (state is SubtitlesLoaded) {
                    return _buildSubtitleList(state.engSubtitles,
                        translatedSubtitles, widget.project);
                  } else if (state is SubtitlesSaving) {
                    return const SliverToBoxAdapter(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (state is SubtitlesError) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Text(state.message),
                      ),
                    );
                  }
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: Text("Неизвестное состояние"),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubtitleList(List<Subtitle> subtitles,
      Map<int, String> translatedWords, Project project) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      sliver: SliverList.builder(
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
