// import 'package:bank_sha/models/transfer_model.dart';
import 'package:bank_sha/models/transfer_form_model.dart';
import 'package:bank_sha/shared/theme.dart';
import 'package:bank_sha/ui/pages/transfer_amount_page.dart';
import 'package:bank_sha/ui/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/user/user_bloc.dart';
import '../../models/user_model.dart';
import '../widgets/forms.dart';
import '../widgets/transfer_recent_user_item.dart';
import '../widgets/transfer_search_user_item.dart';

class TransferPage extends StatefulWidget {
  const TransferPage({super.key});

  @override
  State<TransferPage> createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  final usernameController = TextEditingController(text: '');
  UserModel? selectedUser;

  late UserBloc userBloc;

  @override
  void initState() {
    super.initState();

    // ini untuk ambil recent user terlebih dahulu, karna di halaman ini ketika baru di buka akan muncul recent user yg baru di transfer uang
    userBloc = context.read<UserBloc>()..add(UserGetRecent());
  }

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
            height: 40,
          ),
          Text(
            'Search',
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semibold,
            ),
          ),
          CustomFormField(
            title: 'by Username',
            isShowTitle: false, // jangan tampilin label
            maginTextToBox: 14,
            hint: 'by username',
            controller: usernameController,
            // fungsi ini adalah untuk ketika melakukan submit dia akan melakukan listener
            onFieldSubmitted: (value) {
              if (value.isNotEmpty) {
                userBloc.add(UserGetByUsername(usernameController.text));
              } else {
                // ketika searchfield kosong maka tombol continue hilangkan
                selectedUser = null;
                userBloc.add(UserGetRecent());
              }
              setState(() {});
            },
          ),
          // jika search bar kosong maka tambilin widget buildRecentUsers, klo search bar di isi oleh user maka munculkan hasil pencarian
          usernameController.text.isEmpty ? buildRecentUsers() : buildResults(),
        ],
      ),
      floatingActionButton: selectedUser != null
          ? Container(
              margin: const EdgeInsets.all(24),
              child: CustomFilledButton(
                  title: 'Continue',
                  onPressed: () {
                    // Navigator.pushNamed(context, '/transfer-amount');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TransferAmountPage(
                          data: TransferFormModel(
                            // kirim ke selectedUser.usernamenya (pake tanda seru biar pastiin bahwa dia terselect)
                            sendTo: selectedUser!.username,
                          ),
                        ),
                      ),
                    );
                  }),
            )
          : Container(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
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
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserSuccess) {
                return Column(
                  children: state.users.map((user) {
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TransferAmountPage(
                                  data: TransferFormModel(
                                    // kirim ke username yg di pilih
                                    sendTo: user.username,
                                  ),
                                ),
                              ));
                        },
                        child: TransferRecentUserItem(user: user));
                  }).toList(),
                );
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildResults() {
    return Container(
      margin: const EdgeInsets.only(
        top: 40,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Result',
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semibold,
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserSuccess) {
                  return Wrap(
                    spacing: 17,
                    runSpacing: 17,
                    children: state.users.map((user) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            setState(() {
                              selectedUser = user;
                            });
                          });
                        },
                        child: TransferSearchUserItem(
                          user: user,
                          isSelected: user.id == selectedUser?.id,
                        ),
                      );
                    }).toList(),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
