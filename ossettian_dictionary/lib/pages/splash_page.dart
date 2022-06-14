import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/navigation_page.dart';
import '../provider/api_provider.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2)).then((value) => Future.wait([
          Provider.of<ApiProvider>(context, listen: false).getWordsFromApi(),
        ]).then((value) => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => NavigationPage()))));
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.white,
                  Colors.red,
                  Colors.yellow,
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Icon(
                Icons.local_library,
                color: Colors.black,
                size: 80,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 160,
                height: 160,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.black.withOpacity(0.2)),
                  strokeWidth: 10,
                ),
              ),
            )
          ],
        ));
  }
}
