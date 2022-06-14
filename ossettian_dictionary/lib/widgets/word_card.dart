import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_stock_app/models/word.dart';

import '../provider/api_provider.dart';

class WordCard extends StatelessWidget {
  final Word word;

  WordCard(this.word);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 6,
            colors: [
              Colors.white,
              Colors.grey.withOpacity(0.2),
            ],
          )),
          child: ListTile(
            leading: Image.asset(
              'assets/or.png',
              width: 72,
              height: 72,
            ),
            title: Text(
              '${word.osettianTranslate!}',
              style: TextStyle(fontSize: 18),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('[${word.transcription}]'),
                    SizedBox(
                      width: 4,
                    ),
                    Icon(
                      Icons.volume_up,
                      size: 18,
                    )
                  ],
                ),
                Text('Перевод: ${word.russianTranslates}')
              ],
            ),
            trailing: Consumer<ApiProvider>(builder: (_, provider, __) {
              return IconButton(
                icon: word.isFavorite!
                    ? Icon(
                        Icons.star,
                        color: Colors.yellow,
                      )
                    : Icon(Icons.star_border_outlined),
                onPressed: () {
                  provider.selectFavorite(word.id!);
                },
              );
            }),
            isThreeLine: true,
          ),
        ),
      ),
    );
  }
}
