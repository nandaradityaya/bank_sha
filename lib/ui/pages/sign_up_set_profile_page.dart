import 'dart:convert';
import 'dart:io';

import 'package:bank_sha/models/sign_up_form_model.dart';
import 'package:bank_sha/shared/shared_method.dart';
import 'package:bank_sha/ui/pages/sign_up_set_ktp_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../shared/theme.dart';
import '../widgets/button.dart';
import '../widgets/forms.dart';

class SignUpSetProfilePage extends StatefulWidget {
  final SignUpFormModel
      data; // bawa data yg udah di input di halaman sebelumnya

  const SignUpSetProfilePage({
    super.key,
    required this.data,
  });

  @override
  State<SignUpSetProfilePage> createState() => _SignUpSetProfilePageState();
}

class _SignUpSetProfilePageState extends State<SignUpSetProfilePage> {
  final pinController = TextEditingController(text: '');
  XFile? selectedImage; // package imagePicker

  bool validate() {
    if (pinController.text.length != 6) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
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
                      ),
                      child: selectedImage != null
                          ? null
                          : Center(
                              child: Image.asset(
                                'assets/ic_upload.png',
                                width: 32,
                                height: 32,
                              ),
                            ),
                    ),
                  ),
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: selectedImage == null
                          ? null
                          : DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(
                                File(selectedImage!.path),
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
                    height: 30,
                  ),
                  CustomFormField(
                    title: 'Set PIN (6 digit number)',
                    obscuretext: true,
                    controller: pinController,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomFilledButton(
                    title: 'Continue',
                    onPressed: () {
                      if (validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpSetKtpPage(
                              data: widget.data.copyWith(
                                pin: pinController.text,
                                profilePicture: selectedImage == null
                                    ? null
                                    : 'data:image/png;base64,${base64Encode(
                                        File(selectedImage!.path)
                                            .readAsBytesSync(),
                                      )}',
                              ),
                            ),
                          ),
                        );
                        // widget.data.copyWith(
                        //   pin: pinController.text,
                        //   profilePicture: selectedImage == null
                        //       ? null
                        //       : 'data:image/png;base64,${base64Encode(
                        //           File(selectedImage!.path).readAsBytesSync(),
                        //         )}',
                        // );
                        // print(widget.data.toJson());
                      } else {
                        showCustomSnackbar(context, 'Pin Harus 6 Digit');
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
