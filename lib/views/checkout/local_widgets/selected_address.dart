import 'package:flutter/material.dart';
import 'package:prosiddho/style/color_palette.dart';
import 'package:prosiddho/style/style_export.dart';
import 'package:prosiddho/controller/user_controller.dart';
import 'package:get/get.dart';
import 'package:prosiddho/model/user_model/address_model.dart';
import 'package:prosiddho/views/shipping_address/shipping_address.dart';

class CheckoutSelectedAddress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _addressItem(Get.find<UserController>().getActiveAddress()),
    );
  }

  Widget _addressItem(Address address) => Container(
        width: double.infinity,
        margin: Style.marginVertically / 3,
        padding: Style.marginBase / 2,
        decoration: BoxDecoration(
          color: ColorPalette.bg.withOpacity(.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Shipping Address",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ColorPalette.text,
                  ),
                ),

                //change
                GestureDetector(
                  onTap: () {
                    Get.to(ShippingAddressScreen());
                  },
                  child: Text("change"),
                ),
              ],
            ),

            SizedBox(height: 20),
            //address lane
            Text(
              address.addressLane.capitalize,
              style: TextStyle(
                fontSize: 16,
                color: ColorPalette.text,
              ),
            ),

            //city with postal code
            Text(
              "${address.city.capitalize}, ${address.postalCode}",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: Colors.grey,
              ),
            ),

            SizedBox(height: 5),

            //houser no road no
            // show if data exists
            Row(
              children: [
                if (address.houseNo.length != 0)
                  Text(
                    "House:  ${address.houseNo}",
                    style: TextStyle(
                      fontSize: 14,
                      color: ColorPalette.text,
                    ),
                  ),
                if (address.roadNo.length != 0)
                  Text(
                    "  Road: ${address.roadNo}",
                    style: TextStyle(
                      fontSize: 14,
                      color: ColorPalette.text,
                    ),
                  ),
              ],
            ),

            SizedBox(height: 5),

            //others
            //show if dta exists
            if (address.others.length != 0)
              Text(
                address.others,
                style: TextStyle(
                  fontSize: 15,
                  color: ColorPalette.text,
                ),
              ),
          ],
        ),
      );
}
