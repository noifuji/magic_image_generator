import 'package:uuid/uuid.dart';

import 'card_info.dart';

class CardInfoHeader {
  String displayId = const Uuid().v1();
  late bool isTransform;
  List<CardInfo> cardFaces = [];
  bool isFront = true;

  CardInfo get firstFace => cardFaces.first;
  CardInfo? get secondFace => cardFaces[1];

  CardInfoHeader(CardInfo card) {
    isTransform = (card.layout == "transform" || card.layout == "modal_dfc");
    cardFaces.add(card);
  }

  CardInfoHeader copyWith() {
    var cih = CardInfoHeader(cardFaces.first);
    if(cih.isTransform) {
      cih.cardFaces.addAll(cardFaces.sublist(1));
    }

    return cih;
  }
}