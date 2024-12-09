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
    final theme = Theme.of(context);
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
                          "Аккаунт удалён!",
                          style: TextStyle(
                              fontSize: 32, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          "Вы всегда сможете зарегистрироваться снова, если захотите!",
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
