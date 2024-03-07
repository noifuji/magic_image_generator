import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:magic_image_generator/view/widgets/web_image.dart';

class CardInfo {
  final String multiverseId;
  final String name;
  final String nameJpYomi;
  final String imageUrl;
  final String imageUrlJp;
  final String layout;
  final int cmc;
  final bool isFront;
  final ui.Image? image;
  final WebImageController? webImageController;

  String imageUrlLocale(Locale locale) {
    if (locale.languageCode == "en") {
      return imageUrl;
    } else if (locale.languageCode == "ja") {
      return imageUrlJp;
    } else {
      throw Exception();
    }
  }

  CardInfo(
      {required this.multiverseId,
      required this.name,
      required this.nameJpYomi,
      required this.imageUrl,
      required this.imageUrlJp,
      required this.layout,
      required this.cmc,
      required this.isFront,
      this.webImageController,
      this.image});

  CardInfo copyWith({
    String? multiverseId,
    String? name,
    String? nameJpYomi,
    String? imageUrl,
    String? imageUrlJp,
    String? layout,
    int? cmc,
    bool? isFront,
    ui.Image? image,
    WebImageController? webImageController,
  }) =>
      CardInfo(
        multiverseId: multiverseId ?? this.multiverseId,
        name: name ?? this.name,
        nameJpYomi: nameJpYomi ?? this.nameJpYomi,
        imageUrl: imageUrl ?? this.imageUrl,
        imageUrlJp: imageUrlJp ?? this.imageUrlJp,
        layout: layout ?? this.layout,
        cmc: cmc ?? this.cmc,
        isFront: isFront ?? this.isFront,
        image: image ?? this.image,
        webImageController: webImageController ?? this.webImageController,
      );
}
