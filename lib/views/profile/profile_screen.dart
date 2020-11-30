import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prosiddho/controller/user_controller.dart';
import 'package:prosiddho/model/user_model/address_model.dart';
import 'package:prosiddho/style/color_palette.dart';
import 'package:prosiddho/style/style.dart';
import 'package:prosiddho/views/add_new_address/add_new_address.dart';
import 'package:prosiddho/functions/firestore_crud/firestore_update_function.dart';

class ProfileScreen extends StatelessWidget {
  final UserController _userController = Get.find<UserController>();

  //TODO separate this part

  Widget _addAddress(int index, Address address, BuildContext context) {
    var color = Colors.black;
    double width = .5;

    if (address != null && address.active) {
      color = ColorPalette.primaryRed;
      width = 2.0;
    }

    return Container(
      margin: Style.marginVertically / 2,
      child: DottedBorder(
        borderType: BorderType.RRect,
        strokeWidth: width,
        color: color,
        dashPattern: [4, 4],
        radius: Radius.circular(12),
        padding: EdgeInsets.all(6),
        child: address == null
            ?
            //add new address
            GestureDetector(
                onTap: () {
                  print("insert new address successfully");
                  Get.to(AddNewAddress());
                },
                child: Container(
                  padding: EdgeInsets.all(6),
                  child: Center(
                    child: Text("Add new address"),
                  ),
                ),
              )
            :
            //show old saved address
            Row(
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //address lane
                          Text(
                            address.addressLane,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: ColorPalette.text,
                            ),
                          ),

                          //city with postal code
                          Text(
                            "${address.city}, ${address.postalCode}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: ColorPalette.text,
                            ),
                          ),

                          //houser no road no
                          // show if data exists
                          Row(
                            children: [
                              if (address.houseNo.length != 0)
                                Text(
                                  "House: ${address.houseNo}",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              if (address.roadNo.length != 0)
                                Text(
                                  " Road: ${address.roadNo}",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                            ],
                          ),

                          //others
                          //show if dta exists
                          if (address.others.length != 0)
                            Text(
                              address.others,
                              style: TextStyle(
                                fontSize: 16,
                                color: ColorPalette.text,
                              ),
                            ),
                        ],
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            CircleAvatar(
              minRadius: 200,
              backgroundImage: NetworkImage(
                _userController.userModel.gamil.photoURL,
              ),
            ),
            Text(_userController.userModel.name),
            Text(_userController.userModel.gamil.email),
            Text("phone: ${_userController.userModel.phone}"),
            Text("total order: not implement yet"),
            Text("since: ${_userController.userModel.createDate.toDate()}"),
            Text("points: ${_userController.userModel.point}"),
            Text("free delivery: ${_userController.userModel.freeDelivery}"),
            Text("total orders: not implement yet"),

            //* ListView.builder throw some error inside obx in init state
            //thats why use obx for ever address

            //address 1
            Obx(
              () {
                return _userController.userModel.address.length >= 1
                    ? _addAddress(
                        0,
                        _userController.userModel.address[0],
                        context,
                      )
                    : _addAddress(0, null, context);
              },
            ),

            //address 2
            Obx(
              () {
                return _userController.userModel.address.length >= 2
                    ? _addAddress(
                        1,
                        _userController.userModel.address[1],
                        context,
                      )
                    : _addAddress(1, null, context);
              },
            ),

            //address 3
            Obx(
              () {
                return _userController.userModel.address.length >= 3
                    ? _addAddress(
                        2,
                        _userController.userModel.address[2],
                        context,
                      )
                    : _addAddress(1, null, context);
              },
            ),

            //address 4
            Obx(
              () {
                return _userController.userModel.address.length >= 4
                    ? _addAddress(
                        3,
                        _userController.userModel.address[3],
                        context,
                      )
                    : _addAddress(1, null, context);
              },
            ),

            //address 5
            Obx(
              () {
                return _userController.userModel.address.length >= 5
                    ? _addAddress(
                        4,
                        _userController.userModel.address[4],
                        context,
                      )
                    : _addAddress(1, null, context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
