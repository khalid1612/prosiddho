import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prosiddho/constant/database_helper.dart';
import 'package:prosiddho/constant/constant_export.dart';
import 'package:prosiddho/data/data.dart';
import 'package:prosiddho/model/coupon_model.dart';
import 'package:prosiddho/style/style_export.dart';
import 'package:prosiddho/views/order_placed/order_placed_screen.dart';
import 'package:prosiddho/views/payment_bkash/payment_bkash.dart';
import 'package:prosiddho/controller/user_controller.dart';
import 'package:prosiddho/controller/payment_controller.dart';
import 'package:prosiddho/controller/add_to_cart_controller.dart';
import 'package:prosiddho/functions/firestore_crud/firestore_create_function.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'local_widgets/selected_address.dart';

class CheckoutScreen extends StatelessWidget {
  final UserController _userController = Get.find<UserController>();
  final AddToCartController _cartController = Get.find<AddToCartController>();
  final PaymentController _paymentController = Get.put(PaymentController());

  List<FormBuilderFieldOption> options = [];
  String code;
  CouponModel couponModel;

  Future<CouponModel> checkCode(String code) async {
    CouponModel couponModel;

    await DatabaseHelper.collectionCoupon
        .where('code', isEqualTo: code)
        .get()
        .then((value) {
      if (value.size > 0) {
        couponModel = CouponModel.fromFirestore(value.docs[0]);
        this.couponModel = couponModel;
        print(couponModel.id);
      }
    });

    return couponModel;
  }

  void checkCouponValidity(int used) {
    //day left or not
    if (Util.timeDifference(couponModel.expireDate).inDays < 0) {
      //check userable limit extended or not
      if (couponModel.totalUseable > couponModel.used) {
        //check per limit extended or not
        if (couponModel.perUserUsed > used) {
          //check min order
          if (_cartController.totalPriceWithoutCoupon >=
              couponModel.minAmountOrder) {
            print(couponModel.discount);
            _paymentController.couponDiscount = couponModel.discount;
            _paymentController.couponFreeDelivery.value = couponModel.delivery;
            _paymentController.couponCode = couponModel.code;

            //TODO something
            //apply coupon in order
            // applyCouponInOrder();
            // updateCoupon();
            // addCouponHistory();
          }
        }
      }
    } else {
      print("day Expired");
    }
  }

  Future<int> couponUsedHistory() async {
    int usedcount = 0;

    await DatabaseHelper.collectionCouponUsedHistory
        .where('code', isEqualTo: this.code)
        .where('user_id', isEqualTo: this._userController.userModel.id)
        .get()
        .then((value) {
      usedcount = value.size;
    });

    return usedcount;
  }

  Widget coupon() => Column(
        children: [
          FormBuilderTextField(
            attribute: "coupon",
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Enter coupon code",
            ),
            onChanged: (value) {
              code = value;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 50.0,
              vertical: 30,
            ),
            child: Buttons.normalButton(
              text: "Apply Coupon",
              onTap: () async {
                if (code != null && code.trim().length > 0) {
                  checkCode(code).then((CouponModel couponModel) {
                    if (couponModel == null) {
                      print("no data found");
                    } else {
                      //coupon active or not
                      if (couponModel.isActive) {
                        //if coupon only for one user
                        //chek user id
                        if (couponModel.availableUserId ==
                            _userController.userModel.id) {
                          checkCouponValidity(couponModel.used);
                        }
                        //if coupon for all user
                        else {
                          print("all user ");
                          couponUsedHistory().then((int used) {
                            checkCouponValidity(used);
                          });
                        }
                      } else {
                        print("Coupon expaired");
                      }
                    }
                  });
                }
              },
            ),
          ),
        ],
      );

  double priceAfterApplyCouponAndPayment(int couponDiscount, double payment) {
    double discount =
        _cartController.totalPriceWithoutCoupon * (couponDiscount / 100.0);

    double amountLeft =
        _cartController.totalPriceWithoutCoupon - (discount + payment);

    if (amountLeft == 0 || amountLeft < .9) {
      Future.delayed(const Duration(milliseconds: 100), () {
        _paymentController.selectedPaymentMethod = -1;
      });
    }

    _paymentController.due = amountLeft;

    return amountLeft;
  }

  @override
  Widget build(BuildContext context) {
    options.clear();
    for (int i = 0, j = Data.paymentOption.length; i < j; i++) {
      options.add(
        FormBuilderFieldOption(
          value: i,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  child: ClipOval(
                    child: Image.asset(
                      Data.paymentOption[i].imagePath,
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Text(Data.paymentOption[i].name),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Color(0xFFEFEFEF),
      appBar: AppBar(
        backgroundColor: ColorPalette.primary,
        title: Text("Checkout"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: Style.marginBase,
          child: Column(
            children: [
              //active adddress details
              CheckoutSelectedAddress(),

              SizedBox(height: 30),

              //coupon
              coupon(),

              //payment heading
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: ColorPalette.bg.withOpacity(.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Select Payment Option",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: ColorPalette.text,
                        ),
                      ),
                    ),
                    Obx(
                      () => _paymentController.selectedPaymentMethod >= 0
                          ? FormBuilderRadioGroup(
                              orientation: GroupedRadioOrientation.vertical,
                              attribute: "addressList",
                              options: options,
                              initialValue:
                                  _paymentController.selectedPaymentMethod,
                              activeColor: Colors.green,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                              onChanged: (value) {
                                _paymentController.selectedPaymentMethod =
                                    value;
                              },
                            )
                          : Container(),
                    ),
                  ],
                ),
              ),

              //payment options
            ],
          ),
        ),
      ),

      //bottom navigation bar
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Row(
                children: <Widget>[
                  Obx(
                    () => Text(
                      Values.tkSign +
                              priceAfterApplyCouponAndPayment(
                                Get.find<PaymentController>().couponDiscount,
                                Get.find<PaymentController>().paymentAmount,
                              ).toString() ??
                          "",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Spacer(),
                  Obx(
                    () => Buttons.normalButton(
                      text: _paymentController.selectedPaymentMethod == 0 ||
                              _paymentController.selectedPaymentMethod == -1
                          ? "Placed order"
                          : "Payment",
                      onTap: () async {
                        switch (_paymentController.selectedPaymentMethod) {
                          case 0:
                          case -1:
                            await FirestoreCreateFunction.placedOrder();
                            Get.to(OrderPlacedScreen());
                            break;

                          case 1:
                            Get.to(PaymentBkash());
                            break;
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
