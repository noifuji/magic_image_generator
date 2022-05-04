

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../model/card_info.dart';
import '../model/card_info_header.dart';

class CanvasViewModel extends ChangeNotifier {
  List<List<CardInfoHeader>> _selectedCards = [];
  List<List<CardInfoHeader>> get selectedCards => _selectedCards;

  void setSelectedCards(List<List<CardInfoHeader>> cards) {
    _selectedCards = cards;
    notifyListeners();
  }

  void addSelectedCards(int rowIndex, CardInfoHeader card) {
    if(rowIndex > _selectedCards.length) {
      throw Exception();
    }

    if(rowIndex == _selectedCards.length ) {
      _selectedCards.add([card]);
    } else {
      _selectedCards[rowIndex].add(card);
    }

    notifyListeners();
  }

  void flip(CardInfoHeader card) {
    int rowIndex = selectedCards.indexWhere((row) => row.where((card) => card.displayId == card.displayId).toList().isNotEmpty);
    int colIndex = selectedCards[rowIndex].indexWhere((card) => card.displayId == card.displayId);

    _selectedCards[rowIndex][colIndex].isFront = !_selectedCards[rowIndex][colIndex].isFront;
    notifyListeners();
  }


  void removeCard(int row, int col) {
    _selectedCards[row].removeAt(col);

    _selectedCards = _selectedCards
        .where((element) => element.isNotEmpty)
        .toList();

    notifyListeners();
  }


  void moveCard(Map<String, int> from, Map<String, int> to) {

    List<List<CardInfoHeader>> copy = _selectedCards.map((row) => <CardInfoHeader>[]).toList();

    if(!from.containsKey("row") || !from.containsKey("col")) {
      throw Exception();
    }

    if(!to.containsKey("row") || !to.containsKey("col")) {
      throw Exception();
    }

    int fromRow = from["row"]!;
    int fromCol = from["col"]!;
    int toRow = to["row"]!;
    int toCol = to["col"]!;


    if (fromCol < 0 ||
        toCol < 0 ||
        fromRow < 0 ||
        toRow < 0 ||
        fromRow >= _selectedCards.length ||
        toRow > _selectedCards.length ||
        fromCol >= _selectedCards[fromRow].length) {
      return;
    }

    if (fromCol == toCol && fromRow == toRow) {
      return;
    }

    //同じ行の場合
    if (fromRow == toRow) {
      int row = fromRow;

      if (fromCol > toCol) {
        //右から左へ
        copy[row].addAll(_selectedCards[row].sublist(0, toCol));
        copy[row].add(_selectedCards[row][fromCol]);
        copy[row].addAll(_selectedCards[row].sublist(toCol, fromCol));
        copy[row].addAll(_selectedCards[row].sublist(fromCol + 1));
      } else {
        //左から右へ
        copy[row].insertAll(0, _selectedCards[row].sublist(toCol + 1));
        copy[row].insert(0, _selectedCards[row][fromCol]);
        copy[row].insertAll(0, _selectedCards[row].sublist(fromCol + 1, toCol + 1));
        copy[row].insertAll(0, _selectedCards[row].sublist(0, fromCol));
      }


    } else if(toRow == _selectedCards.length) {
      copy.add([]);
      copy[toRow].add(_selectedCards[fromRow][fromCol]);

      copy[fromRow].addAll(_selectedCards[fromRow].sublist(0, fromCol));
      copy[fromRow].addAll(_selectedCards[fromRow].sublist(fromCol + 1));

    } else {
      copy[toRow].addAll(_selectedCards[toRow].sublist(0, toCol));
      copy[toRow].add(_selectedCards[fromRow][fromCol]);
      copy[toRow].addAll(_selectedCards[toRow].sublist(toCol));

      copy[fromRow].addAll(_selectedCards[fromRow].sublist(0, fromCol));
      copy[fromRow].addAll(_selectedCards[fromRow].sublist(fromCol + 1));


    }

    for (var i = 0; i < _selectedCards.length; i++) {
      if (i != fromRow && i != toRow) {
        copy[i].addAll(_selectedCards[i]);
      }
    }

    _selectedCards = copy;
    removeEmptyRow();
    notifyListeners();
  }

  void removeEmptyRow() {
    _selectedCards = _selectedCards
        .where((element) => element.isNotEmpty)
        .toList();
  }
}