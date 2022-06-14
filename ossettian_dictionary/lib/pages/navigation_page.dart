import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/home_page.dart';
import '../pages/translate_page.dart';
import '../provider/api_provider.dart';

class NavigationPage extends StatefulWidget {
  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  final _controller = PageController(initialPage: 0);
  double pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    'assets/vld.jpg'),
                fit: BoxFit.cover),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
        ),
        AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            pageIndex == 0
                ? 'Словарь'
                : pageIndex == 1
                    ? 'Переводчик'
                    : 'Clown',
            style: TextStyle(color: Colors.white),
          ),
        ),
        PageView(
          physics: BouncingScrollPhysics(),
          controller: _controller,
          onPageChanged: (page) {
            setState(() {
              pageIndex = page.toDouble();
            });
          },
          children: [HomePage(), TranslatePage()],
        ),
        if (pageIndex == 0)
          Positioned(
              top: 8,
              right: 8,
              child: SafeArea(
                child: Consumer<ApiProvider>(
                  builder: (_, provider, __){ return IconButton(
                    icon: provider.isFavorite ? Icon(Icons.favorite, color: Colors.white, size: 28,) :  Icon(Icons.favorite_outline, color: Colors.white, size: 28,),
                    onPressed: () {
                      provider.makeFavorite();
                    },
                  );
                  }
                ),
              )),
      ]),
    );
  }
}
