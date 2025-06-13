import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';

import 'dart:ui' as ui;
import 'package:image/image.dart' as img;
import 'package:magic_image_generator/features/search/domain/entity/card_info_header.dart';

class FetchCardImagesUsecase {
  Future<List<List<CardInfoHeader>>> call(
      List<List<CardInfoHeader>> cards, Locale locale) async {
    return await Future.wait(cards
        .map((row) => Future.wait(row.map((card) async {
              if (card.isTransform) {
                if (card.isFront) {
                  ui.Image img =
                      await _fetchImage(card.firstFace.imageUrlLocale(locale));
                  ui.Image? rotated = card.rotationAngle == 0
                      ? img
                      : await rotate(img, card.rotationAngle);
                  return card.copyWith(cardFaces: [
                    card.cardFaces[0].copyWith(image: rotated),
                    card.cardFaces[1]
                  ]);
                } else {
                  ui.Image img = await _fetchImage(
                      card.secondFace!.imageUrlLocale(locale));
                  ui.Image? rotated = card.rotationAngle == 0
                      ? img
                      : await rotate(img, card.rotationAngle);
                  return card.copyWith(cardFaces: [
                    card.cardFaces[0],
                    card.cardFaces[1].copyWith(image: rotated),
                  ]);
                }
              } else {
                ui.Image img =
                    await _fetchImage(card.firstFace.imageUrlLocale(locale));
                ui.Image? rotated = card.rotationAngle == 0
                    ? img
                    : await rotate(img, card.rotationAngle);
                return card.copyWith(cardFaces: [
                  card.cardFaces[0].copyWith(image: rotated),
                ]);
              }
            }).toList()))
        .toList());
  }

  Future<ui.Image> _fetchImage(String path) async {
    var completer = Completer<ImageInfo>();
    var img = NetworkImage(path, scale: 2.0);
    img
        .resolve(const ImageConfiguration())
        .addListener(ImageStreamListener((info, _) {
      completer.complete(info);
    }));
    ImageInfo imageInfo = await completer.future;

    return imageInfo.image;
  }

  Future<ui.Image?> rotate(ui.Image image, double radian) async {
    ByteData? bytes = await image.toByteData(format: ui.ImageByteFormat.png);

    if (bytes == null) {
      return null;
    }

    ByteBuffer buffer = bytes.buffer;
    Uint8List unit8List =
        buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
    img.Image? baseSizeImage = img.decodeImage(unit8List);

    if (baseSizeImage == null) {
      return null;
    }

    img.Image rotatedImage =
        img.copyRotate(baseSizeImage, angle: radian * 180 / pi);
    ui.Codec codec =
        await ui.instantiateImageCodec(img.encodePng(rotatedImage));
    ui.FrameInfo fi = await codec.getNextFrame();
    return fi.image;
  }
}
