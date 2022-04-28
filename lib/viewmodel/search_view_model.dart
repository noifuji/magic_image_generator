

import 'package:flutter/cupertino.dart';
import 'package:magic_image_generator/domain/card_repository.dart';

import '../domain/analyze_query_usecase.dart';
import '../model/card_info.dart';

class SearchViewModel extends ChangeNotifier {
  final CardRepository _repository;


  List<CardInfo> _searchResults = [];

  List<CardInfo> get searchResults => _searchResults;


  SearchViewModel(this._repository);

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