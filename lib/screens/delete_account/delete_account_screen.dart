import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sub_app/core/widgets/button_widget.dart';
import 'package:sub_app/core/widgets/text_field_widget.dart';
import 'package:sub_app/screens/profile/bloc/auth_bloc.dart';

class DeleteAccountScreen extends StatelessWidget {
  DeleteAccountScreen({super.key});

  final TextEditingController controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(state.error ?? 'Ошибка при удалении аккаунта')),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Удаление аккаунта",
                        style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).primaryColor),
                      ),
                      Text(
                        "Введите пароль для подтверждения",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      // Поле ввода пароля
                      TextFieldWidget(
                        obscureText: true,
                        controller: controller,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Введите пароль';
                          }
                          return null;
                        },
                        hintText: 'Введите пароль',
                        labelText: 'Пароль',
                      ),
                    ],
                  ),
                  const SizedBox(height: 36),
                  Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ButtonWidget(
                          hasColorText: true,
                          text: "Удалить аккаунт",
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              final password = controller.text.trim();
                              _showConfirmationDialog(context, password);
                            }
                          },
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context, String password) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Подтверждение удаления'),
          content: const Text(
              'Вы уверены, что хотите удалить аккаунт? Это действие необратимо.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Закрыть диалог
              },
              child: const Text('Отмена'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Закрыть диалог
                context.read<AuthBloc>().add(
                      DeleteAccountRequested(currentPassword: password),
                    );
              },
              child: const Text(
                'Удалить',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
