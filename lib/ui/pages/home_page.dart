import 'package:bank_sha/shared/shared_method.dart';
import 'package:bank_sha/shared/theme.dart';
import 'package:bank_sha/ui/widgets/home_latest_transaction_item.dart';
import 'package:bank_sha/ui/widgets/home_service_item.dart';
import 'package:bank_sha/ui/widgets/home_tips_item.dart';
import 'package:bank_sha/ui/widgets/home_user_item.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: whiteColor,
        shape: const CircularNotchedRectangle(),
        clipBehavior: Clip.antiAlias,
        notchMargin: 6,
        elevation: 0,
        child: BottomNavigationBar(
          type: BottomNavigationBarType
              .fixed, // ini untuk menampilkan semua item agar tidak ada yang hilang
          elevation: 0,
          backgroundColor: whiteColor,
          selectedItemColor: blueColor,
          unselectedItemColor: blackColor,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedLabelStyle: blueTextStyle.copyWith(
            fontSize: 10,
            fontWeight: medium,
          ),
          unselectedLabelStyle: blackTextStyle.copyWith(
            fontSize: 10,
            fontWeight: medium,
          ),
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/ic_overview.png',
                width: 20,
                color: blueColor,
              ),
              label: 'Overview',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/ic_history.png',
                width: 20,
              ),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/ic_statistic.png',
                width: 20,
              ),
              label: 'Statistic',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/ic_reward.png',
                width: 20,
              ),
              label: 'Reward',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: purpleColor,
        child: Image.asset(
          'assets/ic_plus_circle.png',
          width: 24,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        children: [
          buildProfile(context), // pake context karena ada navigator
          buildWalletCard(),
          buildLevel(),
          buildServices(context),
          buildLatestTransaction(),
          buildSendAgain(),
          buildTips(),
        ],
      ),
    );
  }

  Widget buildProfile(BuildContext context) {
    // pake BuildContext context karena ada navigator
    return Container(
      margin: const EdgeInsets.only(
        top: 40,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Howdy,',
                style: greyTextStyle.copyWith(
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                'shaynahan',
                style: blackTextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: semibold,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/profile');
            },
            child: Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/img_profile.png'),
                ),
              ),
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: whiteColor,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.check_circle,
                      color: greenColor,
                      size: 14,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildWalletCard() {
    return Container(
      width: double.infinity, // agar lebar container mengikuti layar
      height: 220,
      margin: const EdgeInsets.only(
        top: 30,
      ),
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        image: const DecorationImage(
          fit: BoxFit.cover, // agar gambar tidak pecah
          image: AssetImage('assets/img_bg_card.png'),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Shayna Hanna',
            style: whiteTextStyle.copyWith(
              fontSize: 18,
              fontWeight: medium,
            ),
          ),
          const SizedBox(
            height: 28,
          ),
          Row(
            children: [
              Text(
                '**** **** **** 1280',
                style: whiteTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: medium,
                  letterSpacing: 5, // jarak antar huruf
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 21,
          ),
          Text(
            'Balance',
            style: whiteTextStyle.copyWith(
              fontSize: 14,
            ),
          ),
          Text(
            // format mata uangnya (ada di shared_method)
            formatCurrency(12500),
            style: whiteTextStyle.copyWith(
              fontSize: 24,
              fontWeight: semibold,
            ),
          )
        ],
      ),
    );
  }

  Widget buildLevel() {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: whiteColor,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Level 1',
                style: blackTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: medium,
                ),
              ),
              const Spacer(),
              Text(
                '55%',
                style: greenTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: semibold,
                ),
              ),
              Text(
                ' of ${formatCurrency(20000)}',
                style: blackTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: semibold,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(55),
            child: LinearProgressIndicator(
              minHeight: 5,
              value: 0.55,
              valueColor: AlwaysStoppedAnimation(
                  greenColor), // AlwaysStoppedAnimation adalah untuk membuat warna progress bar tidak berubah
              backgroundColor: lightBackgroundColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildServices(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Do Something',
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semibold,
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HomeServiceItem(
                title: 'Top Up',
                iconUrl: 'assets/ic_topup.png',
                onTap: () {
                  Navigator.pushNamed(context, '/topup');
                },
              ),
              HomeServiceItem(
                title: 'Send',
                iconUrl: 'assets/ic_send.png',
                onTap: () {
                  Navigator.pushNamed(context, '/transfer');
                },
              ),
              HomeServiceItem(
                title: 'Withdraw',
                iconUrl: 'assets/ic_withdraw.png',
                onTap: () {},
              ),
              HomeServiceItem(
                title: 'More',
                iconUrl: 'assets/ic_more.png',
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => const MoreDialog(),
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget buildLatestTransaction() {
    return Container(
      margin: const EdgeInsets.only(
        top: 30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Latest Transactions',
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semibold,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(22),
            margin: const EdgeInsets.only(
              top: 14,
            ),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                HomeLatestTransactionItem(
                  iconUrl: 'assets/ic_transaction_cat1.png',
                  title: 'Top Up',
                  time: 'Yesterday',
                  value: '+ ${formatCurrency(450000, symbol: '')}',
                ),
                HomeLatestTransactionItem(
                  iconUrl: 'assets/ic_transaction_cat2.png',
                  title: 'Cashback',
                  time: 'Sep 11',
                  value: '+ ${formatCurrency(22000, symbol: '')}',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSendAgain() {
    return Container(
      margin: const EdgeInsets.only(
        top: 30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Send Again',
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semibold,
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                HomeUserItem(
                  imageUrl: 'assets/img_friend1.png',
                  username: 'yuanita',
                ),
                HomeUserItem(
                  imageUrl: 'assets/img_friend2.png',
                  username: 'jani',
                ),
                HomeUserItem(
                  imageUrl: 'assets/img_friend3.png',
                  username: 'urip',
                ),
                HomeUserItem(
                  imageUrl: 'assets/img_friend4.png',
                  username: 'masa',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTips() {
    return Container(
      margin: const EdgeInsets.only(
        top: 30,
        bottom: 50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Friendly Tips',
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semibold,
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          // wrap untuk membuat item berada dalam satu baris
          const Wrap(
            spacing: 17, // jarak antar item kanan kiri
            runSpacing: 18, // jarak antar item atas bawah
            children: [
              HomeTipsItem(
                imgUrl: 'assets/img_tips1.png',
                title: 'Best tips for using a credit card',
                url: 'https:/www.google.com',
              ),
              HomeTipsItem(
                imgUrl: 'assets/img_tips2.png',
                title: 'Spot the good pie of finance model',
                url: 'https:/www.google.com',
              ),
              HomeTipsItem(
                imgUrl: 'assets/img_tips3.png',
                title: 'Great hack to get better advices',
                url: 'https:/www.google.com',
              ),
              HomeTipsItem(
                imgUrl: 'assets/img_tips4.png',
                title: 'Save more penny buy this instead',
                url: 'https:/www.google.com',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MoreDialog extends StatelessWidget {
  const MoreDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors
          .transparent, // kasih transparent agar tidak ada warna putih AlertDialog
      insetPadding:
          EdgeInsets.zero, // supaya hanya padding kanan kiri saja pada dialog
      alignment: Alignment.bottomCenter, // supaya posisi alert ada di bawah
      content: Container(
        height: 326,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: lightBackgroundColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Do More With Us',
              style: blackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semibold,
              ),
            ),
            const SizedBox(
              height: 13,
            ),
            Center(
              child: Wrap(
                spacing: 29,
                runSpacing: 28,
                children: [
                  HomeServiceItem(
                    title: 'Data',
                    iconUrl: 'assets/ic_product_data.png',
                    onTap: () {
                      Navigator.pushNamed(context, '/data');
                    },
                  ),
                  HomeServiceItem(
                    title: 'Water',
                    iconUrl: 'assets/ic_product_water.png',
                    onTap: () {},
                  ),
                  HomeServiceItem(
                    title: 'Stream',
                    iconUrl: 'assets/ic_product_stream.png',
                    onTap: () {},
                  ),
                  HomeServiceItem(
                    title: 'Movie',
                    iconUrl: 'assets/ic_product_movie.png',
                    onTap: () {},
                  ),
                  HomeServiceItem(
                    title: 'Food',
                    iconUrl: 'assets/ic_product_food.png',
                    onTap: () {},
                  ),
                  HomeServiceItem(
                    title: 'Travel',
                    iconUrl: 'assets/ic_product_travel.png',
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
