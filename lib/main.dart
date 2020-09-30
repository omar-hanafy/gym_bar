import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gym_bar/core/view_models/product_category_model.dart';
import 'package:gym_bar/ui/routers.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'core/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  permission() async => await Permission.storage.request();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

  runApp(MyApp());
  setupLocator();
  permission();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductCategoryModel())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        title: 'Gym Bar',
        theme: ThemeData(fontFamily: 'Tajawal'),
        onGenerateRoute: Routers.generateRoute,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
//        supportedLocales: [
//          Locale("ar", "EG"), // OR Locale('ar', 'AE') OR Other RTL locales
//        ],
//        locale: Locale("ar", "EG"),
      ),
    );
  }
}
