import 'package:flutter/material.dart';
import 'package:prosiddho/style/style_export.dart';
import 'package:prosiddho/style/color_palette.dart';
import 'package:prosiddho/views/shipping_address/shipping_address.dart';
import 'package:get/get.dart';

class ProfileUserInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Style.marginBase.copyWith(top: 0),
      child: Card(
        elevation: 3.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              //Address
              _infoItem(
                icon: Icons.location_on,
                title: "Shipping Address",
                onTap: () => Get.to(ShippingAddressScreen()),
              ),

              //payment
              _infoItem(
                icon: Icons.payment,
                title: "Payment Methods",
                onTap: null,
              ),

              //statistics
              _infoItem(
                icon: Icons.graphic_eq,
                title: "Statistics",
                onTap: null,
              ),

              //Rewards
              _infoItem(
                icon: Icons.local_offer,
                title: "Rewards",
                onTap: null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoItem({
    @required IconData icon,
    @required String title,
    @required Function onTap,
  }) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 3.0),
        child: Column(
          children: [
            InkWell(
              onTap: onTap,
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 15),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward,
                    size: 14,
                    color: ColorPalette.bg.withOpacity(.5),
                  ),
                ],
              ),
            ),
            Divider(
              height: 10,
              color: ColorPalette.bg.withOpacity(.5),
            ),
          ],
        ),
      );
}
