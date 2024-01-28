import 'package:flutter/material.dart';

import '../../shared/theme.dart';
import '../widgets/button.dart';
import '../widgets/forms.dart';

class ProfileEditPinPage extends StatelessWidget {
  const ProfileEditPinPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Pin',
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
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: whiteColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomFormField(
                  title: 'Old Pin',
                ),
                const CustomFormField(
                  title: 'New Pin',
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomFilledButton(
                  title: 'Update Now',
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      // and remove until agar setelah masuk ke halaman tersebut maka tidak bisa kembali ke halaman sebelumnya
                      context,
                      '/profile-edit-success',
                      (route) =>
                          false, // false agar tidak bisa kembali ke halaman sebelumnya
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
