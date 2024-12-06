import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sub_app/screens/profile/bloc/auth_bloc.dart';
import 'package:sub_app/core/widgets/button_widget.dart';
import 'package:sub_app/core/widgets/text_field_widget.dart';
import 'package:sub_app/core/theme.dart';

class ChangePasswordScreen extends StatelessWidget {
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Сменить пароль'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Измените свой пароль',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextFieldWidget(
              controller: currentPasswordController,
              hintText: 'Введите текущий пароль',
              obscureText: true,
              labelText: 'Текущий пароль',
            ),
            const SizedBox(height: 16),
            TextFieldWidget(
              controller: newPasswordController,
              hintText: 'Введите новый пароль',
              obscureText: true,
              labelText: 'Новый пароль',
            ),
            const SizedBox(height: 24),
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
                return ButtonWidget(
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
                  color: primaryColor,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
