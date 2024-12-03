import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sub_app/screens/project/cubit/card_subtitle_cubit.dart';
import 'package:sub_app/screens/project/widgets/subtitle_data.dart';
import 'package:sub_app/screens/project/widgets/syllable_input_widget.dart';
import 'package:sub_app/screens/project/widgets/title_widget.dart';
import 'package:sub_app/screens/project/widgets/translate_input_widget.dart';

class CardSubtitleWidget extends StatelessWidget {
  final int index;
  final String subtitleWord;
  Map<int, String> translatedSubtitles;

  CardSubtitleWidget({
    super.key,
    required this.index,
    required this.subtitleWord,
    required this.translatedSubtitles,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CardSubtitleCubit(),
      child: BlocBuilder<CardSubtitleCubit, bool>(
        builder: (context, isExpanded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedSize(
                curve: Curves.easeInOut,
                duration: const Duration(milliseconds: 250),
                child: _titleState(context, isExpanded),
              ),
              const SizedBox(height: 12),
              AnimatedSize(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                alignment: Alignment.center,
                child: isExpanded ? _bodyCard() : const SizedBox.shrink(),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _titleState(BuildContext context, bool isExpanded) {
    return GestureDetector(
      onTap: () => context.read<CardSubtitleCubit>().toggleExpansion(),
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
              child: TitleWidget(index: index),
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
                  isExpanded
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
                SubtitleDataWidget(subtitleWord: subtitleWord),
                const SizedBox(width: 12),
                const SyllableInputWidget(),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                TranslateInputWidget(
                  index: index,
                  translatedSubtitles: translatedSubtitles,
                ),
                const SizedBox(width: 12),
                const SyllableInputWidget(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
