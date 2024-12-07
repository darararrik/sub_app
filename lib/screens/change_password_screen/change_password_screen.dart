import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sub_app/core/utils/svg.dart';
import 'package:sub_app/core/widgets/input_auth.dart';
import 'package:sub_app/screens/profile/bloc/auth_bloc.dart';
import 'package:sub_app/core/widgets/button_widget.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController currentPasswordController =
      TextEditingController();

  final TextEditingController newPasswordController = TextEditingController();
  @override
  void dispose() {
    newPasswordController.dispose();
    currentPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Сменить пароль'),
        leading: IconButton(onPressed: () => context.pop(), icon: backIcon),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InputAuth(
                label: 'Текущий пароль',
                hintText: "Введите текущий пароль",
                icon: lock,
                controller: currentPasswordController,
                obscureText: true),
            const SizedBox(height: 16),
            InputAuth(
                label: 'Новый пароль',
                hintText: "Введите новый пароль",
                icon: lock,
                controller: newPasswordController,
                obscureText: true),
            const SizedBox(height: 40),
            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthSuccessMessage) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                  context.pop();
                } else if (state is AuthErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.error ?? 'Ошибка')),
                  );
                }
              },
              builder: (context, state) {
                if (state is AuthLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ButtonWidget(
                    text: 'Сменить пароль',
                    onPressed: () {
                      final currentPassword =
                          currentPasswordController.text.trim();
                      final newPassword = newPasswordController.text.trim();

                      if (currentPassword.isEmpty || newPassword.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Все поля должны быть заполнены')),
                        );
                        return;
                      }
                      context.read<AuthBloc>().add(
                            UpdatePasswordRequested(
                              currentPassword: currentPassword,
                              newPassword: newPassword,
                            ),
                          );
                    },
                    color: theme.colorScheme.primary,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
