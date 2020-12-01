import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prosiddho/controller/add_to_cart_controller.dart';
import 'package:prosiddho/functions/firestore_crud/firestore_read_function.dart';
import 'package:prosiddho/model/order_model/order_model.dart';

import 'my_order_details.dart';

class MyOrderScreen extends StatelessWidget {
  Widget orderItem(OrderModel orderModel) => Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.all(8.0),
        color: Colors.grey,
        child: Column(
          children: [
            Text("Order Time: ${orderModel.orderTime.toDate()}"),
            Text("Order Status: ${orderModel.status}"),
            Text("Status change time: ${orderModel.statusChangeTime.toDate()}"),
            Text("price: ${orderModel.totalPrice}"),
            Text("Total item: ${orderModel.productDetails.length}"),
            RaisedButton(
              child: Text("Re Order"),
              onPressed: () {
                Get.find<AddToCartController>()
                    .addToCartFromReOrder(orderModel.productDetails);
              },
            ),
            RaisedButton(
              child: Text("Show Details"),
              onPressed: () {
                Get.to(MyOrderDetailsScreen(orderModel: orderModel));
              },
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    FirestoreReadFunction.fetchOrders().then((value) {
      print(value.length.toString());
    });

    return Scaffold(
      appBar: AppBar(),
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
