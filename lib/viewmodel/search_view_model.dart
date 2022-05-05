

import 'package:flutter/cupertino.dart';
import 'package:magic_image_generator/domain/card_repository.dart';

import '../domain/analyze_query_usecase.dart';
import '../model/card_info.dart';
import '../model/card_info_header.dart';

class SearchViewModel extends ChangeNotifier {
  final CardRepository _repository;


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
    //リザルトを更新
    notifyListeners();
  }
}