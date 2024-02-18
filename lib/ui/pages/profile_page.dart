import 'package:bank_sha/blocs/auth/auth_bloc.dart';
import 'package:bank_sha/shared/shared_method.dart';
import 'package:bank_sha/shared/theme.dart';
import 'package:bank_sha/ui/widgets/button.dart';
import 'package:bank_sha/ui/widgets/profile_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Profile',
        ),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          // jalankan listener ketika user klik Logout
          if (state is AuthFailed) {
            showCustomSnackbar(context, state.e);
          }
          // klo success logout di bloc statenya AuthInitial maka di sini masukin AuthInitial
          if (state is AuthInitial) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/sign-in',
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 22,
                ),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/img_profile.png'),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: whiteColor,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.check_circle,
                              color: greenColor,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Shayna Hanna',
                      style: blackTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: medium,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ProfileMenuItem(
                      title: 'Edit Profile',
                      urlIcon: 'assets/ic_edit_profile.png',
                      onTap: () async {
                        // jika navigator benar ke halaman true maka ketika user memasukan pin akan pindah ke halaman profile edit
                        if (await Navigator.pushNamed(context, '/pin') ==
                            true) {
                          Navigator.pushNamed(context, '/profile-edit');
                        }
                      },
                    ),
                    ProfileMenuItem(
                      title: 'My Pin',
                      urlIcon: 'assets/ic_mypin.png',
                      onTap: () async {
                        if (await Navigator.pushNamed(context, '/pin') ==
                            true) {
                          Navigator.pushNamed(context, '/profile-edit-pin');
                        }
                      },
                    ),
                    ProfileMenuItem(
                      title: 'Wallet Settings',
                      urlIcon: 'assets/ic_walletsetting.png',
                      onTap: () {},
                    ),
                    ProfileMenuItem(
                      title: 'My Reward',
                      urlIcon: 'assets/ic_reward.png',
                      onTap: () {},
                    ),
                    ProfileMenuItem(
                      title: 'Help Center',
                      urlIcon: 'assets/ic_helpcenter.png',
                      onTap: () {},
                    ),
                    ProfileMenuItem(
                      title: 'Log Out',
                      urlIcon: 'assets/ic_logout.png',
                      onTap: () {
                        context.read<AuthBloc>().add(AuthLogOut());
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 87,
              ),
              CustomTextButton(
                title: 'Report a Problem',
                onPressed: () {},
              ),
              const SizedBox(
                height: 50,
              )
            ],
          );
        },
      ),
    );
  }
}
