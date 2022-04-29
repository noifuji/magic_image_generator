

import 'package:flutter/cupertino.dart';

import '../model/card_info.dart';

class CanvasViewModel extends ChangeNotifier {

  List<List<CardInfo>> _selectedCards = [];

  List<List<CardInfo>> get selectedCards => _selectedCards;

  void setSelectedCards(List<List<CardInfo>> cards) {
    _selectedCards = cards;
    notifyListeners();
  }

  void addSelectedCards(int rowIndex, CardInfo card) {
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
}