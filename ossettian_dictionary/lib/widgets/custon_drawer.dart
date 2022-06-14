import 'package:flutter/material.dart';

import '../routes.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/drawerimg.jpg'))),
              child: Stack(children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.8)
                    ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                  ),
                ),
                Positioned(
                    bottom: 12.0,
                    left: 16.0,
                    child: Text("Некий текст",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500))),
              ])),
          ListTile(
              title: Row(
                children: [
                  Icon(Icons.import_contacts),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text('Словарь'),
                  )
                ],
              ),
              onTap: () =>
                  Navigator.pushReplacementNamed(context, Routes.dictionary)),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.g_translate),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text('Переводчик'),
                )
              ],
            ),
            onTap: () =>
                Navigator.pushReplacementNamed(context, Routes.translator),
          )
        ],
      ),
    );
  }
}
