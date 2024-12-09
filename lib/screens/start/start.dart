import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:sub_app/core/utils/svg.dart';
import 'package:sub_app/core/widgets/button_widget.dart';
import 'package:sub_app/screens/start/bloc/page_view_bloc.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var appBarBool = false;
    FlutterNativeSplash.remove();
    return BlocConsumer<OnbordingBloc, OnbordingState>(
      listener: (context, state) {
        if (state is OnbordingSkipped) {
          context.pop();
        }
      },
      builder: (context, state) {
        if (state is OnbordingUpdated) {
          final pageIndex = state.pageIndex;
          final pageController = PageController(initialPage: pageIndex);
          return Scaffold(
            appBar: appBarBool
                ? AppBar(
                    backgroundColor: Colors.transparent,
                    leading: IconButton(
                        onPressed: () {
                          pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                          if (pageIndex == 1) appBarBool = false;
                        },
                        icon: backIconBlack),
                  )
                : null,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 700,
                  child: PageView(
                    controller: pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (index) {
                      context
                          .read<OnbordingBloc>()
                          .add(OnbordingChanged(index: index));
                    },
                    children: [
                      OnbordingScreen(
                        pageController: pageController,
                        picture: onbordingPicture1,
                        title: 'Переводите просто',
                        label:
                            'Переводите с лёгкостью в минималистичном редакторе субтитров',
                      ),
                      OnbordingScreen(
                        pageController: pageController,
                        picture: onbordingPicture2,
                        title: 'Переводите быстро',
                        label:
                            'Загрузите субтитры в формате .srt на одном или двух языках и сразу приступите к переводу',
                      ),
                      OnbordingScreen(
                        pageController: pageController,
                        picture: onbordingPicture3,
                        title: 'Переводите везде',
                        label:
                            'Войдите в аккаунт и автоматически синхронизируйте свои переводы между устройствами',
                      ),
                      OnbordingScreen(
                        pageController: pageController,
                        picture: onbordingPicture4,
                        title: 'Переводите для всех',
                        label:
                            'Экспортируйте переводы в любой из популярных форматов и делитесь ими со всем миром',
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0)
                      .copyWith(bottom: 36),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ButtonWidget(
                        text: pageIndex == 3 ? "Начать работу" : "Далее",
                        onPressed: () {
                          if (pageIndex == 3) {
                            context
                                .read<OnbordingBloc>()
                                .add(OnbordingCompleted());
                          } else {
                            pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                            appBarBool = true;
                          }
                        },
                        color: Theme.of(context).colorScheme.primary),
                  ),
                ),
              ],
            ),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}

class OnbordingScreen extends StatelessWidget {
  final Widget picture;
  final String title;
  final String label;
  final PageController pageController;

  const OnbordingScreen({
    super.key,
    required this.picture,
    required this.title,
    required this.pageController,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            picture,
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
