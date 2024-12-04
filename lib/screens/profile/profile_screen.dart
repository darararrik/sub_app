import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sub_app/core/theme.dart';
import 'package:sub_app/repositories/model/user/user.dart';
import 'package:sub_app/screens/auth/auth_screen.dart';
import 'package:sub_app/screens/change_password_screen/change_password_screen.dart';
import 'package:sub_app/screens/delete_account/delete_account_screen.dart';
import 'package:sub_app/screens/profile/bloc/auth_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthCheckRequested());
  }

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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChangePasswordScreen()));
                  }),
              PopupMenuItem(
                  child: const Text('Удалить аккаунт'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DeleteAccountScreen()));
                  }),
            ],
          ),
        ],
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Unauthenticated) {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AuthScreen()));
          }
        },
        builder: (context, AuthState state) {
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
                    // const SizedBox(
                    //   height: 24,
                    // ),
                    // ButtonWidget(
                    //   text: "Выйти",
                    //   onPressed: () {},
                    //   color: Theme.of(context).colorScheme.error,
                    // )
                  ],
                ),
              ),
            );
          }
          if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}