import 'dart:convert';
// import 'package:bank_sha/models/signup_up_form.dart';
// import 'package:bank_sha/models/user_model.dart';
import 'package:bank_sha/models/sign_in_form_model.dart';
import 'package:bank_sha/models/sign_up_form_model.dart';
import 'package:bank_sha/models/user_model.dart';
import 'package:bank_sha/shared/shared_values.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

// import '../models/signin_form_model.dart';

class AuthService {
  // check email tersedia atau tidak
  Future<bool> checkEmail(String email) async {
    try {
      final response = await http.post(
        Uri.parse(
          '$baseUrl/is-email-exist',
        ),
        body: {
          'email': email,
        },
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body)['is_email_exist'];
      } else {
        return jsonDecode(response.body)['errors'];
      }
    } catch (e) {
      rethrow;
    }
  }

  // parameternya (SignUpFormModel data) yg artinya itu kirim data dari SignUpFormModel
  Future<UserModel> register(SignUpFormModel data) async {
    try {
      // print('Services : $data');
      final res = await http.post(
        Uri.parse('$baseUrl/register'),
        body: data.toJson(), // kirim data yg ada di body dalam bentuk json
      );

      if (res.statusCode == 200) {
        UserModel user = UserModel.fromJson(jsonDecode(res.body));
        user = user.copyWith(
            password: data
                .password); // ambil passwordnya karna di res.body gada password

        await storeCredentialToLocal(user);

        return user;
      } else {
        throw jsonDecode(res.body)['message']; // kirimin message error dari API
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> login(SignInFormModel data) async {
    try {
      final res = await http.post(
        Uri.parse('$baseUrl/login'),
        body: data.toJson(),
      );

      print(res.body);

      if (res.statusCode == 200) {
        UserModel user = UserModel.fromJson(jsonDecode(res.body));
        user = user.copyWith(password: data.password);

        // print('Btn login data2: ${user.password}');

        // print('Btn login: ${user.}');

        // masukin credentialnya ke local storage (session)
        await storeCredentialToLocal(user);

        return user;
      } else {
        throw jsonDecode(res.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logOut() async {
    try {
      // ambil tokennya
      final token = await getToken();

      final res = await http.post(
        Uri.parse('$baseUrl/logout'),
        headers: {
          'Authorization': token, // Auth ambil tokennya
        },
      );

      if (res.statusCode == 200) {
        await clearLocalStorage();
      } else {
        throw jsonDecode(res.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

// untuk menyimpan session login
  Future<void> storeCredentialToLocal(UserModel user) async {
    try {
      const storage = FlutterSecureStorage();
      // print('cek :${user.token}');
      // print('cek :${user.email}');
      // print('cek :${user.password}');

      // write ke local storage
      await storage.write(key: 'token', value: user.token);
      await storage.write(key: 'email', value: user.email);
      await storage.write(key: 'password', value: user.password);
    } catch (e) {
      rethrow;
    }
  }

  // ambil credential dari local
  Future<SignInFormModel> getCredentialFromLocal() async {
    try {
      const storage = FlutterSecureStorage();
      Map<String, String> value =
          await storage.readAll(); // baca semua yg ada di storage

      if (value['email'] == null || value['password'] == null) {
        throw 'authenticated'; // tidak terauthenticated
      } else {
        final SignInFormModel data = SignInFormModel(
          email: value['email'], // dapet dari value email
          password: value['password'], // dapet dari value password
        );
        return data;
      }
    } catch (e) {
      rethrow;
    }
  }

  // untuk mengambil token untuk di gunakan di beberapa halaman yg membutuhkan
  Future<String> getToken() async {
    String token = '';
    const storage = FlutterSecureStorage();
    String? value = await storage.read(key: 'token'); // read token doang

    // klo valuenya tidak sama dengan null maka tokennya munculin bearer
    if (value != null) {
      token = 'Bearer $value';
    }

    return token;
  }

  // clear local storage akan digunakan sewaktu logout
  Future<void> clearLocalStorage() async {
    const storage = FlutterSecureStorage();
    await storage.deleteAll();
  }
}
