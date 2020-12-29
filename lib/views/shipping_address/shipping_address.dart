import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prosiddho/controller/user_controller.dart';
import 'package:prosiddho/style/color_palette.dart';
import 'package:prosiddho/style/style_export.dart';

import 'local_widget/address_item.dart';

class ShippingAddressScreen extends StatelessWidget {
  final UserController _userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFEFEF),
      appBar: AppBar(
        backgroundColor: ColorPalette.primary,
        title: Text("Shipping Address"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: Style.marginBase,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              //* ListView.builder throw some error inside obx in init state
              //thats why use obx for ever address

              //address 1
              Obx(
                () {
                  return _userController.userModel.address.length >= 1
                      ? AddressItem(
                          index: 0,
                          address: _userController.userModel.address[0],
                        )
                      : AddressItem(index: 0, address: null);
                },
              ),

              //address 2
              Obx(
                () {
                  return _userController.userModel.address.length >= 2
                      ? AddressItem(
                          index: 1,
                          address: _userController.userModel.address[1],
                        )
                      : AddressItem(index: 1, address: null);
                },
              ),

              //address 3
              Obx(
                () {
                  return _userController.userModel.address.length >= 3
                      ? AddressItem(
                          index: 2,
                          address: _userController.userModel.address[2],
                        )
                      : AddressItem(index: 2, address: null);
                },
              ),

              //address 4
              Obx(
                () {
                  return _userController.userModel.address.length >= 4
                      ? AddressItem(
                          index: 3,
                          address: _userController.userModel.address[3],
                        )
                      : AddressItem(index: 3, address: null);
                },
              ),

              //address 5
              Obx(
                () {
                  return _userController.userModel.address.length >= 5
                      ? AddressItem(
                          index: 4,
                          address: _userController.userModel.address[4],
                        )
                      : AddressItem(index: 4, address: null);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
