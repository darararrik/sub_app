import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sub_app/core/theme.dart';
import 'package:sub_app/repositories/model/user/user.dart';
import 'package:sub_app/screens/profile/bloc/auth_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    User user;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Ваш аккаунт"),
        elevation: 4,
        shadowColor: const Color.fromRGBO(0, 0, 0, 0.2),
        actions: [
          PopupMenuButton<String>(
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
          ),
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
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 40),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 24),
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                          color: primaryColor,
                          // border: Border.all(width: 20, color: Colors.white),
                          shape: BoxShape.circle),
                      child: const Icon(
                        Icons.person_outline_rounded,
                        size: 200,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      "Электронная почта",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      user.email,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
