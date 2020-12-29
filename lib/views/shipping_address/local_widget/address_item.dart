import 'package:flutter/material.dart';
import 'package:prosiddho/views/add_new_address/add_new_address.dart';
import 'package:prosiddho/functions/firestore_crud/firestore_update_function.dart';
import 'package:prosiddho/model/user_model/address_model.dart';
import 'package:prosiddho/style/color_palette.dart';
import 'package:prosiddho/style/style_export.dart';
import 'package:get/get.dart';
import 'package:prosiddho/controller/user_controller.dart';

class AddressItem extends StatelessWidget {
  final int index;
  final Address address;

  const AddressItem({
    Key key,
    @required this.index,
    @required this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserController _userController = Get.find<UserController>();
    bool isActive = false;
    Color fontColor = ColorPalette.text;

    if (address != null && address.active) {
      isActive = true;
      fontColor = Colors.white;
    }

    return Container(
      margin: Style.marginVertically / 2,
      decoration: BoxDecoration(
        color:
            isActive ? ColorPalette.primary : ColorPalette.bg.withOpacity(.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: address == null
          ?
          //add new address
          GestureDetector(
              onTap: () {
                print("insert new address successfully");
                Get.to(AddNewAddress());
              },
              child: Container(
                color: Colors.transparent,
                padding: EdgeInsets.symmetric(
                  vertical: 20,
                ),
                child: Center(
                  child: Text("Add new address"),
                ),
              ),
            )
          :
          //show old saved address
          Padding(
              padding: Style.marginBase / 2,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        List<Address> allAddress =
                            _userController.userModel.address;

                        //remove deleted index
                        for (int i = 0; i < allAddress.length; i++) {
                          allAddress[i].active = i == index ? true : false;
                        }

                        await FirestoreUpdateFunction.address(allAddress);
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            //address lane
                            Text(
                              address.addressLane.capitalize,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: fontColor,
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
                                      color: fontColor,
                                    ),
                                  ),
                                if (address.roadNo.length != 0)
                                  Text(
                                    "  Road: ${address.roadNo}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: fontColor,
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
                                  color: fontColor,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap: () async {
                          List<Address> allAddress =
                              _userController.userModel.address;

                          //remove deleted index
                          allAddress.removeAt(index);

                          await FirestoreUpdateFunction.address(allAddress);
                        },
                        child: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
