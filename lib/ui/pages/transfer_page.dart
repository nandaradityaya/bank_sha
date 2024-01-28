import 'package:bank_sha/shared/theme.dart';
import 'package:bank_sha/ui/widgets/button.dart';
import 'package:flutter/material.dart';

import '../widgets/forms.dart';
import '../widgets/transfer_recent_user_item.dart';
import '../widgets/transfer_search_user_item.dart';

class TransferPage extends StatelessWidget {
  const TransferPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Transfer',
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        children: [
          const SizedBox(
            height: 30,
          ),
          Text(
            'Search',
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semibold,
            ),
          ),
          const CustomFormField(
            title: 'by Username',
            isShowTitle: false, // jangan tampilin label
            maginTextToBox: 14,
            hint: 'by username',
          ),
          // buildRecentUsers(),
          buildResults(context),
        ],
      ),
    );
  }
}

Widget buildRecentUsers() {
  return Container(
    margin: const EdgeInsets.only(
      top: 40,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Users',
          style: blackTextStyle.copyWith(
            fontSize: 16,
            fontWeight: semibold,
          ),
        ),
        const SizedBox(
          height: 14,
        ),
        const TransferRecentUserItem(
          imageUrl: 'assets/img_friend1.png',
          name: 'Yonna Jie',
          username: 'yoenna',
          isVerified: true,
        ),
        const TransferRecentUserItem(
          imageUrl: 'assets/img_friend3.png',
          name: 'John Hi',
          username: 'jhi',
          isSelected: true,
        ),
        const TransferRecentUserItem(
          imageUrl: 'assets/img_friend4.png',
          name: 'Masayoshi',
          username: 'form',
        ),
      ],
    ),
  );
}

Widget buildResults(BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(
      top: 40,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Users',
          style: blackTextStyle.copyWith(
            fontSize: 16,
            fontWeight: semibold,
          ),
        ),
        const SizedBox(
          height: 14,
        ),
        const Wrap(
          spacing: 17,
          runSpacing: 17,
          children: [
            TransferSearchUserItem(
              imageUrl: 'assets/img_friend1.png',
              name: 'Yonna Jie',
              username: 'yoenna',
              isVerified: true,
            ),
            TransferSearchUserItem(
              imageUrl: 'assets/img_friend2.png',
              name: 'Yonne Ka',
              username: 'yoenyu',
              isVerified: true,
              isSelected: true,
            ),
          ],
        ),
        const SizedBox(
          height: 275,
        ),
        CustomFilledButton(
          title: 'Continue',
          onPressed: () {
            Navigator.pushNamed(context, '/transfer-amount');
          },
        ),
        const SizedBox(
          height: 50,
        ),
      ],
    ),
  );
}
