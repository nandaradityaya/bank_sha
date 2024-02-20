import 'dart:convert';

import 'package:bank_sha/models/payment_method_model.dart';
import 'package:bank_sha/services/auth_service.dart';
import 'package:bank_sha/shared/shared_values.dart';
import 'package:http/http.dart' as http;

class PaymentMethodService {
  // bikin future yg returnnya PaymentMethodModel
  Future<List<PaymentMethodModel>> getPaymentMethod() async {
    try {
      // ambil tokennya dulu
      final token = await AuthService().getToken();

      final res = await http.get(
        Uri.parse('$baseUrl/payment_methods'),
        headers: {
          'Authorization': token,
        },
      );

      if (res.statusCode == 200) {
        // ambil dari jsonDecode res.body di map dan return PaymentMethodModel.fomJson (jsonnya ambil dari parameter paymentMethod). lalu ganti semuanya jadi toList
        return List<PaymentMethodModel>.from(jsonDecode(res.body).map(
                (paymentMethod) => PaymentMethodModel.fromJson(paymentMethod)))
            .toList();
      } else {
        throw jsonDecode(res.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }
}
