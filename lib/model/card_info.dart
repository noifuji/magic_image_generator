import 'dart:ui';

class CardInfo{
  late String multiverseId;
  late String name;
  late String _imageUrl;
  late String _imageUrlJp;
  late bool isTransform;
  CardInfo? backFace;


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
    required this.isTransform
  }) {
    _imageUrl = imageUrl;
    _imageUrlJp = imageUrlJp;
  }
}