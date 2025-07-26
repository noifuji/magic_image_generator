import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:magic_image_generator/core/mig_exception.dart';
import 'package:magic_image_generator/features/search/domain/card_repository.dart';
import 'package:magic_image_generator/features/search/domain/entity/card_info.dart';
import 'package:magic_image_generator/features/search/domain/entity/card_info_header.dart';
import 'package:magic_image_generator/features/search/domain/entity/search_result.dart';
import 'package:magic_image_generator/features/search/usecase/import_deck_list_usecase.dart';
import 'package:magic_image_generator/features/search/presentation/widgets/sort_drop_down.dart';
import 'package:magic_image_generator/core/widgets/web_image.dart';

import 'package:magic_image_generator/core/constants.dart' as constants;
import 'package:magic_image_generator/core/search_filter.dart';
import 'package:magic_image_generator/core/search_filter_factory.dart';
import 'package:magic_image_generator/core/util.dart';
import '../../usecase/analyze_filter_usecase.dart';
import '../../usecase/analyze_query_usecase.dart';

class SearchViewModel extends ChangeNotifier {
  final CardRepository _repository;
  double advancedSearchScrollPosition = 0;
  double advancedSearchScrollPositionMobile = 0;
  SortKey _sortKey = SortKey.cmc;
  SortOrder _sortOrder = SortOrder.asc;
  SearchResult _searchResult = SearchResult(cards: [], isSuccess: false);
  String searchBoxText = "";
  Map<SearchFilter, bool> searchFilters = {};

  SearchResult get searchResult => _searchResult;

  SortKey get sortKey => _sortKey;

  SortOrder get order => _sortOrder;

  Completer<void>? searchCompleter;

  SearchViewModel(this._repository) {
    for (var v in SearchFilter.values) {
      searchFilters[v] = false;
    }
  }

  void flip({required CardInfoHeader card, required bool toFront}) {
    int index = _searchResult.cards
        .indexWhere((element) => element.displayId == card.displayId);
    _searchResult.cards[index] =
        _searchResult.cards[index].copyWith(isFront: toFront);
    notifyListeners();
  }

  bool isSearching() {
    return searchCompleter != null && !searchCompleter!.isCompleted;
  }

  Future<void> search(Locale locale, List<SearchFilterData> filterDataList,
      {String? query}) async {
    var completer = Completer<void>();

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
    for (final f in filters) {
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

      Util.printTimeStamp(query);

      //クエリ分析
      var analyzer = AnalyzeQueryUseCase();
      var conditions = analyzer.call(query);

      //クエリ実行
      List<CardInfoHeader> results =
          await _repository.get(conditions, locale, onProgress: (value) {});
      _searchResult = SearchResult(cards: results, isSuccess: true);

      List<CardInfoHeader> newCardList = [];
      for (final card in _searchResult.cards) {
        List<CardInfo> faces = [];
        for (final face in card.cardFaces) {
          faces.add(face.copyWith(webImageController: WebImageController()));
        }

        newCardList.add(card.copyWith(cardFaces: faces));
      }

      _searchResult.cards = newCardList;

      //ソート
      sortSearchResults(locale);
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print(e);
        print(stackTrace);
      }
      throw MIGException(100);
    }
  }
}
