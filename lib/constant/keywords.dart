// firestoer db field
//[Usermodel]
//[productModel]

class KeyWords {
  //---------UserModel-------------
  static const String userModel_Name = 'name';
  static const String userModel_Phone = 'phone';
  static const String userModel_BirthDate = 'birth_date';
  static const String userModel_Gamil = 'gamil';
  static const String userModel_CreateDate = 'crate_date';
  static const String userModel_AccountStatus = 'account_status';
  static const String userModel_Address = 'address';
  static const String userModel_Point = 'point';
  static const String userModel_FreeDelivery = 'free_delivery';
  static const String userModel_LastLogin = 'last_login';
  static const String userModel_IsLogin = 'is_login';
  static const String userModel_offerCollect = 'offer_collect';

  //gmail
  static const String gmail_Uid = 'uid';
  static const String gmail_Email = 'email';
  static const String gamil_DisplayName = 'display_name';
  static const String gmail_PhotoURL = 'photo_url';
  static const String gmail_PhoneNumber = 'phone_number';

  //free delivery
  static const String delivery_DeliveryLeft = 'delivery_left';
  static const String delivery_LastDate = 'last_date';

  //address
  static const String address_AddressLane = 'address_lane';
  static const String address_City = 'city';
  static const String address_PostalCode = 'postal_code';
  static const String address_HouseNo = 'house_no';
  static const String address_RoadNo = 'road_no';
  static const String address_Others = 'others';
  static const String address_Active = 'active';

  //account status
  static const String accountStatus_Status = 'status';
  static const String accountStatus_Reason = 'reason';

  //offer
  static const String offerCollect_appUpdate = 'app_update';
  static const String offerCollect_dailyLogin = 'daily_login';

  //---------UserModel-------------

  //---------ProductModel-------------
  static const String productModel_id = 'id';
  static const String productModel_available = 'available';
  static const String productModel_stock = 'stock';
  static const String productModel_birthPlace = 'birth_place';
  static const String productModel_createDate = 'create_date';
  static const String productModel_fullDescription = 'full_description';
  static const String productModel_imageLink = 'image_link';
  static const String productModel_lastUpdateDate = 'last_update_date';
  static const String productModel_minimumOrder = 'minimum_order';
  static const String productModel_minimumOrderOffer = 'minimum_order_offer';
  static const String productModel_name = 'name';
  static const String productModel_offer = 'offer';
  static const String productModel_buyGet = 'buy_get';
  static const String productModel_price = 'price';
  static const String productModel_priceOffer = 'price_offer';
  static const String productModel_rating = 'rating';
  static const String productModel_shortDescription = 'short_description';
  static const String productModel_subtype = 'subtype';
  static const String productModel_totalComments = 'total_comments';
  static const String productModel_totalSell = 'total_sell';
  static const String productModel_type = 'type';
  static const String productModel_unit = 'unit';
  static const String productModel_videoLink = 'video_link';

  //birth place
  static const String birthPlace_division = 'division';
  static const String birthPlace_district = 'district';

  //total sell
  static const String totalSell_TotalOrder = 'total_order';
  static const String totalSell_TotalUnitSell = 'total_unit_sell';

  //buy get
  static const String buyGet_quantity = 'quantity';
  static const String buyGet_extra = 'extra';

  //rating
  static const String rating_average = 'average';
  static const String rating_userCount = 'userCount';

  //price
  static const String price_price = 'price';
  static const String price_quantity = 'quantity';
  //---------ProductModel-------------

  //---------CartModel-------------
  static const String cartModel_productId = 'product_id';
  static const String cartModel_productName = 'product_name';
  static const String cartModel_productUnit = 'product_unit';
  static const String cartModel_productImageUrl = 'product_image_url';
  static const String cartModel_userId = 'user_id';
  static const String cartModel_addedTime = 'added_time';
  static const String cartModel_quantity = 'quantity';
  static const String cartModel_totalPrice = 'total_price';
  //---------CartModel-------------

  //---------OrderModel-------------
  static const String orderModel_address = 'address';
  static const String orderModel_cancelReason = 'cancel_reason';
  static const String orderModel_userId = 'user_id';
  static const String orderModel_userName = 'user_name';
  static const String orderModel_orderTime = 'order_time';
  static const String orderModel_paymentDetails = 'payment_details';
  static const String orderModel_phone = 'phone';
  static const String orderModel_productDetails = 'product_etails';
  static const String orderModel_status = 'status';
  static const String orderModel_statusChangeTime = 'status_change_time';
  static const String orderModel_payment = 'payment';
  static const String orderModel_discount = 'discount';
  static const String orderModel_totalPrice = 'total_price';
  static const String orderModel_totalPayable = 'total_payable';
  static const String orderModel_deliveryFee = 'delivery_fee';

  //payment details
  static const String paymentDetails_getway = 'getway';
  static const String paymentDetails_amount = 'amount';
  static const String paymentDetails_time = 'time';
  static const String paymentDetails_accountId = 'account_id';
  static const String paymentDetails_accountHolderName = 'account_holder_name';
  //---------OrderModel-------------

  //---------CouponModel-------------
  static const String couponModel_availableUserId = 'available_user_id';
  static const String couponModel_code = 'code';
  static const String couponModel_createDate = 'create_date';
  static const String couponModel_delivery = 'delivery';
  static const String couponModel_discount = 'discount';
  static const String couponModel_expireDate = 'expire_date';
  static const String couponModel_isActive = 'is_active';
  static const String couponModel_isUsed = 'is_used';
  static const String couponModel_minAmountOrder = 'min_amount_order';
  static const String couponModel_name = 'name';
  static const String couponModel_perUserUsed = 'per_user_used';
  static const String couponModel_totalUseable = 'total_useable';
  static const String couponModel_used = 'used';
  static const String couponModel_usedDate = 'used_date';
  //---------CouponModel-------------

  //---------CouponUsedHistoryModel-------------
  static const String couponUsedHistoryModel_code = 'code';
  static const String couponUsedHistoryModel_userId = 'user_id';
  static const String couponUsedHistoryModel_usedDate = 'used_date';
  //---------CouponUsedHistoryModel-------------

  //---------admin settings-------------
  static const String settingsModel_serverMaintenance = 'server_maintenance';
  static const String settingsModel_appVersion = 'app_version';
  static const String settingsModel_localDeliveryFee = 'local_delivery_fee';
  static const String settingsModel_globalDeliveryFee = 'global_delivery_fee';
  static const String settingsModel_offer = 'offer';

  static const String loginAfterLongTime = 'login_after_long_time';
  static const String loginAfterLongTime_dayInactive = 'day_inactive';
  static const String loginAfterLongTime_freeDelivery = 'free_delivery';
  static const String loginAfterLongTime_point = 'point';

  static const String newUser = 'new_user';
  static const String newUser_free_delivery = 'free_delivery';
  static const String newUser_point = 'point';

  static const String orderOffer = 'order_offer';
  static const String orderOffer_amountGte = 'amount_gte';
  static const String orderOffer_discountPercent = 'discount_percent';

  static const String productOffer = 'product_offer';
  static const String productOffer_discountPercent = 'discount_percent';
  static const String productOffer_productId = 'product_id';

  static const String appUpdateOffer = 'app_update_offer';
  static const String appUpdateOffer_point = 'point';

  static const String dailyLoginOffer = 'daily_login_offer';
  static const String dailyLoginOffer_point = 'point';

  //---------admin settings-------------
}
