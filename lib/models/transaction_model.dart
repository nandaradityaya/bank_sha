import 'package:bank_sha/models/payment_method_model.dart';
import 'package:bank_sha/models/transaction_type_model.dart';

class TransactionModel {
  final int? id;
  final int? amount;
  final DateTime? createdAt;
  final PaymentMethodModel? paymentMethodModel;
  final TransactionTypeModel? transactionTypeModel;

  TransactionModel({
    this.id,
    this.amount,
    this.createdAt,
    this.paymentMethodModel,
    this.transactionTypeModel,
  });

// factory untuk relasi model
  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        id: json['id'],
        amount: json['amount'],
        createdAt: DateTime.tryParse(json[
            'created_at']), // parsing dari dateTime | pake tryParse supaya klo returnnya null maka dia akan null
        paymentMethodModel: json['payment_method'] == null
            ? null
            : PaymentMethodModel.fromJson(json['payment_method']),
        transactionTypeModel: json['transaction_type'] == null
            ? null
            : TransactionTypeModel.fomJson(json['transaction_type']),
      );
}
