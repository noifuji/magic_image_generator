import 'dart:ui';

import 'package:uuid/uuid.dart';

class CardInfo{
  late String multiverseId;
  late String name;
  late String _imageUrl;
  late String _imageUrlJp;
  late String layout;
  bool isFront = true;


  String imageUrl(Locale locale) {
    if(locale.languageCode == "en") {
      return _imageUrl;
    } else if(locale.languageCode == "ja") {
      return _imageUrlJp;
    } else {
      throw Exception();
    }
  }

  CardInfo({
    required this.multiverseId,
    required this.name,
    required String imageUrl,
    required String imageUrlJp,
    required this.layout,
  }) {
    _imageUrl = imageUrl;
    _imageUrlJp = imageUrlJp;
  }

  CardInfo copyWith() {
    CardInfo card =CardInfo(
      multiverseId: multiverseId,
      name: name,
      imageUrl: _imageUrl,
      imageUrlJp: _imageUrlJp,
      layout: layout
    );

    return card;
  }
}