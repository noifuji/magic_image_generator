

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:magic_image_generator/assets/mig_exception.dart';
import 'package:magic_image_generator/domain/card_repository.dart';
import 'package:magic_image_generator/model/search_result.dart';
import 'package:magic_image_generator/view/sort_drop_down.dart';

import '../assets/util.dart';
import '../domain/analyze_query_usecase.dart';
import '../model/card_info.dart';
import '../model/card_info_header.dart';

class SearchViewModel extends ChangeNotifier {
  final CardRepository _repository;
  SortKey _sortKey = SortKey.cmc;
  SortOrder _sortOrder = SortOrder.asc;
  SearchResult _searchResult = SearchResult(cards: [], isSuccess: false);
  String query = "";

  SearchResult get searchResult => _searchResult;

  SortKey get sortKey => _sortKey;
  SortOrder get order => _sortOrder;


  SearchViewModel(this._repository);

  void flip(CardInfoHeader card) {
    int index = _searchResult.cards.indexWhere((element) => element.displayId == card.displayId);
    _searchResult.cards[index].isFront = !_searchResult.cards[index].isFront;
    notifyListeners();
  }

  Future<void> search(String query, Locale locale) async {
    Util.printTimeStamp("start search(String query, Locale locale)");

    //クエリの分析
    this.query = query;

    try {
      var analyzer = AnalyzeQueryUseCase();
      var conditions = analyzer.call(query);

      //リポジトリから結果の取り出し
      List<CardInfoHeader> results = await _repository.get(conditions, locale);
      _searchResult = SearchResult(cards: results, isSuccess: true);
      sortSearchResults(locale);
    } catch(e) {
      _searchResult = SearchResult(cards: [], isSuccess: false, exception: MIGException(100));
      if (kDebugMode) {
        print(e);
      }
    }

    //リザルトを更新
    notifyListeners();
  }

  void setSortKey(SortKey sortKey, Locale locale) {
    _sortKey = sortKey;
    sortSearchResults(locale);
  }

  void setSortOrder(SortOrder order, Locale locale) {
    _sortOrder = order;
    sortSearchResults(locale);
  }

  void sortSearchResults(Locale locale) {
    _sortCardInfoHeader(_searchResult.cards, _sortKey, _sortOrder, locale);
    notifyListeners();
  }

  void _sortCardInfoHeader(List<CardInfoHeader> list,SortKey key, SortOrder order, Locale locale) {
    if(key == SortKey.cmc) {
      list.sort((a, b) => a.cardFaces[0].cmc.compareTo(b.cardFaces[0].cmc) * (order == SortOrder.asc? 1: -1));
    } else if(key == SortKey.name) {
      if(locale.languageCode == "ja") {
        list.sort((a, b) => a.cardFaces[0].nameJpYomi.compareTo(b.cardFaces[0].nameJpYomi) * (order == SortOrder.asc? 1: -1));
      } else {
        list.sort((a, b) => a.cardFaces[0].name.compareTo(b.cardFaces[0].name) * (order == SortOrder.asc? 1: -1));
      }

    }
  }
}