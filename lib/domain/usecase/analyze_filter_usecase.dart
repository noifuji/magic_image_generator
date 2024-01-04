import '../../common/search_filter.dart';
import '../../common/search_filter_factory.dart';

class AnalyzeFilterUseCase {
  String call(Map<SearchFilter, bool> filterState,
      List<SearchFilterData> filterDataList) {
    List<String> query = [];

    query.add(_createQueryFromFilter(
        filterState,
        filterDataList
            .where((e) => e.filterType == SearchFilterType.color)
            .toList()));

    query.add(_createQueryFromFilter(
        filterState,
        filterDataList
            .where((e) => e.filterType == SearchFilterType.rarity)
            .toList()));

    query.add(_createQueryFromFilter(
        filterState,
        filterDataList
            .where((e) => e.filterType == SearchFilterType.type)
            .toList()));

    query.add(_createQueryFromFilter(
        filterState,
        filterDataList
            .where((e) => e.filterType == SearchFilterType.cmc)
            .toList()));

    query.add(_createQueryFromFilter(
        filterState,
        filterDataList
            .where((e) => e.filterType == SearchFilterType.set)
            .toList()));

    String result = "";

    for (var i = 0; i < query.length; i++) {
      if (query[i] == "") {
        continue;
      }
      result = "$result ${query[i]}";
    }

    if (result != "") {
      result = "($result)";
    }

    return result;
  }

  String _createQueryFromFilter(Map<SearchFilter, bool> filterState,
      List<SearchFilterData> filterDataList) {
    List<String> query = [];

    for (var filterData in filterDataList) {
      if (filterState[filterData.filter]!) {
        String relationalOperator = ":";
        if (filterData.filter == SearchFilter.manaValue7AndMore) {
          relationalOperator = ">=";
        } else if (["set", "cmc", "r"].contains(filterData.searchKey)) {
          relationalOperator = "=";
        }
        query.add(
            filterData.searchKey + relationalOperator + filterData.searchValue);
      }
    }

    if (query.isEmpty) {
      return "";
    }

    String operator = "or";
    //色条件はorだが、多色がtrueの場合は、andとする。
    //白、青の場合は、白または青を含むものをフィルタするが、白、青、多色の場合は白かつ青を含むものをフィルタする。
    if (filterState[SearchFilter.colorMulti]! &&
        filterDataList[0].searchKey == "c") {
      operator = "and";
    }

    String strQuery = "(";
    for (var i = 0; i < query.length; i++) {
      strQuery = "$strQuery${query[i]} ";

      if (i < query.length - 1) {
        strQuery = "$strQuery$operator ";
      }
    }
    strQuery = "$strQuery)";

    return strQuery;
  }
}
