import 'package:flutter/material.dart';
import 'package:magic_image_generator/features/search/domain/entity/card_info.dart';

class CardInfoHeader {
  final String displayId;
  final List<CardInfo> cardFaces;
  final bool isTransform;
  final bool isFront;
  final Size imageSize;
  final double rotationAngle;

  CardInfo get firstFace => cardFaces.first;
  CardInfo? get secondFace => cardFaces[1];

  CardInfoHeader(
      {required this.displayId,
      required this.cardFaces,
      required this.isTransform,
      required this.isFront,
      required this.imageSize,
      required this.rotationAngle});

  CardInfoHeader copyWith(
          {String? displayId,
          List<CardInfo>? cardFaces,
          bool? isTransform,
          bool? isFront,
          Size? imageSize,
          double? rotationAngle}) =>
      CardInfoHeader(
          displayId: displayId ?? this.displayId,
          cardFaces: cardFaces ?? this.cardFaces,
          isTransform: isTransform ?? this.isTransform,
          isFront: isFront ?? this.isFront,
          imageSize: imageSize ?? this.imageSize,
          rotationAngle: rotationAngle ?? this.rotationAngle);
}
