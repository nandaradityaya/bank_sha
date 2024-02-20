part of 'payment_method_bloc.dart';

abstract class PaymentMethodEvent extends Equatable {
  const PaymentMethodEvent();

  @override
  List<Object> get props => [];
}

// get semua payment methodnya
class PaymentMethodGet extends PaymentMethodEvent {}
