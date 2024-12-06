import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sub_app/core/theme.dart';
import 'package:sub_app/core/widgets/button_widget.dart';
import 'package:sub_app/core/widgets/text_field_widget.dart';
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
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
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
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Создайте аккаунт",
                        style: TextStyle(
                            fontSize: 36,
                            color: primaryColor,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "Введите детали",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Column(
                        children: [
                          Column(
                            children: [
                              TextFieldWidget(
                                obscureText: false,
                                controller: emailController,
                                validator: _validateEmail,
                                hintText: 'Введи электронную почту',
                                labelText: 'Электронная почта',
                              ),
                              const SizedBox(height: 24),
                              TextFieldWidget(
                                hintText: "Пароль",
                                controller: passwordController1,
                                obscureText: true,
                                validator: _validatePassword,
                                labelText: 'Введите пароль',
                              ),
                              const SizedBox(height: 24),
                              TextFieldWidget(
                                controller: passwordController2,
                                obscureText: true,
                                validator: _validateConfirmPassword,
                                hintText: 'Повторно введите пароль',
                                labelText: 'Повторите пароль',
                              ),
                            ],
                          ),
                          const SizedBox(height: 36),
                        ],
                      ),
                    ],
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
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ButtonWidget(
                          text: 'Войти',
                          onPressed: () {
                            context.go("/signin");
                          },
                          color: const Color.fromARGB(64, 116, 119, 253),
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
