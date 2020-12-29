import 'package:flutter/material.dart';
import 'package:prosiddho/style/color_palette.dart';
import 'package:prosiddho/style/style_export.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.primary,
        title: Text("Contact"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: Style.marginBase,
          child: Column(
            children: [
              //social
              Container(
                padding: Style.marginBase / 2,
                decoration: BoxDecoration(
                  color: ColorPalette.bg.withOpacity(.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(
                        FontAwesomeIcons.google,
                        color: Colors.red,
                      ),
                      title: Text("Google"),
                      subtitle: Text("prosiddho@gmail.com"),
                    ),
                    ListTile(
                      leading: Icon(
                        FontAwesomeIcons.facebook,
                        color: Colors.blue,
                      ),
                      title: Text("Facebook"),
                      subtitle: Text("fb.com/prosiddho"),
                    ),
                    ListTile(
                      leading: Icon(
                        FontAwesomeIcons.twitter,
                        color: Colors.blue,
                      ),
                      title: Text("Twitter"),
                      subtitle: Text("twitter.com/proshiddho"),
                    ),
                  ],
                ),
              ),

              //phone
              Container(
                padding: Style.marginBase / 2,
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  color: ColorPalette.bg.withOpacity(.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(
                        FontAwesomeIcons.phone,
                        color: Colors.green,
                      ),
                      title: Text("Helpline"),
                      subtitle: Text("+8801717000000"),
                    ),
                    ListTile(
                      leading: Icon(
                        FontAwesomeIcons.phone,
                        color: Colors.green,
                      ),
                      title: Text("Customer Care"),
                      subtitle: Text("+8801717000000"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _media({
    @required IconData icon,
    @required String link,
  }) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Icon(icon),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(link),
            ),
          ],
        ),
      );
}
