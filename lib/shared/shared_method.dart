import 'package:another_flushbar/flushbar.dart';
import 'package:bank_sha/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

// bikin di folder shared agar reusable dan dapat digunakan di halaman mana pun
void showCustomSnackbar(BuildContext context, String Message) {
  Flushbar(
    message: Message,
    flushbarPosition: FlushbarPosition.TOP,
    backgroundColor: redColor,
    duration: const Duration(
      seconds: 2,
    ),
  ).show(context);
}

// format mata uangnya agar semuanya sama
String formatCurrency(
  num number, {
  String symbol = 'Rp ',
}) {
  return NumberFormat.currency(
    locale: 'id',
    symbol: symbol,
    decimalDigits: 0,
  ).format(number);
}

// function type XFile dibuat nullable. karna dia mau ambil gambar
// pake Future karna ada async
Future<XFile?> selectImage() async {
  XFile? selectedImage =
      await ImagePicker().pickImage(source: ImageSource.gallery);

  return selectedImage;
}
