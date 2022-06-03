import 'package:flutter/material.dart';
import 'package:magic_image_generator/domain/search_query_symbol.dart';

import '../viewmodel/search_view_model.dart';

class AnalyzeFilterUseCase {
  final Map<SearchFilter, String> seachFilterKeywordMap = {
    SearchFilter.colorWhite: "c",
    SearchFilter.colorBlue: "c",
    SearchFilter.colorBlack: "c",
    SearchFilter.colorRed: "c",
    SearchFilter.colorGreen: "c",
    SearchFilter.colorColorless: "c",
    SearchFilter.colorMulti: "c",
    SearchFilter.rarityCommon: "r",
    SearchFilter.rarityUncommon: "r",
    SearchFilter.rarityRare: "r",
    SearchFilter.rarityMythic: "r",
    SearchFilter.typeCreature: "t",
    SearchFilter.typePlaneswalker: "t",
    SearchFilter.typeInstant: "t",
    SearchFilter.typeSorcery: "t",
    SearchFilter.typeEnchantment: "t",
    SearchFilter.typeArtifact: "t",
    SearchFilter.typeLand: "t",
    SearchFilter.manaValue0: "cmc",
    SearchFilter.manaValue1: "cmc",
    SearchFilter.manaValue2: "cmc",
    SearchFilter.manaValue3: "cmc",
    SearchFilter.manaValue4: "cmc",
    SearchFilter.manaValue5: "cmc",
    SearchFilter.manaValue6: "cmc",
    SearchFilter.manaValue7AndMore: "cmc",
    SearchFilter.setSnc: "set",
    SearchFilter.setNeo: "set",
    SearchFilter.setVow: "set",
    SearchFilter.setMid: "set",
    SearchFilter.setAfr: "set",
    SearchFilter.setStx: "set",
    SearchFilter.setKhm: "set",
    SearchFilter.setZnr: "set"
  };

  final Map<SearchFilter, String> seachFilterValueMap = {
    SearchFilter.colorWhite: "w",
    SearchFilter.colorBlue: "u",
    SearchFilter.colorBlack: "b",
    SearchFilter.colorRed: "r",
    SearchFilter.colorGreen: "g",
    SearchFilter.colorColorless: "colorless",
    SearchFilter.colorMulti: "m",
    SearchFilter.rarityCommon: "c",
    SearchFilter.rarityUncommon: "u",
    SearchFilter.rarityRare: "r",
    SearchFilter.rarityMythic: "m",
    SearchFilter.typeCreature: "creature",
    SearchFilter.typePlaneswalker: "planeswalker",
    SearchFilter.typeInstant: "instant",
    SearchFilter.typeSorcery: "sorcery",
    SearchFilter.typeEnchantment: "enchantment",
    SearchFilter.typeArtifact: "artifact",
    SearchFilter.typeLand: "land",
    SearchFilter.manaValue0: "0",
    SearchFilter.manaValue1: "1",
    SearchFilter.manaValue2: "2",
    SearchFilter.manaValue3: "3",
    SearchFilter.manaValue4: "4",
    SearchFilter.manaValue5: "5",
    SearchFilter.manaValue6: "6",
    SearchFilter.manaValue7AndMore: "7",
    SearchFilter.setSnc: "snc",
    SearchFilter.setNeo: "neo",
    SearchFilter.setVow: "vow",
    SearchFilter.setMid: "mid",
    SearchFilter.setAfr: "afr",
    SearchFilter.setStx: "stx",
    SearchFilter.setKhm: "khm",
    SearchFilter.setZnr: "znr"
  };

  final Map<SearchFilter, String> seachFilterValueMapJa = {
    SearchFilter.colorWhite: "w",
    SearchFilter.colorBlue: "u",
    SearchFilter.colorBlack: "b",
    SearchFilter.colorRed: "r",
    SearchFilter.colorGreen: "g",
    SearchFilter.colorColorless: "colorless",
    SearchFilter.colorMulti: "m",
    SearchFilter.rarityCommon: "c",
    SearchFilter.rarityUncommon: "u",
    SearchFilter.rarityRare: "r",
    SearchFilter.rarityMythic: "m",
    SearchFilter.typeCreature: "クリーチャー",
    SearchFilter.typePlaneswalker: "プレインズウォーカー",
    SearchFilter.typeInstant: "インスタント",
    SearchFilter.typeSorcery: "ソーサリー",
    SearchFilter.typeEnchantment: "エンチャント",
    SearchFilter.typeArtifact: "アーティファクト",
    SearchFilter.typeLand: "土地",
    SearchFilter.manaValue0: "0",
    SearchFilter.manaValue1: "1",
    SearchFilter.manaValue2: "2",
    SearchFilter.manaValue3: "3",
    SearchFilter.manaValue4: "4",
    SearchFilter.manaValue5: "5",
    SearchFilter.manaValue6: "6",
    SearchFilter.manaValue7AndMore: "7",
    SearchFilter.setSnc: "snc",
    SearchFilter.setNeo: "neo",
    SearchFilter.setVow: "vow",
    SearchFilter.setMid: "mid",
    SearchFilter.setAfr: "afr",
    SearchFilter.setStx: "stx",
    SearchFilter.setKhm: "khm",
    SearchFilter.setZnr: "znr"
  };

  String call(Map<SearchFilter, bool> filterState, Locale locale) {
    List<String> query = [];
    query.add(_createQueryFromFilter(filterState,locale, [
      SearchFilter.colorWhite,SearchFilter.colorBlue, SearchFilter.colorBlack,
      SearchFilter.colorRed, SearchFilter.colorGreen, SearchFilter.colorColorless,
    ]));

    query.add(_createQueryFromFilter(filterState,locale, [
      SearchFilter.colorMulti
    ]));

    query.add(_createQueryFromFilter(filterState, locale,[
      SearchFilter.rarityCommon,
      SearchFilter.rarityUncommon,
      SearchFilter.rarityRare,
      SearchFilter.rarityMythic
    ]));

    query.add(_createQueryFromFilter(filterState, locale,[
      SearchFilter.typeCreature,
      SearchFilter.typePlaneswalker,
      SearchFilter.typeInstant,
      SearchFilter.typeSorcery,
      SearchFilter.typeEnchantment,
      SearchFilter.typeArtifact,
      SearchFilter.typeLand
    ]));

    query.add(_createQueryFromFilter(filterState, locale,[
      SearchFilter.manaValue0,
      SearchFilter.manaValue1,
      SearchFilter.manaValue2,
      SearchFilter.manaValue3,
      SearchFilter.manaValue4,
      SearchFilter.manaValue5,
      SearchFilter.manaValue6,
      SearchFilter.manaValue7AndMore
    ]));

    query.add(_createQueryFromFilter(filterState, locale,[
      SearchFilter.setSnc,
      SearchFilter.setNeo,
      SearchFilter.setVow,
      SearchFilter.setMid,
      SearchFilter.setAfr,
      SearchFilter.setStx,
      SearchFilter.setKhm,
      SearchFilter.setZnr
    ]));

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

    if(locale.languageCode == "ja") {
      valueMap = seachFilterValueMapJa;
    } else {
      valueMap = seachFilterValueMap;
    }

    for(var key in filters) {
      if(filterState[key]!) {
        if(key == SearchFilter.manaValue7AndMore) {
          query.add(seachFilterKeywordMap[key]! + ">=" + valueMap[key]!);
        } else {
          query.add(seachFilterKeywordMap[key]! + ":" + valueMap[key]!);
        }
      }
    }

    if(query.isEmpty) {
      return "";
    }

    String operator = "or";
    if(filterState[SearchFilter.colorMulti]! && filters.contains(SearchFilter.colorWhite)) {
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