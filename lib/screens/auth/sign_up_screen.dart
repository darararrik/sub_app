import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sub_app/core/utils/svg.dart';
import 'package:sub_app/core/widgets/button_widget.dart';
import 'package:sub_app/core/widgets/input_auth.dart';
import 'package:sub_app/screens/profile/bloc/auth_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController1 = TextEditingController();
  final TextEditingController passwordController2 = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    passwordController1.dispose();
    passwordController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Регистрация"),
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
          return Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      InputAuth(
                        label: "Электронная почта",
                        hintText: "Введите электронную почту",
                        icon: email,
                        controller: emailController,
                        validator: _validateEmail,
                        obscureText: false,
                      ),
                      const SizedBox(height: 16),
                      InputAuth(
                        label: "Пароль",
                        hintText: "Введите пароль",
                        icon: lock,
                        controller: passwordController1,
                        validator: _validatePassword,
                        obscureText: true,
                      ),
                      const SizedBox(height: 16),
                      InputAuth(
                        label: "Повторите пароль",
                        hintText: "Повторно введите пароль",
                        icon: lock,
                        controller: passwordController2,
                        validator: _validateConfirmPassword,
                        obscureText: true,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ButtonWidget(
                          hasColor: true,
                          hasColorText: true,
                          text: 'Создать аккаунт',
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthBloc>().add(SignUpRequested(
                                    email: emailController.text.trim(),
                                    password: passwordController1.text.trim(),
                                  ));
                            }
                          },
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ButtonWidget(
                          hasColorText: false,
                          text: 'Войти',
                          onPressed: () {
                            context.go("/signin");
                          },
                          color: const Color.fromRGBO(79, 82, 255, 0.16),
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

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Повторите пароль';
    }
    if (value != passwordController1.text) {
      return 'Пароли не совпадают';
    }
    return null;
  }
}
