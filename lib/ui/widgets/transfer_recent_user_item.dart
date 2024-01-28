import 'package:bank_sha/shared/theme.dart';
import 'package:flutter/material.dart';

class TransferRecentUserItem extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String username;
  final bool isVerified;
  final bool isSelected;

  const TransferRecentUserItem({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.username,
    this.isVerified = false,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 90,
      margin: const EdgeInsets.only(
        bottom: 18,
      ),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? blueColor : whiteColor,
          width: 2,
        ),
      ),
      child: Row(
        children: [
          Image.asset(
            imageUrl,
            width: 45,
            height: 45,
          ),
          const SizedBox(
            width: 14,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: blackTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: medium,
                ),
              ),
              Text(
                '@$username',
                style: greyTextStyle.copyWith(
                  fontSize: 12,
                ),
              )
            ],
          ),
          const Spacer(),
          if (isVerified)
            Center(
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: greenColor,
                    size: 14,
                  ),
                  Text(
                    'Verified',
                    style: greenTextStyle.copyWith(
                      fontSize: 11,
                      fontWeight: medium,
                    ),
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }
}
