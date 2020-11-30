import 'package:get/state_manager.dart';
import 'package:prosiddho/model/payment_details.dart';
import 'package:prosiddho/functions/firestore_crud/firestore_read_function.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentController extends GetxController {
  RxInt _couponDiscount = 0.obs;
  var couponFreeDelivery = 0.obs;
  String couponCode;
  RxInt _selectedPaymentMethod = 0.obs;
  double due;

  List<PaymentDetails> paymentDetails = List<PaymentDetails>().obs;

  int get couponDiscount => _couponDiscount.value;
  int get selectedPaymentMethod => _selectedPaymentMethod.value;

  set couponDiscount(int value) => _couponDiscount.value = value;
  set selectedPaymentMethod(int value) => _selectedPaymentMethod.value = value;

  double get paymentAmount =>
      paymentDetails.fold(0, (total, item) => total + item.amount);

  @override
  void onInit() {
    FirestoreReadFunction.paymentStream().listen(((DocumentSnapshot document) {
      if (document.exists) {
        print("payment doc found");
        paymentDetails.clear();
        var result = document['details'];

        for (int i = 0, j = result.length; i < j; i++) {
          paymentDetails.add(
            PaymentDetails.fromFirestore(document['details'][i]),
          );
          print(paymentDetails[i].amount.toString());
        }
      } else {
        print("payment doc not found");
      }
    }));

    super.onInit();
  }

  void reset() {
    this.couponDiscount = 0;
    this.couponFreeDelivery.value = 0;
    this.couponCode = null;
    this.selectedPaymentMethod = 0;
    this.due = 0;
    this.paymentDetails.clear();
  }
}
