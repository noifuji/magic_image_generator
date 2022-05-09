

import 'package:flutter/cupertino.dart';
import 'package:magic_image_generator/domain/card_repository.dart';
import 'package:magic_image_generator/view/sort_drop_down.dart';

import '../domain/analyze_query_usecase.dart';
import '../model/card_info.dart';
import '../model/card_info_header.dart';

class SearchViewModel extends ChangeNotifier {
  final CardRepository _repository;
  SortKey _sortKey = SortKey.cmc;
  SortOrder _order = SortOrder.asc;


  SortKey get sortKey => _sortKey;
  SortOrder get order => _order;
  List<CardInfoHeader> _searchResults = [];

  List<CardInfoHeader> get searchResults => _searchResults;


  SearchViewModel(this._repository);

  void flip(CardInfoHeader card) {
    int index = _searchResults.indexWhere((element) => element.displayId == card.displayId);
    _searchResults[index].isFront = !_searchResults[index].isFront;
    notifyListeners();
  }

  Future<void> search(String query, Locale locale) async {
    //クエリの分析
    var analyzer = AnalyzeQueryUseCase();
    var conditions = analyzer.call(query);

    //リポジトリから結果の取り出し
    _searchResults = await _repository.get(conditions, locale);
    sortSearchResults();

    //リザルトを更新
    notifyListeners();
  }

  void setSortKey(SortKey sortKey) {
    _sortKey = sortKey;
    sortSearchResults();
  }

  void setSortOrder(SortOrder order) {
    _order = order;
    sortSearchResults();
  }

  void sortSearchResults() {
    if(_sortKey == SortKey.cmc) {
      searchResults.sort((a, b) => a.cardFaces[0].cmc.compareTo(b.cardFaces[0].cmc) * (_order == SortOrder.asc? 1: -1));
      notifyListeners();
    } else if(_sortKey == SortKey.name) {
      searchResults.sort((a, b) => a.cardFaces[0].name.compareTo(b.cardFaces[0].name) * (_order == SortOrder.asc? 1: -1));
      notifyListeners();
    }
  }
}