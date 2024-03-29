import 'dart:convert';

import 'package:bank_sha/models/user_edit_form_model.dart';
import 'package:bank_sha/models/user_model.dart';
import 'package:bank_sha/services/auth_service.dart';
import 'package:bank_sha/shared/shared_values.dart';
import 'package:http/http.dart' as http;

class UserService {
  Future<void> updateUser(UserEditFormModel data) async {
    try {
      // ambil tokennya dulu, karna kita butuh token untuk mengelola profile
      final token = await AuthService().getToken();

      final res = await http.put(
        Uri.parse('$baseUrl/users'),
        body: data.toJson(), // body dapet dari data json
        // headersnya dapet dari authorization yg berisi token
        headers: {
          'Authorization': token,
        },
      );

      // selain 200 throw error
      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<UserModel>> getRecentUser() async {
    try {
      // ambil tokennya karna butuh token
      final token = await AuthService().getToken();
      final res = await http.get(
        Uri.parse('$baseUrl/transfer_histories'),
        // isi headersnya dengan authorization token yg ada
        headers: {
          'Authorization': token,
        },
      );

      if (res.statusCode == 200) {
        // list of UserModel from jsonDecode res.body, ambil data yg ada di json lalu map ke dalam user lalu return UserModel.fromJson(ganti jadi user)
        return List<UserModel>.from(
          jsonDecode(res.body)['data'].map(
            (user) => UserModel.fromJson(user),
          ),
        );
      }

      throw jsonDecode(res.body)['message'];
    } catch (e) {
      rethrow;
    }
  }

  Future<List<UserModel>> getUsersByUsername(String username) async {
    try {
      final token = await AuthService().getToken();
      final res = await http.get(
        Uri.parse('$baseUrl/users/$username'),
        headers: {
          'Authorization': token,
        },
      );

      // print(res.body);

      if (res.statusCode == 200) {
        return List<UserModel>.from(
          jsonDecode(res.body).map(
            (user) => UserModel.fromJson(user),
          ),
        );
      }

      throw jsonDecode(res.body)['message'];
    } catch (e) {
      rethrow;
    }
  }
}
