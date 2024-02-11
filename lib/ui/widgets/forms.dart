import 'package:flutter/material.dart';

import '../../shared/theme.dart';

class CustomFormField extends StatelessWidget {
  final String title;
  final double maginTextToBox;
  final String? hint;
  final bool obscuretext; // untuk password
  final bool isShowTitle;
  final TextEditingController?
      controller; // controller untuk mengambil value dari textformfield
  final TextInputType? keyboardType;

  const CustomFormField({
    super.key,
    required this.title,
    this.maginTextToBox = 8,
    this.hint,
    this.obscuretext = false, // nilai defaultnya false namun bisa di ubah
    this.controller,
    this.isShowTitle = true,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // kondisi tampilin label atau tidak
        if (isShowTitle)
          Text(
            title,
            style: blackTextStyle.copyWith(
              fontWeight: medium,
            ),
          ),
        SizedBox(
          height: maginTextToBox,
        ),
        TextFormField(
          obscureText: obscuretext,
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            contentPadding: const EdgeInsets.all(12),
          ),
        ),
      ],
    );
  }
}
