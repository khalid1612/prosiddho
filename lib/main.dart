import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prosiddho/style/style_export.dart';
import 'views/splash/splash_screen.dart';
import 'style/theme.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //change all statusbar color
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: ColorPalette.primary,
        // statusBarIconBrightness: Brightness.dark,
      ),
    );

    //GestureDetector for unfocus textfield
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus.unfocus();
        }
      },
      child: GetMaterialApp(
        title: 'PROSIDDHO',
        debugShowCheckedModeBanner: false,
        theme: themeData(),
        home: SplashScreen(),
      ),
    );
  }
}
