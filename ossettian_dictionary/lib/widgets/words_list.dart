import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_stock_app/utilities.dart';

import '../models/word.dart';
import '../provider/api_provider.dart';
import '../provider/search_service.dart';
import 'word_card.dart';

class WordList extends StatefulWidget {
  @override
  State<WordList> createState() => _WordListState();
}

class _WordListState extends State<WordList> {
  // Used to display loading indicators when _loadMore function is running
  void _loadMore() async {
    if (Provider.of<ApiProvider>(context,listen: false).isLoadMoreRunning == false && _controller.position.extentAfter < 300) {
      print(Provider.of<ApiProvider>(context,listen: false).offset);
      Provider.of<ApiProvider>(context,listen: false).getWordsFromApi();
    }
  }

  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()..addListener(_loadMore);
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _provider = Provider.of<ApiProvider>(context);
    final _searchService = Provider.of<SearchService>(context);

    List<Word> words = _provider.isFavorite
        ? _provider.words
            .where((element) =>
                element.isFavorite! &&
                (element.osettianTranslate!
                        .startsWith(_searchService.searchValue) ||
                    element.russianTranslates!
                        .contains(_searchService.searchValue)))
            .toList()
        : _provider.words
            .where((element) =>
                element.osettianTranslate!
                    .startsWith(_searchService.searchValue) ||
                element.russianTranslates!.contains(_searchService.searchValue))
            .toList();
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      child: Scrollbar(
        
        child: ListView.builder(
          controller: _controller,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return WordCard(words[index]);
          },
          itemCount: words.length,
        ),
      ),
    );
  }
}
