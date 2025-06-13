import 'package:magic_image_generator/features/search/domain/entity/search_condition.dart';
import 'package:magic_image_generator/features/search/domain/mapper/search_condition_mapper.dart';
import 'package:magic_image_generator/features/search/domain/entity/search_operator.dart';
import 'package:magic_image_generator/features/search/domain/enum/search_operator_type.dart';
import 'package:magic_image_generator/features/search/domain/entity/search_query_symbol.dart';

class AnalyzeQueryUseCase {
  List<SearchQuerySymbol> call(String query) {
    List<String> split = pLex(replaceDoubleBytesSpace(query));
    List<String> doubleQuoteChecked = checkDoubleQuote(split);
    List<String> operatorsChecked = checkOperators(doubleQuoteChecked);
    List<List<String>> symbolStringArray = checkSpace(operatorsChecked);
    List<SearchQuerySymbol> symbolArray = convertToPolishNotation(
        complementAnd(convertToSearchQuerySymbol(symbolStringArray)));

    int conditionCount =
        symbolArray.fold<int>(0, (p, e) => p + (e is SearchCondition ? 1 : 0));
    if (conditionCount == 0) {
      throw Exception();
    }

    return symbolArray;
  }

  String replaceDoubleBytesSpace(String str) {
    return str.replaceAll("　", " ");
  }

  List<String> pLex(String str) {
    RegExp regExp = RegExp(r'[:()<>=\-\\"\s]');
    str = str.replaceAllMapped(regExp, (m) => '@${m[0]}@');
    return str.split(RegExp(r"[@]")).where((x) => x != "").toList();
  }

/*
 * "で囲まれる範囲は1つの配列の要素とする。
 * 1,1文字ずつチェックする。
 * 2,"をみつけたら、もう1文字を発見するまですべての要素を結合する。
 * 3,もうひとつの"をみつけたら、1に戻る。
 *
 * ()で囲まれる範囲は1つのまとまりとする
 * スペースで1つの表現が終わるものとする。
 *
 * ""で囲まれる領域をマージする。
 * ()で囲まれる領域をリスト化する。
 * 各リスト内でスペースで区切っていく
 *
 */
  List<String> checkDoubleQuote(List<String> p) {
    //validate
    int countDoubleQuote = p.fold<int>(
        0,
        (previousValue, element) =>
            previousValue = previousValue + (element == '"' ? 1 : 0));
    if (countDoubleQuote.isOdd) {
      throw Exception("Format Error");
    }

    List<String> r = [];
    while (p.isNotEmpty) {
      String t = p.first;
      p.removeAt(0);

      if (t == '"') {
        var quotedString = "";
        while (p.isNotEmpty) {
          var s = p.first;
          p.removeAt(0);

          if (s == '"') {
            r.add(quotedString);
            break;
          } else {
            quotedString = quotedString + s;
          }
        }
      } else {
        r.add(t);
      }
    }

    return r;
  }

  List<String> checkOperators(List<String> p) {
    int countOpenBracket = p.fold<int>(
        0,
        (previousValue, element) =>
            previousValue = previousValue + (element == '(' ? 1 : 0));
    int countCloseBracket = p.fold<int>(
        0,
        (previousValue, element) =>
            previousValue = previousValue + (element == ')' ? 1 : 0));
    if (countOpenBracket != countCloseBracket) {
      throw Exception("Format Error");
    }

    List<String> symbol = SearchOperator.searchOperatorMap.keys.toList();
    List<String> r = [];

    while (p.isNotEmpty) {
      String t = p.first;
      p.removeAt(0);
      if (symbol.contains(t)) {
        if (r.isNotEmpty && r.last != " ") {
          r.add(" ");
        }

        r.add(t);

        if (p.isNotEmpty && p.first != " ") {
          r.add(" ");
        }
      } else {
        r.add(t);
      }
    }

    return r;
  }

  List<List<String>> checkSpace(List<String> p) {
    List<List<String>> r = [];

    List<String> tmp = [];
    while (p.isNotEmpty) {
      var t = p.first;
      p.removeAt(0);
      if (t == " ") {
        //空白区切り
        if (tmp.isEmpty) {
          continue;
        }

        r.add(tmp);
        tmp = [];
      } else if (p.isEmpty) {
        //配列のおわり
        tmp.add(t);
        r.add(tmp);
        tmp = [];
      } else {
        tmp.add(t);
      }
    }

    return r;
  }

  /*
 *
 * 数式文字列をトークン分割（配列化）
配列の先頭から順次読み込んで判定（ループ処理）
a. 数値の場合
=> そのまま、出力
b. 括弧・開き ( の場合
=> そのまま、スタックへ push
c. 括弧・閉じ ) の場合
=> ( が出るまでスタックから pop して出力
但し、 (, ) は廃棄
d. その他（演算子）の場合
=> そのまま、スタックへ push
但し、スタックトップの演算子の方が優先度が高ければ、それを pop して出力
（※演算子・括弧の優先度： * = / > + = - > ( = )）

*/
/*
 * A and ((B and C) or D) and E
 * A B C and D or E and and
 *
 *
 * */

  List<SearchQuerySymbol> convertToPolishNotation(List<SearchQuerySymbol> e) {
    List<SearchQuerySymbol> result = [];
    List<SearchQuerySymbol> stack = [];

    for (var i = 0; i < e.length; i++) {
      var t = e[i];

      if (t is SearchOperator &&
          [
            SearchOperatorType.and,
            SearchOperatorType.or,
            SearchOperatorType.not
          ].contains(t.searchOperatorType)) {
        if (stack.isEmpty) {
          stack.add(t);
          continue;
        }

        var stackLast = stack.last;
        if (stackLast is SearchOperator && stackLast.priority > t.priority) {
          result.add(stackLast);
          stack.removeLast();
        } else {
          stack.add(t);
        }
      } else if (t is SearchOperator &&
          t.searchOperatorType == SearchOperatorType.openedBracket) {
        stack.add(t);
      } else if (t is SearchOperator &&
          t.searchOperatorType == SearchOperatorType.closedBracket) {
        var stackLast = stack.last;
        while (!(stackLast is SearchOperator &&
            stackLast.searchOperatorType == SearchOperatorType.openedBracket)) {
          result.add(stack.last);
          stack.removeLast();
          stackLast = stack.last;
        }

        stack.removeLast();
      } else {
        result.add(t);
      }
    }

    for (var i = stack.length - 1; i >= 0; i--) {
      result.add(stack[i]);
    }

    return result;
  }

  /*
 * 数値　数値 　　補完
 * 数値　(　　　　補完
 * 数値 )　　　　スルー
 * 数値　and or　　スルー
 * 数値　-　　　　補完
 * ( (　　　　　　スルー
 * ( 数値　　　　　スルー
 * ( )　　　　　　エラー
 * ( 演算子　　　スルー
 * ) )　　　　　　スルー
 * ) 数値　　　　補完
 * ) (　　　　　補完
 * ) 演算子　　　　スルー
 * 演算子　演算子　スルー
 * 演算子　数値　スルー
 * 演算子　(　　　スルー
 * 演算子　)　　　エラー
 *
 * */
  List<SearchQuerySymbol> complementAnd(List<SearchQuerySymbol> p) {
    List<SearchQuerySymbol> r = [];

    while (p.length > 1) {
      var t = p.first;
      p.removeAt(0);

      var first = t;
      var second = p.first;

      if ((first is SearchCondition && second is SearchCondition) ||
          (first is SearchCondition &&
              second is SearchOperator &&
              second.searchOperatorType == SearchOperatorType.openedBracket) ||
          (first is SearchOperator &&
              first.searchOperatorType == SearchOperatorType.closedBracket &&
              second is SearchCondition) ||
          (first is SearchOperator &&
              first.searchOperatorType == SearchOperatorType.closedBracket &&
              second is SearchOperator &&
              second.searchOperatorType == SearchOperatorType.openedBracket) ||
          (first is SearchCondition &&
              second is SearchOperator &&
              second.searchOperatorType == SearchOperatorType.not)) {
        r.add(t);
        r.add(SearchOperator(["and"]));
      } else if ((first is SearchOperator &&
              first.searchOperatorType == SearchOperatorType.openedBracket &&
              second is SearchOperator &&
              second.searchOperatorType == SearchOperatorType.closedBracket) ||
          (first is SearchOperator &&
              [
                SearchOperatorType.and,
                SearchOperatorType.or,
                SearchOperatorType.not,
              ].contains(first.searchOperatorType) &&
              second is SearchOperator &&
              second.searchOperatorType == SearchOperatorType.closedBracket)) {
        throw Exception("Format Error");
      } else {
        r.add(t);
      }
    }

    r.add(p.first);

    return r;
  }

  List<SearchQuerySymbol> convertToSearchQuerySymbol(List<List<String>> p) {
    return p.map((e) {
      e = e.map((ele) => ele.toLowerCase()).toList();
      if (SearchOperator.isSearchOperator(e)) {
        return SearchOperator(e);
      } else if (SearchConditionMapper.isMappable(e)) {
        return SearchConditionMapper.map(e);
      } else if (e.length == 1) {
        return SearchConditionMapper.map(["name", ":", e[0]]);
      }

      throw Exception();
    }).toList();
  }
}
