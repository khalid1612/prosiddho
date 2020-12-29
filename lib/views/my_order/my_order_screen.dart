import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prosiddho/controller/add_to_cart_controller.dart';
import 'package:prosiddho/functions/firestore_crud/firestore_read_function.dart';
import 'package:prosiddho/model/order_model/order_model.dart';
import 'package:prosiddho/style/color_palette.dart';
import 'package:prosiddho/style/style_export.dart';
import 'package:prosiddho/constant/constant_export.dart';

import '../my_order_details.dart';

class MyOrderScreen extends StatelessWidget {
  Widget orderItem(OrderModel orderModel) => Container(
        margin: Style.marginBase.copyWith(bottom: 0),
        padding: Style.marginBase / 2,
        decoration: BoxDecoration(
          color: ColorPalette.bg.withOpacity(.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _item(
              "Order Date: ",
              orderModel.orderTime.toDate().toIso8601String().split('T').first,
            ),
            _item(
              "Total Item: ",
              orderModel.productDetails.length.toString(),
            ),
            _item(
              "Order Status: ",
              orderModel.status.toString(),
            ),
            _item(
              "Price: ",
              orderModel.totalPrice.toString(),
            ),
            _item(
              "Status change time: ",
              orderModel.statusChangeTime
                  .toDate()
                  .toIso8601String()
                  .split('T')
                  .first,
            ),
            GestureDetector(
              onTap: () {
                // Get.to(
                //   MyOrderDetailsScreen(orderModel: orderModel),
                // );
              },
              child: Text(
                "Show Details",
                style: TextStyle(
                  color: ColorPalette.primaryPurple,
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Buttons.normalButton(
                  text: "Re Order",
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  onTap: () => Get.find<AddToCartController>()
                      .addToCartFromReOrder(orderModel.productDetails),
                ),
              ],
            ),
          ],
        ),
      );

  Widget _item(String head, tail) => Row(
        children: [
          Text(
            head,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          Text(
            tail,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    FirestoreReadFunction.fetchOrders().then((value) {
      print(value.length.toString());
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.primary,
        title: Text("Orders"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: FirestoreReadFunction.fetchOrders(),
        builder:
            (BuildContext context, AsyncSnapshot<List<OrderModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("loading");
          }

          return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return orderItem(snapshot.data[index]);
            },
          );
        },
      ),
    );
  }
}
