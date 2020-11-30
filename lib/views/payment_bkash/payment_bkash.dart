import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:prosiddho/controller/payment_controller.dart';
import 'package:prosiddho/functions/firestore_crud/firestore_create_function.dart';
import 'package:prosiddho/functions/firestore_crud/firestore_update_function.dart';
import 'package:prosiddho/model/payment_details.dart';
import 'package:prosiddho/enum/payment_getway.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentBkash extends StatelessWidget {
  final PaymentController _paymentController = Get.find<PaymentController>();

  double amount;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          FormBuilderTextField(
            attribute: "coupon",
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Enter amount",
            ),
            onChanged: (value) {
              amount = double.parse(value.toString());
            },
          ),
          RaisedButton(
            onPressed: () async {
              print(this.amount.toString());

              PaymentDetails paymentDetails = PaymentDetails(
                accountHolderName: "Khalid",
                accountId: "01726546211",
                amount: this.amount,
                getway: PaymentGetway.bkash.value,
                time: Timestamp.now(),
              );

              if (_paymentController.paymentDetails == null ||
                  _paymentController.paymentDetails.length == 0) {
                await FirestoreCreateFunction.addPayment(paymentDetails);
              } else {
                await FirestoreUpdateFunction.payment(paymentDetails);
              }

              Get.back();
            },
            child: Text("pay now"),
          ),
        ],
      ),
    );
  }
}
