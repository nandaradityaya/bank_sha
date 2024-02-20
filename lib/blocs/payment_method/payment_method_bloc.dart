import 'package:bank_sha/models/payment_method_model.dart';
import 'package:bank_sha/services/payment_method_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'payment_method_event.dart';
part 'payment_method_state.dart';

class PaymentMethodBloc extends Bloc<PaymentMethodEvent, PaymentMethodState> {
  PaymentMethodBloc() : super(PaymentMethodInitial()) {
    on<PaymentMethodEvent>((event, emit) async {
      // jika eventnya adalah PaymentMethodGet
      if (event is PaymentMethodGet) {
        // maka emit dulu loadingnya buat dapetin payment metdhodnya
        try {
          emit(PaymentMethodLoading());
          final paymentMethods =
              await PaymentMethodService().getPaymentMethod();

          // klo udah masukin paymentMethods ke PaymentMethodSuccess
          emit(PaymentMethodSuccess(paymentMethods));
        } catch (e) {
          emit(PaymentMethodFailed(e.toString()));
        }
      }
    });
  }
}
