import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prosiddho/constant/database_helper.dart';
import 'package:prosiddho/constant/utils.dart';
import 'package:prosiddho/data/data.dart';
import 'package:prosiddho/model/coupon_model.dart';
import 'package:prosiddho/style/color_palette.dart';
import 'package:prosiddho/views/profile/profile_screen.dart';
import 'package:prosiddho/views/order_placed.dart';
import 'package:prosiddho/views/payment_bkash/payment_bkash.dart';
import 'package:prosiddho/controller/user_controller.dart';
import 'package:prosiddho/controller/payment_controller.dart';
import 'package:prosiddho/controller/add_to_cart_controller.dart';
import 'package:prosiddho/functions/firestore_crud/firestore_create_function.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

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
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              child: Text("Apply Coupon"),
              color: ColorPalette.tertiary,
              textColor: Colors.white,
              onPressed: () async {
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
                Image.asset(Data.paymentOption[i].imagePath,
                    scale: i == 0
                        ? 10
                        : i == j - 1
                            ? 20
                            : 4),
                SizedBox(width: 20),
                Text(Data.paymentOption[i].name),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //heading
            Text("selected Address"),

            //active adddress details
            Obx(() => Text(_userController.getActiveAddress().addressLane)),

            //change address
            InkWell(
              onTap: () {
                Get.to(ProfileScreen());
              },
              child: Text("change Address"),
            ),

            //coupon
            coupon(),

            //payment heading
            Text("select payment option"),

            //payment options

            Obx(
              () => _paymentController.selectedPaymentMethod >= 0
                  ? FormBuilderRadioGroup(
                      orientation: GroupedRadioOrientation.vertical,
                      attribute: "addressList",
                      options: options,
                      initialValue: _paymentController.selectedPaymentMethod,
                      activeColor: Colors.green,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        _paymentController.selectedPaymentMethod = value;
                      },
                    )
                  : Container(),
            ),
          ],
        ),
      ),

      //bottom navigation bar
      bottomNavigationBar: BottomAppBar(
        color: Colors.amber,
        shape: CircularNotchedRectangle(),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Row(
            children: <Widget>[
              Obx(
                () => Text(
                  priceAfterApplyCouponAndPayment(
                        Get.find<PaymentController>().couponDiscount,
                        Get.find<PaymentController>().paymentAmount,
                      ).toString() ??
                      "",
                ),
              ),
              Spacer(),
              RaisedButton(
                onPressed: () async {
                  switch (_paymentController.selectedPaymentMethod) {
                    case 0:
                    case -1:
                      await FirestoreCreateFunction.placedOrder();
                      Get.to(OrderPlaced());
                      break;

                    case 1:
                      Get.to(PaymentBkash());
                      break;
                  }
                },
                child: Obx(
                  () => _paymentController.selectedPaymentMethod == 0 ||
                          _paymentController.selectedPaymentMethod == -1
                      ? Text("Placed order")
                      : Text("Payment"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
