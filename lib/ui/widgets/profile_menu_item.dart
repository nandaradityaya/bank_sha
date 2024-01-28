import 'package:bank_sha/shared/theme.dart';
import 'package:flutter/material.dart';

class ProfileMenuItem extends StatelessWidget {
  final String title;
  final String urlIcon;
  final VoidCallback? onTap;

  const ProfileMenuItem({
    super.key,
    required this.title,
    required this.urlIcon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 30,
        ),
        child: Row(
          children: [
            Image.asset(
              urlIcon,
              width: 24,
            ),
            const SizedBox(
              width: 18,
            ),
            Text(
              title,
              style: blackTextStyle.copyWith(
                fontWeight: medium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
