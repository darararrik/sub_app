import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sub_app/repositories/model/project/project_model.dart';
import 'package:sub_app/screens/project/cubit/card_subtitle_cubit.dart';
import 'package:sub_app/screens/project/widgets/subtitle_data.dart';
import 'package:sub_app/screens/project/widgets/syllable_input_widget.dart';
import 'package:sub_app/screens/project/widgets/title_widget.dart';
import 'package:sub_app/screens/project/widgets/translate_input_widget.dart';

class CardSubtitleWidget extends StatefulWidget {
  final int index;
  final String subtitleWord;
  final Map<int, String> translatedSubtitles;
  final Project project; // Передаем проект
  final Map<int, String> syllTranslated;
  final Map<int, String> syllNotTranslated;
  const CardSubtitleWidget(
      {super.key,
      required this.index,
      required this.subtitleWord,
      required this.translatedSubtitles,
      required this.project,
      required this.syllTranslated,
      required this.syllNotTranslated});

  @override
  State<CardSubtitleWidget> createState() => _CardSubtitleWidgetState();
}

class _CardSubtitleWidgetState extends State<CardSubtitleWidget> {
  @override
  void initState() {
    super.initState();
    context.read<CardSubtitleCubit>().initialize(widget.project);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardSubtitleCubit, Map<int, bool>>(
      builder: (context, state) {
        bool isItemExpanded = state[widget.index] ?? true; // Получаем состояние

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedSize(
              curve: Curves.easeInOut,
              duration: const Duration(milliseconds: 250),
              child: _titleState(context, isItemExpanded),
            ),
            const SizedBox(height: 12),
            AnimatedSize(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              alignment: Alignment.center,
              child: isItemExpanded ? _bodyCard() : const SizedBox.shrink(),
            ),
          ],
        );
      },
    );
  }

  Widget _titleState(BuildContext context, bool isItemExpanded) {
    return GestureDetector(
      onTap: () {
        context
            .read<CardSubtitleCubit>()
            .toggleExpansion(widget.index); // Переключаем состояние
      },
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 2),
              blurRadius: 6,
              spreadRadius: 0,
              color: Color.fromRGBO(0, 0, 0, 0.08),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: TitleWidget(index: widget.index),
            ),
            Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(-4, 0),
                      blurRadius: 4,
                      spreadRadius: 0,
                      color: Color.fromRGBO(0, 0, 0, 0.06),
                    ),
                  ],
                ),
                child: Icon(
                  isItemExpanded
                      ? Icons.arrow_drop_up_rounded
                      : Icons.arrow_drop_down_rounded,
                  size: 32,
                )),
          ],
        ),
      ),
    );
  }

  Padding _bodyCard() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFF4F4F4),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SubtitleDataWidget(subtitleWord: widget.subtitleWord),
                const SizedBox(width: 12),
                SyllableInputWidget(
                  index: widget.index,
                  syll: widget.syllNotTranslated,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                TranslateInputWidget(
                  index: widget.index,
                  translatedSubtitles: widget.translatedSubtitles,
                ),
                const SizedBox(width: 12),
                SyllableInputWidget(
                  index: widget.index,
                  syll: widget.syllTranslated,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
