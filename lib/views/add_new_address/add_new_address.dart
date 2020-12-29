import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:prosiddho/controller/user_controller.dart';
import 'package:prosiddho/functions/firestore_crud/firestore_update_function.dart';
import 'package:prosiddho/model/user_model/address_model.dart';
import 'package:prosiddho/style/style_export.dart';

class AddNewAddress extends StatelessWidget {
  final UserController _userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormBuilderState> _key = GlobalKey<FormBuilderState>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.primary,
        title: Text("Add New Address"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: Style.marginBase,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormBuilder(
                key: _key,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //address
                      FormBuilderTextField(
                        attribute: "addressLane",
                        decoration: InputDecoration(labelText: "Address"),
                        validators: [
                          FormBuilderValidators.minLength(10),
                          FormBuilderValidators.maxLength(100),
                          FormBuilderValidators.required(),
                        ],
                      ),

                      //city
                      FormBuilderTextField(
                        attribute: "city",
                        decoration: InputDecoration(labelText: "City"),
                        validators: [
                          FormBuilderValidators.maxLength(40),
                          FormBuilderValidators.minLength(3),
                        ],
                      ),

                      Row(
                        children: [
                          //postal code
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                right: 5.0,
                              ),
                              child: FormBuilderTextField(
                                attribute: "postalCode",
                                decoration:
                                    InputDecoration(labelText: "Postal Code"),
                                validators: [
                                  FormBuilderValidators.numeric(),
                                ],
                              ),
                            ),
                          ),

                          //road no
                          Expanded(
                            child: FormBuilderTextField(
                              attribute: "roadNo",
                              decoration: InputDecoration(labelText: "Road No"),
                            ),
                          ),
                        ],
                      ),

                      //house no
                      FormBuilderTextField(
                        attribute: "houseNo",
                        decoration: InputDecoration(labelText: "House No"),
                      ),

                      //others
                      FormBuilderTextField(
                        attribute: "others",
                        decoration: InputDecoration(labelText: "Others"),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 50),
              //old addresses heading

              Text(
                "Address",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),

              if (_userController.userModel.address.length == 0)
                Text(
                  "No Address saved",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),

              SizedBox(height: 5),
              if (_userController.userModel.address.length >= 1)
                _addressItem(_userController.userModel.address[0]),

              if (_userController.userModel.address.length >= 2)
                _addressItem(_userController.userModel.address[1]),

              if (_userController.userModel.address.length >= 3)
                _addressItem(_userController.userModel.address[2]),

              if (_userController.userModel.address.length >= 4)
                _addressItem(_userController.userModel.address[3]),

              if (_userController.userModel.address.length >= 5)
                _addressItem(_userController.userModel.address[4]),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigation(
        child: Padding(
          padding: Style.marginVertically / 3,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Buttons.normalButton(
                text: "Add New Address",
                padding: EdgeInsets.symmetric(
                  vertical: 18,
                ),
                onTap: () async {
                  if (_key.currentState.saveAndValidate()) {
                    String addressLane = _key
                        .currentState.fields['addressLane'].currentState.value;
                    String city =
                        _key.currentState.fields['city'].currentState.value;
                    String postalCode = _key
                        .currentState.fields['postalCode'].currentState.value;
                    String houseNo =
                        _key.currentState.fields['houseNo'].currentState.value;
                    String roadNo =
                        _key.currentState.fields['roadNo'].currentState.value;
                    String others =
                        _key.currentState.fields['others'].currentState.value;

                    Address address = Address(
                      addressLane: addressLane.trim(),
                      city: city.trim(),
                      postalCode: (postalCode == null || postalCode.length == 0)
                          ? 0000
                          : int.parse(postalCode),
                      houseNo: houseNo.trim(),
                      roadNo: roadNo.trim(),
                      others: others.trim(),
                      active: false,
                    );

                    //collect all addresses
                    List<Address> addressList =
                        _userController.userModel.address;

                    // if no address available
                    //set new address active TRUE
                    if (addressList.length == 0) {
                      address.active = true;
                    }

                    //add new address
                    addressList.add(address);

                    //update in database
                    await FirestoreUpdateFunction.address(addressList);

                    //back to profile page
                    Get.back();
                  }
                },
              ),
            ],
          ),
        ),
      ),
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
            //address lane
            Text(
              address.addressLane.capitalize,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
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
