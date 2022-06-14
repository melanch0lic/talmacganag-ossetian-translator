import 'package:flutter/material.dart';

class SearchService with ChangeNotifier{
    String _searchValue = '';
   String get searchValue{
    return _searchValue;
  }

  void searchHandler(String value){
    _searchValue = value.toLowerCase();
    notifyListeners();
  }
}