import 'package:flutter/material.dart';

import '../widgets/search_bar.dart';
import '../widgets/words_list.dart';


class HomePage extends StatelessWidget {
  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: EdgeInsets.only(left: 30, right: 30, top: 60),
            child: SafeArea(
              child: Column(
                children: [
                  SearchWidget(),
                  SizedBox(height: 8,),
                  Expanded(child: WordList())
                ],
              ),
            ),
          );
  }
}
