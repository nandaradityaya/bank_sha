import 'package:bank_sha/blocs/auth/auth_bloc.dart';
import 'package:bank_sha/shared/shared_method.dart';
import 'package:bank_sha/shared/theme.dart';
import 'package:bank_sha/ui/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PinPage extends StatefulWidget {
  const PinPage({super.key});

  @override
  State<PinPage> createState() => _PinPageState();
}

class _PinPageState extends State<PinPage> {
  final TextEditingController pinController =
      TextEditingController(text: ''); // initial value

  String pin = '';
  bool isError = false; // set jika pin salah maka tulisan merah

  addPin(String number) {
    // jika panjang pin kurang dari 6 maka akan menambahkan angka, tapi klo udah ada 6 angka maka gabisa nambah lagi
    if (pinController.text.length < 6) {
      setState(() {
        pinController.text = pinController.text + number;
      }); // add number from button which is tapped
    }

    // cek pinnya sampe 6 karakter text
    if (pinController.text.length == 6) {
      if (pinController.text == pin) {
        Navigator.pop(context, true); // kirim ke halaman yang di tuju
      } else {
        setState(() {
          isError = true; // set jika pin salah maka tulisan merah
        });
        // tampilin package snackbar jika pin salah
        showCustomSnackbar(
          context,
          'PIN yang anda masukkan salah. Silakan coba lagi.',
        );
      }
    }
  }

  deletPin() {
    // jika pin tidak kosong maka sistem bisa utk menghapus 1 angka, tapi klo udah kosong maka gabisa dihapus lagi lahh!
    if (pinController.text.isNotEmpty) {
      setState(() {
        isError = false;
        pinController.text =
            pinController.text.substring(0, pinController.text.length - 1);
      }); // delete last character | dari 0 sampai panjang karakter - 1, jadi karakter terakhir akan dihapus
    }
  }

  // jalankan function initState ketika PinPage di jalankan
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final state = context.read<AuthBloc>().state;
    if (state is AuthSuccess) {
      pin = state
          .user.pin!; // pake tanda seru agar memastikan bahwa pinnya tidak null
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBackgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 58,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sha PIN',
                style: whiteTextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: semibold,
                ),
              ),
              const SizedBox(
                height: 72,
              ),
              SizedBox(
                width: 200,
                child: TextFormField(
                  controller:
                      pinController, // controller untuk mengambil value pin
                  obscureText: true,
                  obscuringCharacter:
                      '*', // This is optional for customizing character
                  cursorColor: greyColor, // color cursor
                  enabled:
                      false, // set agar disable textfieldnya, karna pin di masukan dari ontap
                  style: whiteTextStyle.copyWith(
                    fontSize: 36,
                    fontWeight: medium,
                    letterSpacing: 16, // space between character
                    color: isError ? redColor : whiteColor,
                  ),
                  decoration: InputDecoration(
                    disabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: greyColor,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: greyColor,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 66,
              ),
              // wrap untuk membuat item berada dalam satu baris
              Wrap(
                spacing: 40,
                runSpacing: 40,
                children: [
                  InputButtonPin(
                    number: '1',
                    onTap: () {
                      addPin('1');
                    },
                  ),
                  InputButtonPin(
                    number: '2',
                    onTap: () {
                      addPin('2');
                    },
                  ),
                  InputButtonPin(
                    number: '3',
                    onTap: () {
                      addPin('3');
                    },
                  ),
                  InputButtonPin(
                    number: '4',
                    onTap: () {
                      addPin('4');
                    },
                  ),
                  InputButtonPin(
                    number: '5',
                    onTap: () {
                      addPin('5');
                    },
                  ),
                  InputButtonPin(
                    number: '6',
                    onTap: () {
                      addPin('6');
                    },
                  ),
                  InputButtonPin(
                    number: '7',
                    onTap: () {
                      addPin('7');
                    },
                  ),
                  InputButtonPin(
                    number: '8',
                    onTap: () {
                      addPin('8');
                    },
                  ),
                  InputButtonPin(
                    number: '9',
                    onTap: () {
                      addPin('9');
                    },
                  ),
                  // sized box kosoong untuk membuat button 0 berada di tengah
                  const SizedBox(
                    width: 60,
                    height: 60,
                  ),
                  InputButtonPin(
                    number: '0',
                    onTap: () {
                      addPin('0');
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      deletPin();
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: numberBackgroundColor,
                      ),
                      child: Center(
                          child: Icon(
                        Icons.arrow_back,
                        color: whiteColor,
                        size: 24,
                      )),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
