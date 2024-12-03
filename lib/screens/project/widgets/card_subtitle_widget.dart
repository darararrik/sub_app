import 'package:flutter/material.dart';
import 'package:sub_app/screens/project/cubit/card_subtitle_cubit.dart';
import 'package:sub_app/screens/project/widgets/subtitle_data.dart';
import 'package:sub_app/screens/project/widgets/syllable_input_widget.dart';
import 'package:sub_app/screens/project/widgets/title_widget.dart';
import 'package:sub_app/screens/project/widgets/translate_input_widget.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class CardSubtitleWidget extends StatelessWidget {
  final int index;
  final String subtitleData;

  const CardSubtitleWidget(
      {super.key, required this.index, required this.subtitleData});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CardSubtitleCubit(),
      child: BlocBuilder<CardSubtitleCubit, bool>(
        builder: (context, isExpanded) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
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
            ),
          );
        },
      ),
    );
  }

  Widget _titleState(BuildContext context, bool isExpanded) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        TitleWidget(index: index),
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 4),
                blurRadius: 12,
                spreadRadius: 0,
                color: Color.fromRGBO(0, 0, 0, 0.08),
              ),
            ],
          ),
          child: IconButton(
            onPressed: () =>
                context.read<CardSubtitleCubit>().toggleExpansion(),
            icon: Icon(
              isExpanded
                  ? Icons.arrow_drop_up_rounded
                  : Icons.arrow_drop_down_rounded,
            ),
          ),
        ),
      ],
    );
  }

  Container _bodyCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 12,
            spreadRadius: 0,
            color: Color.fromRGBO(0, 0, 0, 0.08),
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SubtitleDataWidget(subtitleData: subtitleData),
              const SizedBox(width: 12),
              const SyllableInputWidget(),
            ],
          ),
          const SizedBox(height: 24),
          const Row(
            children: [
              TranslateInputWidget(),
              SizedBox(width: 12),
              SyllableInputWidget(),
            ],
          )
        ],
      ),
    );
  }
}
