import 'package:magic_image_generator/domain/search/color_type.dart';
import 'package:magic_image_generator/domain/search/rarity_type.dart';
import 'package:magic_image_generator/domain/search/relational_operator_type.dart';
import 'package:magic_image_generator/domain/search/search_condition.dart';
import 'package:magic_image_generator/domain/search/search_keyword_type.dart';

class SearchConditionMapper {
  static final Map<String, RelationalOperatorType> relationalOperatorMap = {
    ":" : RelationalOperatorType.contains,
    "=":RelationalOperatorType.equals,
    "<":RelationalOperatorType.lessThan,
    ">":RelationalOperatorType.greaterThan,
    "<=":RelationalOperatorType.lessThanOrEquals,
    ">=":RelationalOperatorType.greaterThanOrEquals};

  static final Map<String, SearchKeywordType> keywordMap = {
    "legal" : SearchKeywordType.legal,
    "set" : SearchKeywordType.set,
    "r" : SearchKeywordType.rarity,
    "rarity" : SearchKeywordType.rarity,
    "c" : SearchKeywordType.color,
    "color" : SearchKeywordType.color,
    "t" : SearchKeywordType.type,
    "type" : SearchKeywordType.type,
    "cmc" : SearchKeywordType.cmc,
    "pow" : SearchKeywordType.power,
    "power" : SearchKeywordType.power,
    "tou" : SearchKeywordType.toughness,
    "toughness" : SearchKeywordType.toughness,
    "o" : SearchKeywordType.oracle,
    "oracle" : SearchKeywordType.oracle,
    "name" : SearchKeywordType.name};

  static final Map<String, ColorType> colorMap = {
    "w" : ColorType.white,
    "u" : ColorType.blue,
    "b" : ColorType.black,
    "r" : ColorType.red,
    "g" : ColorType.green,
    "white" : ColorType.white,
    "blue" : ColorType.blue,
    "black" : ColorType.black,
    "red" : ColorType.red,
    "green" : ColorType.green,
    "multicolor" : ColorType.multiColor,
    "multi" : ColorType.multiColor,
    "m" : ColorType.multiColor,
    "colorless" : ColorType.colorless,
    "wu" : ColorType.wu,
    "azorius" : ColorType.wu,
    "ub" : ColorType.ub,
    "dimir" : ColorType.ub,
    "br" : ColorType.br,
    "rakdos" : ColorType.br,
    "rg" : ColorType.rg,
    "gruul" : ColorType.rg,
    "wg" : ColorType.gw,
    "selesnya" : ColorType.gw,
    "wb" : ColorType.wb,
    "orzhov" : ColorType.wb,
    "bg" : ColorType.bg,
    "golgari" : ColorType.bg,
    "gu" : ColorType.gu,
    "simic" : ColorType.gu,
    "ur" : ColorType.ur,
    "izzet" : ColorType.ur,
    "wr" : ColorType.wr,
    "boros" : ColorType.wr,
    "wur" : ColorType.wur,
    "jeskai" : ColorType.wur,
    "ubg" : ColorType.ubg,
    "sultai" : ColorType.ubg,
    "brw": ColorType.brw,
    "mardu" : ColorType.brw,
    "rgu": ColorType.rgu,
    "temur" : ColorType.rgu,
    "wbg": ColorType.wbg,
    "abzan" : ColorType.wbg,
    "wub": ColorType.wub,
    "esper" : ColorType.wub,
    "ubr": ColorType.ubr,
    "grixis" : ColorType.ubr,
    "brg": ColorType.brg,
    "jund" : ColorType.brg,
    "rgw": ColorType.rgw,
    "naya" : ColorType.rgw,
    "gwu": ColorType.gwu,
    "bant" : ColorType.gwu,
    "ubrg": ColorType.noWhite,
    "wbrg": ColorType.noBlue,
    "wurg": ColorType.noBlack,
    "wubg": ColorType.noRed,
    "wubr": ColorType.noGreen,
    "wubrg" : ColorType.fiveColors,
  };

  static final Map<String, RarityType> rarityMap = {
    "c":RarityType.common ,
    "common":RarityType.common ,
    "u":RarityType.uncommon,
    "uncommon":RarityType.uncommon,
    "r":RarityType.rare ,
    "rare":RarityType.rare ,
    "m":RarityType.mythic,
    "mythic":RarityType.mythic,
  };


  static SearchCondition map(List<String> raw) {
    if(!isMappable(raw)) {
      throw Exception();
    }

    SearchKeywordType keyword;
    RelationalOperatorType relationalOperatorType;
    dynamic value;

    keyword = keywordMap[raw[0]]!;

    if(keyword == SearchKeywordType.color) {
      //色チェック
      if(colorMap[raw.last.toLowerCase()] != null) {
        value = colorMap[raw.last];
      } else if(isColorLetterOnly(raw.last.toLowerCase()) && raw.last.length <= 5) {
        var colors = colorMap.keys.toList();

        for(var i = 0; i < raw.last.length; i++) {
          colors = colors.where((element) => element.contains(raw.last[i])).toList();
        }

        print(colors);
        if(colors.isEmpty) {
          throw Exception();
        }

        value = colorMap[colors.firstWhere((element) => element.length == raw.last.length)];

      } else {
        throw Exception();
      }
    } else if(keyword == SearchKeywordType.rarity) {
      if(rarityMap.keys.contains(raw.last.toLowerCase())) {
        value = rarityMap[raw.last];
      } else {
        throw Exception();
      }
    } else {
      value = raw.last;
    }


    relationalOperatorType = relationalOperatorMap[raw.sublist(1,raw.length-1).join()]!;

    return SearchCondition(
        keyword: keyword,
        relationalOperatorType: relationalOperatorType,
        value: value);
  }

  static bool isMappable(List<String> raw) {
    if(raw.length < 3) {
      return false;
    }
    if(!keywordMap.keys.toList().contains(raw[0])) {
      return false;
    }
    if(!relationalOperatorMap.keys.toList().contains(raw.sublist(1,raw.length-1).join())) {
      return false;
    }
    return true;
  }

  static bool isColorLetterOnly(String str) {
    bool isColorLetter = true;
    for(var i = 0; i < str.length; i++) {
      isColorLetter = isColorLetter && ["w","u","b","r","g"].contains(str[i]);
    }

    return isColorLetter;
  }
}