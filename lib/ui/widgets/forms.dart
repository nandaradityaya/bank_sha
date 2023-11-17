import 'package:flutter/material.dart';

import '../../shared/theme.dart';

class CustomFormField extends StatelessWidget {
  final String title;
  final double maginTextToBox;
  final String? hint;
  final bool obscuretext;
  final TextEditingController?
      controller; // controller untuk mengambil value dari textformfield

  const CustomFormField({
    super.key,
    required this.title,
    this.maginTextToBox = 8,
    this.hint,
    this.obscuretext = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
