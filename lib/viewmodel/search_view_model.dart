import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:magic_image_generator/common/mig_exception.dart';
import 'package:magic_image_generator/domain/card_repository.dart';
import 'package:magic_image_generator/model/search_result.dart';
import 'package:magic_image_generator/view/sort_drop_down.dart';

import '../common/constants.dart' as constants;
import '../common/search_filter.dart';
import '../common/search_filter_factory.dart';
import '../common/util.dart';
import '../domain/analyze_filter_usecase.dart';
import '../domain/analyze_query_usecase.dart';
import '../model/card_info_header.dart';

class SearchViewModel extends ChangeNotifier {
  final CardRepository _repository;
  SortKey _sortKey = SortKey.cmc;
  SortOrder _sortOrder = SortOrder.asc;
  SearchResult _searchResult = SearchResult(cards: [], isSuccess: false);
  String query = "";
  Map<SearchFilter, bool> searchFilters = {};

  SearchResult get searchResult => _searchResult;

  SortKey get sortKey => _sortKey;
  SortOrder get order => _sortOrder;

  bool isSearching = false;


  SearchViewModel(this._repository) {
    for(var v in SearchFilter.values) {
      searchFilters[v] = false;
    }
  }

  void flip(CardInfoHeader card) {
    int index = _searchResult.cards.indexWhere((element) => element.displayId == card.displayId);
    _searchResult.cards[index].isFront = !_searchResult.cards[index].isFront;
    notifyListeners();
  }

  Future<void> search(String query, Locale locale, List<SearchFilterData> filterDataList) async {
    Util.printTimeStamp("start search(String query, Locale locale)");

    //クエリの分析
    this.query = query;

    if(_hasFilter()) {
      query = query + " " + AnalyzeFilterUseCase().call(searchFilters, filterDataList);
      print(query);
    }

    await _search(query, locale);
  }

  Future<void> searchFromAdvanced(Locale locale, List<SearchFilterData> filterDataList) async {
    if(!_hasFilter()) {
      return;
    }

    String query = AnalyzeFilterUseCase().call(searchFilters, filterDataList);
    await _search(this.query + " " + query, locale);
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

  void switchSearchFilter(SearchFilter filter) {
    searchFilters[filter] = !searchFilters[filter]!;
    notifyListeners();
  }

  void resetSearchFilter() {
    for(var f in SearchFilter.values) {
      searchFilters[f] = false;
    }
    notifyListeners();
  }

  bool _hasFilter() {
    bool sum = false;
    for(var f in SearchFilter.values) {
      sum = sum || searchFilters[f]!;
    }

    return sum;
  }


  Future<void> _search(String query, Locale locale) async {
    isSearching = true;
    notifyListeners();

    if (Util.getCurrentEnvironment() == constants.Environment.production) {
      await FirebaseAnalytics.instance.logEvent(
        name: "submit_query",
        parameters: {
          "query": query,
        },
      );
    }

    try {
      var analyzer = AnalyzeQueryUseCase();
      var conditions = analyzer.call(query);

      //リポジトリから結果の取り出し
      var dateTime1 = DateTime.now();
      if (kDebugMode) {
        Util.printTimeStamp("Query Start");
      }
      List<CardInfoHeader> results = await _repository.get(conditions, locale);
      var dateTime2 = DateTime.now();
      if (kDebugMode) {
        Util.printTimeStamp("Query End");
        print("Time : ${dateTime2.difference(dateTime1)}");
      }
      _searchResult = SearchResult(cards: results, isSuccess: true);
      sortSearchResults(locale);
    } catch(e) {
      _searchResult = SearchResult(cards: [], isSuccess: false, exception: MIGException(100));
      if (kDebugMode) {
        print(e);
      }
    }

    //リザルトを更新
    isSearching = false;
    notifyListeners();
  }

}