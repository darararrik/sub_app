import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sub_app/core/utils/svg.dart';
import 'package:sub_app/core/widgets/button_widget.dart';
import 'package:sub_app/repositories/model/user/user.dart';
import 'package:sub_app/screens/profile/bloc/auth_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthCheckRequested());
  }

  @override
  Widget build(BuildContext context) {
    User user;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Профиль"),
        leading: IconButton(onPressed: () => context.pop(), icon: backIcon),
        actions: [
          _showOptionsMenu(),
        ],
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is UnauthenticatedState) {
            context.go("/signin");
          }
        },
        builder: (context, state) {
          if (state is AuthSuccessState) {
            user = User.fromFirebaseUser(state.user);
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 36),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _profileData(theme, user),
                  SizedBox(
                    height: 32,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child:
                        Text("Статистика", style: theme.textTheme.titleMedium),
                  ),
                  _data(createProjectBlack, theme, "Создано проектов",
                      user.createdProjects),
                  SizedBox(
                    height: 8,
                  ),
                  _data(projects, theme, "Проекты", user.projects),
                  SizedBox(
                    height: 8,
                  ),
                  _data(confirmProjectBlack, theme, "Переведено проектов",
                      user.translatedProjects),
                  SizedBox(
                    height: 8,
                  ),
                  _data(projectsI, theme, "Проектов в процессе",
                      user.inProgressProjects),
                ],
              ),
            );
          }
          if (state is AuthLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ConfirmState) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Вы вышли из аккаунта!",
                          style: TextStyle(
                              fontSize: 32, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          "Вы всегда сможете войти снова, если захотите!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: const Color.fromARGB(255, 110, 110, 110)),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 36.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ButtonWidget(
                            text: "Продолжить",
                            onPressed: () => context.go("/"),
                            color: theme.colorScheme.primary),
                      ),
                    ),
                  )
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  Padding _data(Widget icon, ThemeData theme, String title, int data) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon,
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(title, style: theme.textTheme.bodyMedium),
                Text(data.toString()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row _profileData(ThemeData theme, User user) {
    return Row(
      children: [
        CircleAvatar(
          radius: 50,
        ),
        SizedBox(
          width: 24,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                email,
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Почта",
                  style: theme.textTheme.titleSmall,
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            SizedBox(
              child: Text(
                user.email,
                overflow: TextOverflow.fade,
                style: theme.textTheme.titleSmall!
                    .copyWith(fontWeight: FontWeight.w500, fontSize: 16),
              ),
            ),
          ],
        )
      ],
    );
  }

  PopupMenuButton<String> _showOptionsMenu() {
    return PopupMenuButton<String>(
      itemBuilder: (context) => [
        PopupMenuItem(
          child: const Text('Выйти'),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Вы уверены, что хотите выйти?'),
                  content: const Text(
                      'Ваше устройство не сможет синхронизировать переводы, пока вы не войдёте в аккаунт. С проектами, которые уже на данном устройстве, ничего не случится.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        context.pop();
                      },
                      child: const Text('Отмена'),
                    ),
                    TextButton(
                      onPressed: () {
                        context.pop();
                        context.read<AuthBloc>().add(SignOutRequested());
                      },
                      child: const Text(
                        'Выйти',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
        PopupMenuItem(
            child: const Text('Сменить пароль'),
            onTap: () {
              context.go("/profile/changepassword");
            }),
        PopupMenuItem(
            child: const Text('Удалить аккаунт'),
            onTap: () {
              context.go("/profile/delete");
            }),
      ],
    );
  }
}
