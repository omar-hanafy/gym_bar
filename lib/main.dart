import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
  // setupLocator();
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(builder: (_) => locator<ProductCrud>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        title: 'Gym Caffe',
        theme: ThemeData(),
        // onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}x