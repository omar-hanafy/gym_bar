import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gym_bar/ui/routers.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'core/view_models/product_model.dart';
import 'locator.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  permission() async {
    await PermissionHandler().requestPermissions([PermissionGroup.storage]);
  }

  permission();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
  setupLocator();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (_) => locator<ProductModel>(),
          create: (BuildContext context) {},
        ),
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
          supportedLocales: [
            Locale("ar", "EG"), // OR Locale('ar', 'AE') OR Other RTL locales
          ],
          locale: Locale("ar", "EG")),
    );
  }
}
