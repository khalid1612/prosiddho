import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prosiddho/model/product_model/product_model.dart';
import 'package:prosiddho/constant/utils.dart';

class UpdateProducts extends StatelessWidget {
  final CollectionReference products =
      FirebaseFirestore.instance.collection('productDetails');

  Future<void> deleteField(QueryDocumentSnapshot doc) async {
    return products
        .doc(doc.id)
        .update({'offer': FieldValue.delete()})
        .then((value) => print("field delete successfuly"))
        .catchError((error) => print("Failed to delete field: $error"));
  }

  Future<void> updateType(QueryDocumentSnapshot doc) async {
    Map<String, dynamic> data = {};

    // if (doc['minimum_order'] != null) {
    //   data["minimum_order"] = doc['minimum_order'].toInt();
    // }

    // if (doc['minimum_order_offer'] != null) {
    //   data["minimum_order_offer"] = doc['minimum_order_offer'].toInt();
    // }

    return products
        .doc(doc.id)
        .update(data)
        .then((value) => print("field update successfuly"))
        .catchError((error) => print("Failed to delete field: $error"));
  }

  Future<void> updatePrice(QueryDocumentSnapshot doc) async {
    Map<String, dynamic> data = {};
    ProductModel productModel =
        ProductModel.fromFirestore(queryDocumentSnapshot: doc);

    data["offer_percent"] = Util.random(max: 10);

    return products
        .doc(doc.id)
        .update(data)
        .then((value) => print("product Updated"))
        .catchError((error) => print("Failed to update product: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<QuerySnapshot>(
        future: products.get(),
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> querySnapshot) {
          if (querySnapshot.hasError) {
            return Text("Something went wrong");
          }

          if (querySnapshot.connectionState == ConnectionState.done) {
            print(querySnapshot.data.docs.length.toString());
            // updateDocument(querySnapshot.data.docs[0]);

            querySnapshot.data.docs.forEach((QueryDocumentSnapshot doc) async {
              // print(
              //     "${doc.id} : ${doc['buy_get.quantity']} ${doc['buy_get.quantity'].runtimeType}");
              // int value = doc['minimum_order'].toInt();
              // print(value.toString());
              //update
              if (doc.id == "0Yv3QdlA8SHQeUPePqDa") {
                // await updateType(doc);
              }
              // else if (doc.id == "0eEKkWC9ygcB1nJNTyWp") {
              // }
              else {
                // await updateType(doc);
              }

              //deltete
              // await deleteField(doc);

              //convert and check
              ProductModel productModel =
                  ProductModel.fromFirestore(queryDocumentSnapshot: doc);
              print(productModel.id);

              // var result =
              //     BirthPlace.toMap(doc[KeyWords.productModel_birthPlace]);

              // print(result);
            });
          }

          return Center(child: Text("loading"));
        },
      ),
    );
  }
}
