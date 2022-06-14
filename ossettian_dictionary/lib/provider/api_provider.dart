import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../models/word.dart';

class ApiProvider with ChangeNotifier {
  List<Word> _words = [];
  bool _isFavorite = false;

  bool _isLoadMoreRunning = false;

  int _offset = 0;

  String? _translate;

  bool get isLoadMoreRunning{
    return _isLoadMoreRunning;
  }

  int get offset {
    return _offset;
  }

  void increaseOffset() {
    _offset += 50;
  }

  String? get translate {
    return _translate;
  }

  bool get isFavorite {
    return _isFavorite;
  }

  List<Word> get words {
    return [..._words];
  }

  void makeFavorite() {
    _isFavorite = !_isFavorite;
    notifyListeners();
  }

  void selectFavorite(int id) {
    _words.forEach((element) {
      if (element.id == id) {
        element.isFavorite = !element.isFavorite!;
        notifyListeners();
        return;
      }
    });
  }

  Future<String> getWordsFromApi() async {
    final url1 = Uri(
      scheme: 'http',
      host: '10.0.2.2',
      port: 5000,
      path: '/words',
    );
    try {
      _isLoadMoreRunning = true;
      final response = await http
          .post(url1, body: json.encode({"offset": '$_offset'}), headers: {
        "Content-Type": "application/json",
        "Access-Control_Allow_Origin": "*",
        "Charset": "utf-8",
        "Accept": "application/json"
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        print('connect');
        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse);
        for (int i = 0; i < jsonResponse.length; i++) {
          _words.add(Word(
              id: jsonResponse[i]['id'],
              osettianTranslate: jsonResponse[i]['osetian_word'],
              transcription: jsonResponse[i]['transcription'],
              russianTranslates:
                  List<String>.from(jsonResponse[i]['russian_words'])));
        }
        notifyListeners();
        increaseOffset();
      }
    } catch (err) {
      print(err);
      return 'Failure';
    } finally {
      print('finally');
      _isLoadMoreRunning = false;
      return 'Success';
    }
  }

  Future<String> translateWord(
      String? lanFrom, String? lanTo, String? word) async {
    if (lanFrom == 'Русский' && lanTo == 'Осетинский') {
      final urlOset = Uri(
        scheme: 'http',
        host: '10.0.2.2',
        port: 5000,
        path: '/get_osetian_word',
      );
      try {
        final response = await http.post(urlOset,
            body: json.encode({"russian_word": '$word'}),
            headers: {
              "Content-Type": "application/json",
              "Access-Control_Allow_Origin": "*",
              "Charset": "utf-8",
              "Accept": "application/json"
            });
        print(jsonDecode(response.body));
        final data = jsonDecode(response.body);
        _translate = data[0][0];
        print(_translate);
      } catch (error) {
        print(error);
        _translate = null;
        return 'Failure to Load from Rus';
      }
      return 'Success';
    } else if (lanFrom == 'Осетинский' && lanTo == 'Русский') {
      final urlOset = Uri(
        scheme: 'http',
        host: '10.0.2.2',
        port: 5000,
        path: '/get_russian_word',
      );
      try {
        final response = await http.post(urlOset,
            body: json.encode({"osetian_word": '$word'}),
            headers: {
              "Content-Type": "application/json",
              "Access-Control_Allow_Origin": "*",
              "Charset": "utf-8",
              "Accept": "application/json"
            });
        print(jsonDecode(response.body));
        final data = jsonDecode(response.body);
        String temp = '';
        int i = 0;
        for (var item in data) {
          temp += item[0];
          if (i != data.length - 1) {
            temp += ', ';
          }
          i++;
        }
        _translate = temp;

        print(_translate);
      } catch (error) {
        print(error);
        _translate = null;
        return 'Failure to Load from Oset';
      }
      return 'Success';
    }

    return 'Failure';
  }
}
