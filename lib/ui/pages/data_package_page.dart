import 'package:bank_sha/shared/shared_method.dart';
import 'package:bank_sha/shared/theme.dart';
import 'package:bank_sha/ui/widgets/button.dart';
import 'package:flutter/material.dart';

import '../widgets/data_package_item.dart';
import '../widgets/forms.dart';
import '../widgets/transfer_recent_user_item.dart';
import '../widgets/transfer_search_user_item.dart';

class DataPackagePage extends StatelessWidget {
  const DataPackagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Paket Data',
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        children: [
          const SizedBox(
            height: 40,
          ),
          Text(
            'Phone Number',
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semibold,
            ),
          ),
          const CustomFormField(
            title: 'by Username',
            isShowTitle: false,
            maginTextToBox: 14,
            hint: '+628',
          ),
          buildResults(context),
        ],
      ),
    );
  }
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
          'Select Package',
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
            DataPackageItem(
              amount: 10,
              price: 218000,
              isSelected: false,
            ),
            DataPackageItem(
              amount: 25,
              price: 420000,
              isSelected: false,
            ),
            DataPackageItem(
              amount: 40,
              price: 2500000,
              isSelected: true,
            ),
            DataPackageItem(
              amount: 99,
              price: 5000000,
              isSelected: false,
            ),
          ],
        ),
        const SizedBox(
          height: 85,
        ),
        CustomFilledButton(
          title: 'Continue',
          onPressed: () async {
            // cek jika pin true maka kirim ke halaman data-success
            if (await Navigator.pushNamed(context, '/pin') == true) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/data-success',
                (route) => false,
              );
            }
          },
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    ),
  );
}
