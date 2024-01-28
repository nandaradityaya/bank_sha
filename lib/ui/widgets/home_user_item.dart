import 'package:bank_sha/shared/theme.dart';
import 'package:flutter/material.dart';

class HomeUserItem extends StatelessWidget {
  final String imageUrl;
  final String username;
  // gaperlu on tap karena sudah ada username

  const HomeUserItem({
    super.key,
    required this.imageUrl,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 120,
      margin: const EdgeInsets.only(right: 17),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 45,
            height: 45,
            margin: const EdgeInsets.only(
              bottom: 13,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  imageUrl,
                ),
              ),
            ),
          ),
          Text(
            '@$username',
            style: blackTextStyle.copyWith(
              fontSize: 12,
              fontWeight: medium,
            ),
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
