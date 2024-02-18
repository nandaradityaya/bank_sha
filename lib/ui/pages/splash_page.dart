import 'dart:async';

import 'package:bank_sha/blocs/auth/auth_bloc.dart';
import 'package:bank_sha/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      // kondisi AuthSuccess ketika user masih memilii credential jadi langsung ke home
      // kondisi AuthFailed ketika user tidak memilii credential jadi ke halaman onboarding
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        }

        if (state is AuthFailed) {
          Navigator.pushNamedAndRemoveUntil(
              context, '/onboarding', (route) => false);
        }
      },
      child: Scaffold(
        backgroundColor: darkBackgroundColor,
        body: Center(
          child: Container(
            width: 155,
            height: 50,
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage(
                'assets/img_logo_dark.png',
              ),
            )),
          ),
        ),
      ),
    );
  }
}
