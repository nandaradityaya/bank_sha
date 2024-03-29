// import 'package:bank_sha/models/signin_form_model.dart';
// import 'package:bank_sha/models/sign_up_form_model.dart';
// import 'package:bank_sha/models/user_edit_from_model.dart';
// import 'package:bank_sha/models/user_model.dart';
import 'package:bank_sha/models/sign_in_form_model.dart';
import 'package:bank_sha/models/sign_up_form_model.dart';
import 'package:bank_sha/models/user_edit_form_model.dart';
import 'package:bank_sha/models/user_model.dart';
import 'package:bank_sha/services/auth_service.dart';
import 'package:bank_sha/services/user_service.dart';
import 'package:bank_sha/services/wallet_service.dart';
// import 'package:bank_sha/services/user_service.dart';
// import 'package:bank_sha/services/wallet_service.dart';
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is AuthCheckEmail) {
        try {
          emit(AuthLoading());
          final res = await AuthService().checkEmail(event.email);

          if (res == false) {
            emit(AuthCheckEmailSuccess());
          } else {
            emit(const AuthFailed('Email Sudah Terpakai'));
          }
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }

      if (event is AuthRegister) {
        try {
          emit(AuthLoading());

          final user = await AuthService()
              .register(event.data); // dapet datanya dari event.data

          emit(AuthSuccess(user));
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }

      if (event is AuthLogin) {
        try {
          emit(AuthLoading());

          final user = await AuthService().login(event.data);

          emit(AuthSuccess(user));
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }

      if (event is AuthGetCurrentUser) {
        try {
          emit(AuthLoading());

          final SignInFormModel data =
              await AuthService().getCredentialFromLocal();
          // print('Event : ${data.email}');
          // print('Event : ${data.password}');

          final UserModel user =
              await AuthService().login(data); // loginkan ulang

          emit(AuthSuccess(user)); // success
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }

      if (event is AuthUpdateUser) {
        try {
          // pastiin si statenya itu AuthSuccess baru kita bisa update usernya
          if (state is AuthSuccess) {
            final updatadUser = (state as AuthSuccess).user.copyWith(
                  // ubah semua yg ada di sini yg di masukin user, data ini berdasarkan dari user edit form model
                  username: event.data.username,
                  name: event.data.name,
                  email: event.data.email,
                  password: event.data.password,
                );

            emit(AuthLoading());

            // jalanin updateUser yg di dapet dari event.data (data itu berarti data yg ada di model)
            await UserService().updateUser(event.data);

            emit(AuthSuccess(updatadUser));
          }
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }

      if (event is AuthUpdatePin) {
        try {
          if (state is AuthSuccess) {
            final updatadUser = (state as AuthSuccess).user.copyWith(
                  // ambil newPinnya, jangan oldPin!!! karna yg mau kita update newPin
                  pin: event.newPin,
                );
            emit(AuthLoading());

            await WalletService().updatePin(event.oldPin, event.newPin);

            emit(AuthSuccess(updatadUser));
          }
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }

      if (event is AuthLogOut) {
        try {
          emit(AuthLoading());
          await AuthService().logOut();

          // ketika sudah logout, balikin lagi ke kondisi AuthInitial
          emit(AuthInitial());
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }

      // update balance
      if (event is AuthUpdateBalance) {
        if (state is AuthSuccess) {
          // ambil currentUser dulu
          final currentUser = (state as AuthSuccess).user;

          final updatadUser = currentUser.copyWith(
            // balance sebelumnya tambahin dengan event.amount (yg di top up oleh user)
            balance: currentUser.balance! + event.amount,
          );
          emit(AuthSuccess(updatadUser));
        }
      }
    });
  }
}
