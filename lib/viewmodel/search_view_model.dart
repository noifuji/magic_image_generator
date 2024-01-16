import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:magic_image_generator/common/mig_exception.dart';
import 'package:magic_image_generator/domain/card_repository.dart';
import 'package:magic_image_generator/domain/entity/card_info.dart';
import 'package:magic_image_generator/domain/entity/card_info_header.dart';
import 'package:magic_image_generator/domain/entity/search_result.dart';
import 'package:magic_image_generator/domain/usecase/import_deck_list_usecase.dart';
import 'package:magic_image_generator/view/sort_drop_down.dart';
import 'package:magic_image_generator/view/widgets/web_image.dart';

import '../common/constants.dart' as constants;
import '../common/search_filter.dart';
import '../common/search_filter_factory.dart';
import '../common/util.dart';
import '../domain/usecase/analyze_filter_usecase.dart';
import '../domain/usecase/analyze_query_usecase.dart';
import '../view/widgets/progress_bar.dart';

class SearchViewModel extends ChangeNotifier {
  final CardRepository _repository;
  double advancedSearchScrollPosition = 0;
  SortKey _sortKey = SortKey.cmc;
  SortOrder _sortOrder = SortOrder.asc;
  SearchResult _searchResult = SearchResult(cards: [], isSuccess: false);
  String searchBoxText = "";
  Map<SearchFilter, bool> searchFilters = {};

  SearchResult get searchResult => _searchResult;

  SortKey get sortKey => _sortKey;

  SortOrder get order => _sortOrder;

  Completer<void>? searchCompleter;
  late ProgressBarController _searchProgressController;

  ProgressBarController get searchProgressController =>
      _searchProgressController;

  SearchViewModel(this._repository) {
    for (var v in SearchFilter.values) {
      searchFilters[v] = false;
    }
  }

  void flip(CardInfoHeader card) {
    int index = _searchResult.cards
        .indexWhere((element) => element.displayId == card.displayId);
    _searchResult.cards[index] = _searchResult.cards[index]
        .copyWith(isFront: !_searchResult.cards[index].isFront);
    notifyListeners();
  }

  bool isSearching() {
    return searchCompleter != null && !searchCompleter!.isCompleted;
  }

  Future<void> search(Locale locale, List<SearchFilterData> filterDataList,
      {String? query}) async {
    var completer = Completer<void>();
    _searchProgressController = ProgressBarController(0);

    if (query != null) {
      searchBoxText = query;
    }

    var q = "";
    if (_hasSearchBoxQuery()) {
      q = "$q($searchBoxText)";
    }

    if (_hasFilter()) {
      var queryFromFilter =
          AnalyzeFilterUseCase().call(searchFilters, filterDataList);
      q = "$q $queryFromFilter";
    }

    Future<void> future = _search(q, locale);
    future.then(completer.complete).catchError(completer.completeError);
    searchCompleter = completer;
    notifyListeners();
  }

  Future<void> searchByDeckList(
      Locale locale,
      List<SearchFilterData> filterDataList,
      String rawDeckList,
      Map<constants.ArenaDeckListGroup, String> groupMap) async {
    var import = ImportDeckListUsecase();
    var query = import.call(rawDeckList, groupMap);
    await search(locale, filterDataList, query: query);
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

  void _sortCardInfoHeader(
      List<CardInfoHeader> list, SortKey key, SortOrder order, Locale locale) {
    if (key == SortKey.cmc) {
      list.sort((a, b) =>
          a.cardFaces[0].cmc.compareTo(b.cardFaces[0].cmc) *
          (order == SortOrder.asc ? 1 : -1));
    } else if (key == SortKey.name) {
      if (locale.languageCode == "ja") {
        list.sort((a, b) =>
            a.cardFaces[0].nameJpYomi.compareTo(b.cardFaces[0].nameJpYomi) *
            (order == SortOrder.asc ? 1 : -1));
      } else {
        list.sort((a, b) =>
            a.cardFaces[0].name.compareTo(b.cardFaces[0].name) *
            (order == SortOrder.asc ? 1 : -1));
      }
    }
  }

  void switchSearchFilter(SearchFilter filter) {
    searchFilters[filter] = !searchFilters[filter]!;
    notifyListeners();
  }

  void setSearchFilters(List<SearchFilter> filters) {
    for(final f in filters) {
      searchFilters[f] = true;
    }
    notifyListeners();
  }

  void resetSearchFilter() {
    for (var f in SearchFilter.values) {
      searchFilters[f] = false;
    }
    notifyListeners();
  }

  bool _hasSearchBoxQuery() {
    return searchBoxText.replaceAll(' ', '').isNotEmpty;
  }

  bool _hasFilter() {
    bool sum = false;
    for (var f in SearchFilter.values) {
      sum = sum || searchFilters[f]!;
    }

    return sum;
  }

  Future<void> _search(String query, Locale locale) async {
    try {
      //クエリログ取得
      if (Util.getCurrentEnvironment() == constants.Environment.production) {
        await FirebaseAnalytics.instance.logEvent(
          name: "submit_query",
          parameters: {
            "query": query,
          },
        );
      }
      _searchProgressController.value = 0.2;

      Util.printTimeStamp(query);

      //クエリ分析
      var analyzer = AnalyzeQueryUseCase();
      var conditions = analyzer.call(query);
      _searchProgressController.value = 0.4;

      //クエリ実行
      List<CardInfoHeader> results =
          await _repository.get(conditions, locale, onProgress: (value) {
        _searchProgressController.value = 0.4 + value * 0.4;
      });
      _searchResult = SearchResult(cards: results, isSuccess: true);

      List<CardInfoHeader> newCardList = [];
      for(final card in _searchResult.cards) {
        List<CardInfo> faces = [];
        for(final face in card.cardFaces) {
          faces.add(face.copyWith(webImageController: WebImageController()));
        }

        newCardList.add(card.copyWith(cardFaces: faces));
      }

      _searchResult.cards = newCardList;

      _searchProgressController.value = 0.8;

      //ソート
      sortSearchResults(locale);
      _searchProgressController.value = 1.0;
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print(e);
        print(stackTrace);
      }
      throw MIGException(100);
    }
  }
}
