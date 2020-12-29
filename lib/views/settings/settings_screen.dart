import 'package:flutter/material.dart';
import 'package:prosiddho/style/color_palette.dart';
import 'package:prosiddho/style/style_export.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFEFEF),
      appBar: AppBar(
        backgroundColor: ColorPalette.primary,
        title: Text("Settings"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: Style.marginBase,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //heading
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "Notification",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              SizedBox(
                height: 10,
              ),

              //notification
              Card(
                elevation: 3.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      //location tracking
                      _infoItemNotification(
                        title: "Location Tracking",
                        onTap: () => print("Location Tracking"),
                      ),

                      //New Offer
                      _infoItemNotification(
                        title: "New Offer",
                        onTap: () => print("New Offer"),
                      ),

                      //New Product
                      _infoItemNotification(
                        title: "New Product",
                        onTap: () => print("New Product"),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "Others",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              SizedBox(
                height: 10,
              ),

              Card(
                elevation: 3.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      //language
                      _infoItem(
                        icon: Icons.language,
                        title: "Language",
                        onTap: null,
                        values: ["English", "Bangla"],
                        initValue: "English",
                      ),

                      _infoItem(
                        icon: Icons.star,
                        title: "Theme",
                        onTap: null,
                        values: ["Light", "Dark"],
                        initValue: "Light",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoItemNotification({
    @required String title,
    @required Function onTap,
  }) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 3.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Spacer(),
                Switch(
                  value: true,
                  onChanged: (bool value) {},
                ),
              ],
            ),
            Divider(
              height: 10,
              color: ColorPalette.bg.withOpacity(.5),
            ),
          ],
        ),
      );

  Widget _infoItem({
    @required IconData icon,
    @required String title,
    @required Function onTap,
    @required String initValue,
    @required List<String> values,
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
                  DropdownButton<String>(
                    underline: SizedBox(),
                    value: initValue,
                    onChanged: (String newValue) {},
                    items: values.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
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
