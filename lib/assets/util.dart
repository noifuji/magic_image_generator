import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import '../model/card_info.dart';

class Util {

  /**
   * This method work only on debug mode.
   */
  static void printTimeStamp(String str) {
    if (kDebugMode) {
      DateTime now = DateTime.now();
      print('''${now.hour}:${now.minute}:${now.second}.${now.millisecond}  :$str''');
    }
  }

  static List<List<CardInfo>> rearrangeCardInfoMatrix(List<List<CardInfo>> matrix, Map from, Map to) {
    print('''positionFrom:(${from["row"]},${from["col"]}), positionTo:(${to["row"]},${to["col"]})''');

    List<List<CardInfo>> copy = [];
    if (from["col"] < 0 ||
        to["col"] < 0 ||
        from["col"] >= matrix.length ||
        to["col"] > matrix.length) {
      return matrix;
    }

    if (from["col"] == to["col"] && from["row"] == to["row"]) {
      return matrix;
    }

    //同じ行の場合
    if(from["row"] == to["row"]) {
      int row = from["row"];
      if (from["col"] > to["col"]) {
        copy[row].addAll(matrix[row].sublist(0, to["col"]));
        copy[row].add(matrix[row][from["col"]]);
        copy[row].addAll(matrix[row].sublist(to["col"], from["col"]));
        copy[row].addAll(matrix[row].sublist(from["col"] + 1));
      } else {
        copy[row].addAll(matrix[row].sublist(0, from["col"]));
        copy[row].addAll(matrix[row].sublist(from["col"] + 1, to["col"]));
        copy[row].add(matrix[row][from["col"]]);

        if (to["col"] < matrix.length) {
          copy[row].addAll(matrix[row].sublist(to["col"]));
        }
      }

      //row以外の行もコピーする。
      for(var i=0; i<matrix.length; i++) {
        if(i!=row) {
          copy[i].addAll(matrix[i]);
        }
      }

    } else {//異なる行の場合
      copy[from["row"]].addAll(matrix[from["row"]].sublist(0, from["col"]));
      copy[from["row"]].addAll(matrix[from["row"]].sublist(from["col"] + 1));

      copy[to["row"]].addAll(matrix[to["row"]].sublist(0, to["col"]));
      copy[to["row"]].add(matrix[to["row"]][from["col"]]);
      copy[to["row"]].addAll(matrix[to["row"]].sublist(to["col"]));

      for(var i=0; i<matrix.length; i++) {
        if(i!=from["row"] || i!=to["row"]) {
          copy[i].addAll(matrix[i]);
        }
      }
    }

    return copy;
  }
}