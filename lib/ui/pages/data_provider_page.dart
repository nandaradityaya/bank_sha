import 'package:bank_sha/shared/shared_method.dart';
import 'package:bank_sha/shared/theme.dart';
import 'package:bank_sha/ui/widgets/button.dart';
import 'package:bank_sha/ui/widgets/data_provider_item.dart';
import 'package:flutter/material.dart';

import '../widgets/topup_bank_item.dart';

class DataProviderPage extends StatelessWidget {
  const DataProviderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Beli Data'),
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
            'From Wallet',
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semibold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Image.asset(
                'assets/img_wallet.png',
                width: 80,
                height: 55,
              ),
              const SizedBox(
                width: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '8008 2208 1280',
                    style: blackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: medium,
                    ),
                  ),
                  Text(
                    'Balance: ${formatCurrency(180000000)}',
                    style: greyTextStyle.copyWith(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Text(
            'Select Provider',
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semibold,
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          const DataProviderItem(
            iconUrl: 'assets/imp_provider_telkomsel.png',
            nameProvider: 'Telkomsel',
            available: 'Available',
            isSelected: true,
          ),
          const DataProviderItem(
            iconUrl: 'assets/imp_provider_indosat.png',
            nameProvider: 'Indosat Ooredoo',
            available: 'Available',
          ),
          const DataProviderItem(
            iconUrl: 'assets/imp_provider_singtel.png',
            nameProvider: 'Singtel ID',
            available: 'Available',
          ),
          const SizedBox(
            height: 135,
          ),
          CustomFilledButton(
            title: 'Continue',
            onPressed: () {
              Navigator.pushNamed(context, '/data-package');
            },
          ),
          const SizedBox(
            height: 57,
          ),
        ],
      ),
    );
  }
}
