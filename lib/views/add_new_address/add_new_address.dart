import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:prosiddho/controller/user_controller.dart';
import 'package:prosiddho/functions/firestore_crud/firestore_update_function.dart';
import 'package:prosiddho/model/user_model/address_model.dart';
import 'package:prosiddho/style/style.dart';

class AddNewAddress extends StatelessWidget {
  final UserController _userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormBuilderState> _key = GlobalKey<FormBuilderState>();

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FormBuilder(
            key: _key,
            child: Container(
              margin: Style.marginHorizontally,
              child: Column(
                children: [
                  //address
                  FormBuilderTextField(
                    attribute: "addressLane",
                    decoration: InputDecoration(labelText: "Address"),
                    validators: [
                      FormBuilderValidators.max(100),
                      FormBuilderValidators.min(10),
                      FormBuilderValidators.required(),
                    ],
                  ),

                  //city
                  FormBuilderTextField(
                    attribute: "city",
                    decoration: InputDecoration(labelText: "City"),
                    validators: [
                      FormBuilderValidators.max(40),
                      FormBuilderValidators.min(3),
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

                      //house no
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: FormBuilderTextField(
                            attribute: "houseNo",
                            decoration: InputDecoration(labelText: "House No"),
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

                  //others
                  FormBuilderTextField(
                    attribute: "others",
                    decoration: InputDecoration(labelText: "Others"),
                  ),
                ],
              ),
            ),
          ),
          RaisedButton(
            onPressed: () async {
              if (_key.currentState.saveAndValidate()) {
                String addressLane =
                    _key.currentState.fields['addressLane'].currentState.value;
                String city =
                    _key.currentState.fields['city'].currentState.value;
                String postalCode =
                    _key.currentState.fields['postalCode'].currentState.value;
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
                List<Address> addressList = _userController.userModel.address;

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
            child: Text("add address"),
          ),
        ],
      ),
    );
  }
}
