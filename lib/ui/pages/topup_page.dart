import 'package:bank_sha/blocs/auth/auth_bloc.dart';
import 'package:bank_sha/shared/theme.dart';
import 'package:bank_sha/ui/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/topup_bank_item.dart';

class TopupPage extends StatelessWidget {
  const TopupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Up'),
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'Wallet',
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semibold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is AuthSuccess) {
                      return Row(
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
                                // function replaceAllMapped menggunakan Regex dan menggambil 4 digit lalu match.group(0) dengan spasi kosong = ini maka setiap 4 angka akan di kasih spasi
                                state.user.cardNumber!.replaceAllMapped(
                                    RegExp(r".{4}"),
                                    (match) => "${match.group(0)} "),
                                style: blackTextStyle.copyWith(
                                  fontSize: 16,
                                  fontWeight: medium,
                                ),
                              ),
                              Text(
                                state.user.name.toString(),
                                style: greyTextStyle.copyWith(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }
                    return Container();
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  'Select Bank',
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semibold,
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                const TopupBankItem(
                  iconUrl: 'assets/img_bank_bca.png',
                  nameBank: 'Bank BCA',
                  duration: '50 mins',
                  isSelected: true, // set isSelected to true
                ),
                const TopupBankItem(
                  iconUrl: 'assets/img_bank_bni.png',
                  nameBank: 'Bank BNI',
                  duration: '50 mins',
                ),
                const TopupBankItem(
                  iconUrl: 'assets/img_bank_mandiri.png',
                  nameBank: 'Bank Mandiri',
                  duration: '50 mins',
                ),
                const TopupBankItem(
                  iconUrl: 'assets/img_bank_ocbc.png',
                  nameBank: 'Bank OCBC',
                  duration: '50 mins',
                ),
                const SizedBox(
                  height: 12,
                ),
                CustomFilledButton(
                  title: 'Continue',
                  onPressed: () {
                    Navigator.pushNamed(context, '/topup-amoount');
                  },
                ),
                const SizedBox(
                  height: 57,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
