import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sub_app/core/utils/svg.dart';
import 'package:sub_app/core/widgets/button_widget.dart';
import 'package:sub_app/core/widgets/input_auth.dart';
import 'package:sub_app/screens/profile/bloc/auth_bloc.dart';

class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({super.key});

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  final TextEditingController controllerPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    controllerPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Удалить аккаунт'),
        leading: IconButton(onPressed: () => context.pop(), icon: backIcon),
      ),
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
                      InputAuth(
                        label: "Пароль",
                        hintText: "Введите пароль",
                        icon: lock,
                        controller: controllerPassword,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Введите пароль';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
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
                              final password = controllerPassword.text.trim();
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
                context.pop();
              },
              child: const Text('Отмена'),
            ),
            TextButton(
              onPressed: () {
                context.pop();
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
