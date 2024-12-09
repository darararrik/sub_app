import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sub_app/core/utils/svg.dart';
import 'package:sub_app/core/widgets/button_widget.dart';
import 'package:sub_app/core/widgets/input_auth.dart';
import 'package:sub_app/screens/profile/bloc/auth_bloc.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Введите электронную почту';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Некорректный формат электронной почты';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Введите пароль';
    }
    if (value.length < 6) {
      return 'Пароль должен содержать не менее 6 символов';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Авторизация"),
        leading: IconButton(onPressed: () => context.pop(), icon: backIcon),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccessState) {
            context.go("/profile");
          } else if (state is AuthErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error ?? 'Произошла ошибка'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (BuildContext context, AuthState state) {
          if (state is AuthLoadingState) {
            return const Center(child: CircularProgressIndicator());
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
                          label: "Электронная почта",
                          hintText: "Введите электронную почту",
                          icon: email,
                          controller: emailController,
                          validator: _validateEmail,
                          obscureText: false),
                      const SizedBox(height: 16),
                      InputAuth(
                          label: "Пароль",
                          hintText: "Введите пароль",
                          icon: lock,
                          controller: passwordController,
                          validator: _validatePassword,
                          obscureText: true),
                      // Поле ввода пароля
                    ],
                  ),
                  const SizedBox(height: 36),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ButtonWidget(
                      text: 'Войти',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                                SignInRequested(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                ),
                              );
                        }
                      },
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ButtonWidget(
                      hasColorText: false,
                      text: 'Создать аккаунт',
                      onPressed: () {
                        context.go("/signup");
                      },
                      color: const Color.fromRGBO(79, 82, 255, 0.16),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
