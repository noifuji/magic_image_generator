import 'package:flutter/material.dart';

import '../assets/search_filter.dart';
import '../assets/constants.dart' as constants;

class AnalyzeFilterUseCase {


  String call(Map<SearchFilter, bool> filterState, Locale locale) {
    List<String> query = [];

    query.add(_createQueryFromFilter(filterState,locale,
        constants.seachFilterKeywordMap.keys.toList().where((x) => constants.seachFilterKeywordMap[x]=="c").toList()));

    query.add(_createQueryFromFilter(filterState, locale,
        constants.seachFilterKeywordMap.keys.toList().where((x) => constants.seachFilterKeywordMap[x]=="r").toList()));

    query.add(_createQueryFromFilter(filterState, locale,
        constants.seachFilterKeywordMap.keys.toList().where((x) => constants.seachFilterKeywordMap[x]=="t").toList()));

    query.add(_createQueryFromFilter(filterState, locale,
        constants.seachFilterKeywordMap.keys.toList().where((x) => constants.seachFilterKeywordMap[x]=="cmc").toList()));

    query.add(_createQueryFromFilter(filterState, locale,
        constants.seachFilterKeywordMap.keys.toList().where((x) => constants.seachFilterKeywordMap[x]=="set").toList()));

    String result = "";

    for(var i = 0; i < query.length; i++) {
      if(query[i] == "") {
        continue;
      }
      result = result + " " + query[i];

    }

    if(result != "") {
      result = "(" + result + ")";
    }

    return result;
  }

  String _createQueryFromFilter(Map<SearchFilter, bool> filterState, Locale locale, List<SearchFilter> filters) {
    List<String> query = [];
    Map<SearchFilter, String> valueMap;

    if(locale.languageCode == constants.languageCodeJa) {
      valueMap = constants.searchFilterValueMapJa;
    } else {
      valueMap = constants.searchFilterValueMap;
    }

    for(var key in filters) {
      if(filterState[key]!) {
        if(key == SearchFilter.manaValue7AndMore) {
          query.add(constants.seachFilterKeywordMap[key]! + ">=" + valueMap[key]!);
        } else if(["set", "cmc", "r"].contains(constants.seachFilterKeywordMap[key]!)) {
          query.add(constants.seachFilterKeywordMap[key]! + "=" + valueMap[key]!);
        }else {
          query.add(constants.seachFilterKeywordMap[key]! + ":" + valueMap[key]!);
        }
      }
    }

    if(query.isEmpty) {
      return "";
    }

    String operator = "or";
    //色条件はorだが、多色がtrueの場合は、andとする。
    //白、青の場合は、白または青を含むものをフィルタするが、白、青、多色の場合は白かつ青を含むものをフィルタする。
    if(filterState[SearchFilter.colorMulti]! && constants.seachFilterKeywordMap[filters[0]] == "c") {
      operator = "and";
    }

    String strQuery = "(";
    for(var i = 0; i < query.length; i++) {
      strQuery = strQuery + query[i] + " ";

      if(i < query.length -1) {
        strQuery = strQuery + operator + " ";
      }
    }
    strQuery = strQuery + ")";

    return strQuery;
  }
}