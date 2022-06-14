import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/search_service.dart';

class SearchWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SearchService>(context, listen :false);
    return SizedBox(
        height: 50,
        child: TextField(
          onChanged: (value) {
            provider.searchHandler(value);
          },
          decoration: InputDecoration(
              hintStyle:
                  TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 16),
              hintText: "Введите слово...",
              fillColor: Colors.grey.withOpacity(0.6),
              filled: true,
              prefixIcon: const Icon(
                Icons.search,
              ),
              border: const OutlineInputBorder(
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
                borderRadius: BorderRadius.all(Radius.circular(16)),
              )),
        ));
  }
}
