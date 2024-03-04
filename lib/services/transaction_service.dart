import 'dart:convert';

// import 'package:bank_sha/models/data_plan_model.dart';
import 'package:bank_sha/models/data_plan_form_model.dart';
import 'package:bank_sha/models/topup_form_model.dart';
import 'package:bank_sha/models/transfer_form_model.dart';
// import 'package:bank_sha/models/transaction_model.dart';
import 'package:bank_sha/services/auth_service.dart';
import 'package:bank_sha/shared/shared_values.dart';
import 'package:http/http.dart' as http;

// import '../models/data_form_model.dart';
// import '../models/transfer_model.dart';

class TransactionService {
  Future<String> topUp(TopupFormModel data) async {
    try {
      // ambil token authnya
      final token = await AuthService().getToken();

      final res = await http.post(
        Uri.parse('$baseUrl/top_ups'),
        headers: {
          'Authorization': token,
        },
        body: data.toJson(),
      );

      if (res.statusCode == 200) {
        // decode res.bodynya dulu kemudian ambil value dari redirect_url
        return jsonDecode(res.body)['redirect_url'];
      }

      throw jsonDecode(res.body)['message'];
    } catch (e) {
      rethrow;
    }
  }

// pake future void karena returnnya ga mengembalikan apapun (cuma massage success) | (liat postman)
// jadi kasih aja message error
  Future<void> transfer(TransferFormModel data) async {
    try {
      final token = await AuthService().getToken();

      final res = await http.post(
        Uri.parse('$baseUrl/transfers'),
        headers: {
          'Authorization': token,
        },
        body: data.toJson(),
      );

      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> dataPlan(DataPlanFormModel data) async {
    try {
      final token = await AuthService().getToken();

      final res = await http.post(
        Uri.parse('$baseUrl/data_plans'),
        headers: {
          'Authorization': token,
        },
        body: data.toJson(),
      );

      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  // Future<List<TransactionModel>> getTransaction() async {
  //   try {
  //     final token = await AuthService().getToken();

  //     final res = await http.get(
  //       Uri.parse('$baseUrl/transactions'),
  //       headers: {
  //         'Authorization': token,
  //       },
  //     );

  //     // print(res.body);

  //     if (res.statusCode == 200) {
  //       return List<TransactionModel>.from(jsonDecode(res.body)['data']
  //               .map((transaction) => TransactionModel.fromJson(transaction)))
  //           .toList();
  //     }

  //     throw jsonDecode(res.body)['message'];
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
