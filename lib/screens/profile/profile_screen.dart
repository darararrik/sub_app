import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sub_app/core/utils/svg.dart';
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
          if (state is Unauthenticated) {
            context.go("/signin");
          }
        },
        builder: (context, state) {
          if (state is AuthSuccess) {
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
          if (state is AuthLoading) {
            return Center(
              child: CircularProgressIndicator(),
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
            Text(
              user.email,
              style: theme.textTheme.titleSmall!
                  .copyWith(fontWeight: FontWeight.w500),
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
          onTap: () => context.read<AuthBloc>().add(SignOutRequested()),
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
