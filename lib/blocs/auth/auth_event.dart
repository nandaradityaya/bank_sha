part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthCheckEmail extends AuthEvent {
  final String email;
  const AuthCheckEmail(this.email);
  @override
  List<Object> get props => [email];
}

class AuthRegister extends AuthEvent {
  final SignUpFormModel data;
  const AuthRegister(
      this.data); // AuthRegister adalah constructor dari classnya

  @override
  List<Object> get props => [data];
}

class AuthLogin extends AuthEvent {
  final SignInFormModel data;
  const AuthLogin(this.data);
  @override
  List<Object> get props => [data];
}

class AuthGetCurrentUser extends AuthEvent {}

class AuthUpdateUser extends AuthEvent {
  final UserEditFormModel data;
  const AuthUpdateUser(this.data);
  @override
  List<Object> get props => [data];
}

class AuthUpdatePin extends AuthEvent {
  final String oldPin;
  final String newPin;
  const AuthUpdatePin(this.oldPin, this.newPin);
  @override
  List<Object> get props => [oldPin, newPin];
}

class AuthLogOut extends AuthEvent {}

// bikin agar balancenya terupdate otomatis tanpa restart apps
class AuthUpdateBalance extends AuthEvent {
  final int amount;
  const AuthUpdateBalance(this.amount);

  @override
  List<Object> get props => [amount];
}
