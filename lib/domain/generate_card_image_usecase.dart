
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flutter/widgets.dart';

import '../model/card_info_header.dart';

class GenerateCardImageUseCase {

  Future<ui.Image> call(List<List<CardInfoHeader>> cards, double width, double height, Locale locale) async {
    
    var mapped = cards.map((row) => Future.wait(row.map((card) async {
      if(card.isTransform) {
        if(card.isFront) {
          return await _fetchImage(card.firstFace.imageUrlLocale(locale));
        } else {
          return await _fetchImage(card.secondFace!.imageUrlLocale(locale));
        }
      } else {
        ui.Image img =  await _fetchImage(card.firstFace.imageUrlLocale(locale));
        return img;
      }
    }).toList())).toList();

    List<List<ui.Image>> imageMatrix = await Future.wait(mapped);
    ImageMatrixPainter painter = ImageMatrixPainter(matrix: imageMatrix, imageWidth: width,imageHeight: height);

    int maxColumnSize = imageMatrix.fold(0, (p, e) => e.length > p? e.length:p);
    return _getImage(painter, maxColumnSize * width, imageMatrix.length * height);
  }

  Future<ui.Image> _fetchImage(String path) async {
    var completer = Completer<ImageInfo>();
    var img = NetworkImage(path);
    img.resolve(const ImageConfiguration()).addListener(ImageStreamListener((info, _) {
      completer.complete(info);
    }));
    ImageInfo imageInfo = await completer.future;
    return imageInfo.image;
  }

  Future<ui.Image> _getImage(CustomPainter painter, double width, double height) async {
    final PictureRecorder recorder = PictureRecorder();
    painter.paint(Canvas(recorder), Size(width, height));
    final Picture picture = recorder.endRecording();

    return await picture.toImage(width.toInt(), height.toInt());
  }

}

///
///マトリクス形式の画像データ配列を1つの画像に変換する。
///画像は全て同じサイズの前提
class ImageMatrixPainter extends CustomPainter {
  final List<List<ui.Image>> matrix;
  final double imageWidth;
  final double imageHeight;
  ImageMatrixPainter({required this.matrix, required this.imageWidth, required this.imageHeight});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    for(var row = 0; row < matrix.length; row++) {
      for(var col = 0; col < matrix[row].length; col++) {
        canvas.drawImage(matrix[row][col], Offset(col * imageWidth, row * imageHeight), paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
