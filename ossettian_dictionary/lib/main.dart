import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './provider/api_provider.dart';
import './provider/search_service.dart';
import './pages/splash_page.dart';
import './pages/home_page.dart';
import './pages/translate_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ApiProvider()),
        ChangeNotifierProvider(create: (context) => SearchService()),
      ],
      child: MaterialApp(
        routes: {
          '/home': (context) => HomePage(),
          '/translate': (context) => TranslatePage(),
        },
        title: 'Dictionary',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashPage(),
      ),
    );
  }
}
