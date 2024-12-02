import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sub_app/core/widgets/shadow_header_delegate.dart';
import 'package:sub_app/repositories/model/project/project_model.dart';
import 'package:sub_app/screens/project/bloc/subtitles_bloc.dart';
import 'package:sub_app/screens/project/bloc/subtitles_event.dart';
import 'package:sub_app/screens/project/bloc/subtitles_state.dart';

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

  Map<String, String> translation = {};
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
                final subtitles = state.subtitles;
                return SliverPadding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    sliver: SliverList.builder(
                      itemCount: subtitles.length,
                      itemBuilder: (context, index) {
                        final subtitle = subtitles[index];
                        return ExpandableRow(
                            index: index, subtitle: subtitle.data);
                      },
                    ));
              } else if (state is SubtitlesSaving) {
                return const SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()));
              } else if (state is SubtitlesError) {
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

  Row _numberRow(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
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
              ]),
          child: Row(
            children: [
              Text(
                "${index + 1}",
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                "Строка",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
            ],
          ),
        ),
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
              ]),
          child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_drop_down_rounded)),
        )
      ],
    );
  }
}

class ExpandableRow extends StatefulWidget {
  final int index;
  final String subtitle;

  ExpandableRow({required this.index, required this.subtitle});

  @override
  _ExpandableRowState createState() => _ExpandableRowState();
}

class _ExpandableRowState extends State<ExpandableRow>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
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
                child: Row(
                  children: [
                    Text(
                      "${widget.index + 1}",
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      "Строка",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                  ],
                ),
              ),
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
                  onPressed: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                  icon: Icon(
                    _isExpanded
                        ? Icons.arrow_drop_up_rounded
                        : Icons.arrow_drop_down_rounded,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          AnimatedSize(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            alignment: Alignment.center,
            child: _isExpanded
                ? Container(
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
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 16),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFECECEC),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                ),
                                child: Text(
                                  widget.subtitle,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            SizedBox(
                              width: 48,
                              height: 48,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                maxLength: 2,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  counterText: "",
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                      color: Color(0xFF6E6E6E),
                                      width: 1,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                      color: Color(0xFF6E6E6E),
                                      width: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 48,
                                child: TextField(
                                  onChanged: (value) {
                                    //translation[index.toString()] = value;
                                  },
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                        color: Color(0xFF6E6E6E),
                                        width: 1, // Ширина границы
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                        color: Color(
                                            0xFF6E6E6E), // Цвет границы в активном состоянии
                                        width: 1, // Ширина границы при фокусе
                                      ),
                                    ),
                                    hintText: "Введите перевод",
                                    labelText: "Перевод",
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            SizedBox(
                              width: 48,
                              height: 48,
                              child: Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  maxLength: 2, // ограничение на длину ввода
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    counterText: "", // убрать счетчик символов
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                        color: Color(0xFF6E6E6E),
                                        width: 1, // Ширина границы
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                        color: Color(
                                            0xFF6E6E6E), // Цвет границы в активном состоянии
                                        width: 1, // Ширина границы при фокусе
                                      ),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    //TODO: хз
                                  },
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
