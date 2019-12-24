import 'package:flutter/material.dart';
import 'package:gym_bar/ui/routers.dart';
import 'package:provider/provider.dart';
import 'core/view_models/product_model.dart';
import 'locator.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
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
          initialRoute: '/signup',
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
