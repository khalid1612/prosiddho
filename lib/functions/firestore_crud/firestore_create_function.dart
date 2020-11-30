import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:prosiddho/constant/database_helper.dart';
import 'package:prosiddho/controller/admin_controller.dart';
import 'package:prosiddho/controller/user_controller.dart';
import 'package:prosiddho/controller/add_to_cart_controller.dart';
import 'package:prosiddho/controller/payment_controller.dart';
import 'package:prosiddho/enum/status.dart';
import 'package:prosiddho/model/admin_settings/admin_settings.dart';
import 'package:prosiddho/model/cart_model/cart_model.dart';
import 'package:prosiddho/model/cart_model/cart_model_product.dart';
import 'package:prosiddho/model/cart_model/cart_model_product_details.dart';
import 'package:prosiddho/model/user_model/account_status_model.dart';
import 'package:prosiddho/model/user_model/free_delivery_model.dart';
import 'package:prosiddho/model/user_model/gmail_model.dart';
import 'package:prosiddho/model/user_model/user_model.dart';
import 'package:prosiddho/model/order_model/order_model.dart';
import 'package:prosiddho/model/user_model/offer_collect.dart';
import 'package:prosiddho/model/user_model/address_model.dart';
import 'package:prosiddho/model/payment_details.dart';
import 'package:prosiddho/model/order_model/order_model_product.dart';
import 'package:prosiddho/enum/order_status.dart';
import 'package:prosiddho/functions/firestore_crud/firestore_delete_function.dart';

class FirestoreCreateFunction {
  static Future<UserModel> newUserWithGoogle(User user) async {
    //user initial data
    final AdminSettings adminSettings =
        Get.find<AdminController>().adminSettings;

    //setup a new user instance
    UserModel userModel = UserModel(
      name: user.displayName,
      phone: user.phoneNumber ?? null,
      birthDate: null,
      gamil: Gmail(
        uid: user.uid,
        email: user.email,
        displayName: user.displayName,
        photoURL: user.photoURL,
        phoneNumber: user.phoneNumber ?? null,
      ),
      createDate: Timestamp.now(),
      accountStatus: AccountStatus(
        status: Status.Active.value,
        reason: null,
      ),
      address: null,
      point: adminSettings.offer.newUserOffer.point,
      freeDelivery: [
        FreeDelivery(
          deliveryLeft: adminSettings.offer.newUserOffer.freeDelivery,
          lastDate: null, //*null means lifetime
        )
      ],
      lastLogin: Timestamp.now(),
      isLogin: true,
      offerCollect: OfferCollect(
        appUpdate: false,
        dailyLogin: false,
      ),
    );

    //store data in database
    await DatabaseHelper.collectionUsers
        .doc(user.uid)
        .set(
          UserModel.toMap(userModel),
        )
        .then((value) {
      String msg = '';
      if (adminSettings.offer.newUserOffer.point > 0) {
        msg = "You got ${adminSettings.offer.newUserOffer.point} points";
      }

      if (adminSettings.offer.newUserOffer.freeDelivery > 0) {
        msg = msg.length > 0
            ? " and ${adminSettings.offer.newUserOffer.freeDelivery} free delivery"
            : " You got ${adminSettings.offer.newUserOffer.freeDelivery} free delivery";
      }

      if (msg.length > 0) {
        Get.defaultDialog(onConfirm: () => print("Ok"), middleText: msg);
      }
    }).catchError(
      (error) => print("Failed to add user: $error"),
    );

    return userModel;
  }

  static Future<void> addTocart(CartModelProduct cartModelProduct) async {
    final CartModel cartModel = CartModel(
      cartModelProduct: [cartModelProduct],
      lastUpdate: Timestamp.now(),
    );

    //add in database
    await DatabaseHelper.collectionCart
        .doc(Get.find<UserController>().userModel.id)
        .set(CartModel.toMap(cartModel))
        .then((value) => null)
        .catchError(
          (error) => print("Failed to add cart item: $error"),
        );
  }

  static Future<void> addPayment(PaymentDetails paymentDetails) async {
    //add in database
    await DatabaseHelper.collectionPayment
        .doc(Get.find<UserController>().userModel.id)
        .set({
          "details": [PaymentDetails.toMap(paymentDetails)],
        })
        .then((value) => null)
        .catchError(
          (error) => print("Failed to add payment item: $error"),
        );
  }

  static Future<void> placedOrder() async {
    final UserController _userController = Get.find<UserController>();
    final PaymentController _paymentController = Get.find<PaymentController>();
    final AddToCartController _cartController = Get.find<AddToCartController>();
    Address activeAddress;

    List<OrderModelProduct> orderModelProduct = List();

    for (Address address in _userController.userModel.address) {
      if (address.active) {
        activeAddress = address;
        break;
      }
    }

    for (CartModelProductDetails item in _cartController.cartProducts) {
      orderModelProduct.add(
        OrderModelProduct(
          productId: item.productModel.id,
          productName: item.productModel.name,
          quantity: item.cartModelProduct.quantity,
          regularPrice: item.productModel.price,
          offerPrice: item.productModel.priceOffer,
          totalPrice: item.totalPrice,
          extra: item.extra,
        ),
      );
    }

    final OrderModel orderModel = OrderModel(
      address: activeAddress,
      cancelReason: null,
      userId: _userController.userModel.id,
      userName: _userController.userModel.name,
      userImage: _userController.userModel.gamil.photoURL,
      orderTime: Timestamp.now(),
      paymentDetails: _paymentController.paymentDetails,
      phone: _userController.userModel.phone,
      productDetails: orderModelProduct,
      status: OrderStatus.pending.value,
      statusChangeTime: Timestamp.now(),
      totalPrice: Get.find<AddToCartController>().totalPriceWithoutCoupon,
      due: _paymentController.due,
      profit: null,
      deliveryFee: Get.find<AdminController>()
          .adminSettings
          .globalDeliveryFee
          .toDouble(),
      couponCode: _paymentController.couponCode,
    );

    //add in database
    await DatabaseHelper.collectionOrder
        .add(OrderModel.toMap(orderModel))
        .then((value) async {
      //delete user cart
      await FirestoreDeleteFunction.cart();

      //delete user payment
      await FirestoreDeleteFunction.payment();

      //reset payment controller
      _paymentController.reset();

      //reset cart controller
      _cartController.reset();
    }).catchError(
      (error) => print("Failed to placed order: $error"),
    );
  }
}
