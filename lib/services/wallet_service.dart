import 'dart:convert';

import 'package:bank_sha/services/auth_service.dart';
import 'package:bank_sha/shared/shared_values.dart';
import 'package:http/http.dart' as http;

class WalletService {
  // disini gausah pake model karna cuma butuh dua parameter, klo banyak baru deh bikin model sendiri
  // parameternya masukin oldPin dan newPin (sesuai dengan API yaitu ada 2)
  Future<void> updatePin(String oldPin, String newPin) async {
    try {
      // ambil tokennya dulu
      final String token = await AuthService().getToken();

      final res = await http.put(
        Uri.parse('$baseUrl/wallets'),
        // bodynya ambil dari API, namanya sesuaiin dengan API, klo isi valuenya samain dengan parameter diatas
        body: {
          'previous_pin': oldPin,
          'new_pin': newPin,
        },
        headers: {
          'Authorization': token,
        },
      );

      print(res.body);

      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }
}
