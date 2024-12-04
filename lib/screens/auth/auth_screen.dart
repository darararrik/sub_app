import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sub_app/core/theme.dart';
import 'package:sub_app/core/widgets/button_widget.dart';
import 'package:sub_app/core/widgets/text_field_widget.dart';
import 'package:sub_app/screens/auth/sign_in_screen.dart';
import 'package:sub_app/screens/profile/bloc/auth_bloc.dart';
import 'package:sub_app/screens/profile/profile_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController1 = TextEditingController();
  final TextEditingController passwordController2 = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()));
          }
        },
        child: Center(
          child: Form(
            key: _formKey, // Добавляем GlobalKey для формы
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Регистрация",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    textAlign: TextAlign.center,
                    "Создайте аккаунт, чтобы синхронизировать переводы на своих устройствах",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
                const SizedBox(
                  height: 36,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 48,
                        child: TextFieldWidget(
                          obscureText: false,
                          controller: emailController,
                          validator: _validateEmail,
                          label: 'Электронная почта',
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      SizedBox(
                        height: 48,
                        child: TextFieldWidget(
                          label: "Введите пароль",
                          controller: passwordController1,
                          obscureText: true,
                          validator: _validatePassword, // Добавлена валидация
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      SizedBox(
                        height: 48,
                        child: TextFieldWidget(
                          controller: passwordController2,
                          obscureText: true,
                          validator: _validateConfirmPassword,
                          label:
                              'Введите пароль', // Проверка совпадения паролей
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 36,
                ),
                SizedBox(
                  width: 300,
                  child: ButtonWidget(
                    text: 'Создать аккаунт',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Если форма прошла валидацию
                        context.read<AuthBloc>().add(SignUpRequested(
                            email: emailController.text.trim(),
                            password: passwordController1.text.trim()));
                      }
                    },
                    color: primaryColor,
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: ButtonWidget(
                    hasColor: false,
                    text: 'Войти',
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignInScreen()));
                    },
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
