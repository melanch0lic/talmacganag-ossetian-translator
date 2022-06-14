import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_stock_app/provider/api_provider.dart';
import 'package:test_stock_app/widgets/custom_button.dart';

class TranslatePage extends StatefulWidget {
  static const String routeName = '/translate';

  @override
  State<TranslatePage> createState() => _TranslatePageState();
}

class _TranslatePageState extends State<TranslatePage> {
  TextEditingController _controllerFrom = TextEditingController();
  TextEditingController _controllerTo = TextEditingController();

  String? _dropdownValue1 = 'Русский';
  String? _dropdownValue2 = 'Осетинский';

  showAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Слово не найдено"),
      content: Text("Проверьте правильность ввода"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void dispose() {
    _controllerFrom.dispose();
    _controllerTo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(left: 30, right: 30),
        child: Consumer<ApiProvider>(builder: (_, provider, __) {
          return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            TextField(
              controller: _controllerFrom,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                fillColor: Colors.black.withOpacity(0.4),
                filled: true,
                focusColor: Colors.transparent,
                labelStyle: TextStyle(color: Colors.white, fontSize: 16.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(width: 2, color: Colors.white)),
                hintText: 'Введите слово...',
                hintStyle: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                dropDownBarMaker(_dropdownValue1, changeDropValue1),
                IconButton(
                    onPressed: () {
                      setState(() {
                        if (_dropdownValue1 != _dropdownValue2) {
                          String? value = _dropdownValue1;
                          _dropdownValue1 = _dropdownValue2;
                          _dropdownValue2 = value;
                        }
                      });
                    },
                    icon: Icon(
                      Icons.swap_horiz,
                      size: 34,
                      color: Colors.white,
                    )),
                dropDownBarMaker(_dropdownValue2, changeDropValue2),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              enabled: false,
              controller: _controllerTo,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                fillColor: Colors.black.withOpacity(0.4),
                filled: true,
                focusColor: Colors.transparent,
                labelStyle: TextStyle(color: Colors.white, fontSize: 16.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(width: 2, color: Colors.white)),
                hintText: 'Перевод...',
                hintStyle: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                    width: 150,
                    height: 50,
                    child: MyElevatedButton(
                        onPressed: () {
                          print(_controllerFrom.text);
                          provider
                              .translateWord(_dropdownValue1, _dropdownValue2,
                                  _controllerFrom.text.toLowerCase())
                              .then((value) {
                            setState(
                              () {
                                _controllerTo.text = provider.translate!;
                              },
                            );
                          }, onError: (error) {
                            print(error);
                          }).catchError((error, stackTrace) {
                            showAlertDialog(context);
                             setState(
                              () {
                                _controllerTo.text = 'Слово не найдено!';
                              },
                            );
                            print(error);
                          });
                        },
                        child: Text('Перевести'))),
              ),
            ),
          ]);
        }),
      ),
    );
  }

  void changeDropValue1(String? value) {
    _dropdownValue1 = value ?? "";
    if (value == 'Русский') {
      _dropdownValue2 = 'Осетинский';
    } else if (value == 'Осетинский') {
      _dropdownValue2 = 'Русский';
    }
  }

  void changeDropValue2(String? value) {
    _dropdownValue2 = value ?? "";
    if (value == 'Русский') {
      _dropdownValue1 = 'Осетинский';
    } else if (value == 'Осетинский') {
      _dropdownValue1 = 'Русский';
    }
  }

  Container dropDownBarMaker(String? dropValue, Function handler) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.6),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              offset: Offset.zero,
              color: Colors.black.withOpacity(0.1),
            )
          ]),
      child: DropdownButton(
        borderRadius: BorderRadius.circular(10),
        value: dropValue,
        items: [
          'Русский',
          'Осетинский',
        ].map((String value) {
          return DropdownMenuItem(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? value) {
          setState(() {
            handler(value);
          });
        },
      ),
    );
  }
}
