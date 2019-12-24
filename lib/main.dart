import 'package:flutter/material.dart';
import 'package:gym_bar/ui/routers.dart';
import 'package:provider/provider.dart';
import 'core/view_models/product_model.dart';
import 'locator.dart';

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
        initialRoute: '/',
        title: 'Gym Bar',
        theme: ThemeData(),
        onGenerateRoute: Routers.generateRoute,
      ),
    );
  }
}
