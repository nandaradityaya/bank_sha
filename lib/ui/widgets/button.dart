import 'package:flutter/material.dart';

import '../../shared/theme.dart';

class CustomFilledButton extends StatelessWidget {
  // ini adalah constructor
  final String title;
  final double width;
  final double height;
  final VoidCallback? onPressed;

  const CustomFilledButton({
    super.key,
    // ini adalah parameter yang di butuhkan
    required this.title,
    this.width = double
        .infinity, // boleh di isi atau ngga, kl ngga di isi maka akan mengambil nilai width sesuai dengan lebar parentnya, double.infinity artinya selebar parentnya
    this.height = 50,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
            backgroundColor: purpleColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(56),
            )),
        child: Text(
          title,
          style: whiteTextStyle.copyWith(
            fontSize: 16,
            fontWeight: semibold,
          ),
        ),
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  final String title;
  final double width;
  final double height;
  final VoidCallback? onPressed;

  const CustomTextButton({
    super.key,
    required this.title,
    this.width = double.infinity,
    this.height = 24,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: Text(
          title,
          style: greyTextStyle.copyWith(
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

class InputButtonPin extends StatelessWidget {
  final String number;
  final VoidCallback? onTap;

  const InputButtonPin({
    super.key,
    required this.number,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: numberBackgroundColor,
        ),
        child: Center(
          child: Text(
            number,
            style: whiteTextStyle.copyWith(
              fontSize: 22,
              fontWeight: semibold,
            ),
          ),
        ),
      ),
    );
  }
}
