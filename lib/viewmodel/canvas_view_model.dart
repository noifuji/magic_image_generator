

import 'package:flutter/cupertino.dart';

import '../model/card_info.dart';

class CanvasViewModel extends ChangeNotifier {

  List<CardInfo> _selectedCards = [];

  List<CardInfo> get selectedCards => _selectedCards;

  void setSelectedCards(List<CardInfo> cards) {
    _selectedCards = cards;
    notifyListeners();
  }

  void addSelectedCards(CardInfo card) {
    _selectedCards.add(card);
    notifyListeners();
  }
}