import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sub_app/core/widgets/shadow_header_delegate.dart';
import 'package:sub_app/repositories/model/project/project_model.dart';
import 'package:sub_app/screens/project/bloc/subtitles_bloc.dart';
import 'package:sub_app/screens/project/bloc/subtitles_event.dart';
import 'package:sub_app/screens/project/bloc/subtitles_state.dart';
import 'package:sub_app/screens/project/widgets/card_subtitle_widget.dart';
import 'package:subtitle/subtitle.dart';

class ProjectScreen extends StatefulWidget {
  final Project project;

  const ProjectScreen({super.key, required this.project});

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SubtitlesBloc>().add(LoadSubtitles(widget.project));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(widget.project.name),
            pinned: true,
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: ShadowHeaderDelegate(),
          ),
          BlocBuilder<SubtitlesBloc, SubtitlesState>(
            builder: (context, state) {
              if (state is SubtitlesLoaded) {
                return _buildSubtitleList(state.subtitles);
              } else if (state is SubtitlesSaving) {
                return const SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()));
              } 
              
              else if (state is SubtitlesError) {
                return SliverToBoxAdapter(
                    child: Center(child: Text(state.message)));
              }
              return const SliverToBoxAdapter(
                  child: Center(child: Text("Неизвестное состояние")));
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSubtitleList(List<Subtitle> subtitles) {
    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverList.builder(
        itemCount: subtitles.length,
        itemBuilder: (context, index) {
          return CardSubtitleWidget(index: index, subtitleData: subtitles[index].data);
        },
      ),
    );
  }
}

