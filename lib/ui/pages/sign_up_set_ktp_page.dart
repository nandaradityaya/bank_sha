import 'dart:convert';
import 'dart:io';

import 'package:bank_sha/blocs/auth/auth_bloc.dart';
import 'package:bank_sha/shared/shared_method.dart';
import 'package:flutter/material.dart';
import 'package:bank_sha/models/sign_up_form_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../shared/theme.dart';
import '../widgets/button.dart';

class SignUpSetKtpPage extends StatefulWidget {
  final SignUpFormModel data;

  const SignUpSetKtpPage({super.key, required this.data});

  @override
  State<SignUpSetKtpPage> createState() => _SignUpSetKtpPageState();
}

class _SignUpSetKtpPageState extends State<SignUpSetKtpPage> {
  XFile? selectedImage;

  bool validate() {
    if (selectedImage == null) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailed) {
            showCustomSnackbar(context, state.e);
          }

          if (state is AuthSuccess) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/home',
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
              Container(
                width: 155,
                height: 50,
                margin: const EdgeInsets.only(
                  top: 100,
                  bottom: 100,
                ),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/img_logo_light.png'),
                  ),
                ),
              ),
              Text(
                'Join Us to Unlock\nYour Growth',
                style: blackTextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: semibold,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: whiteColor,
                ),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          final image = await selectImage();
                          setState(() {
                            selectedImage = image;
                          });
                        },
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: lightBackgroundColor,
                              image: selectedImage == null
                                  ? null
                                  : DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(
                                        File(selectedImage!.path),
                                      ),
                                    )),
                          child: selectedImage != null
                              ? null
                              : Center(
                                  child: Image.asset(
                                    'assets/ic_upload.png',
                                    width: 32,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Passport/ID Card',
                        style: blackTextStyle.copyWith(
                          fontSize: 18,
                          fontWeight: medium,
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      CustomFilledButton(
                        title: 'Continue',
                        onPressed: () {
                          if (validate()) {
                            // Navigator.pushNamed(context, '/sign-up-success');
                            context.read<AuthBloc>().add(
                                  AuthRegister(
                                    // datanya ambil dari widget.data
                                    widget.data.copyWith(
                                      ktp: selectedImage == null
                                          ? null
                                          : 'data:image/png;base64,${base64Encode(
                                              File(selectedImage!.path)
                                                  .readAsBytesSync(),
                                            )}',
                                    ),
                                  ),
                                );
                          } else {
                            showCustomSnackbar(
                                context, 'Gambar Tidak Boleh Kosong');
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              CustomTextButton(
                title: 'Skip for Now',
                onPressed: () {
                  context.read<AuthBloc>().add(
                        AuthRegister(
                          // datanya ambil dari widget.data
                          widget.data,
                        ),
                      );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
