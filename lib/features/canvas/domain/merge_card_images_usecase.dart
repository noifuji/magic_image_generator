import 'dart:async';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:magic_image_generator/features/search/domain/entity/card_info_header.dart';

class MergeCardImageUseCase {
  Future<ui.Image> call(
      List<List<CardInfoHeader>> cards, double width, double height) async {
    ImageMatrixPainter painter = ImageMatrixPainter(
      matrix: cards,
    );
    final PictureRecorder recorder = PictureRecorder();
    painter.paint(Canvas(recorder), Size(width, height));
    final Picture picture = recorder.endRecording();

    return await picture.toImage(width.toInt(), height.toInt());
  }
}

class ImageMatrixPainter extends CustomPainter {
  final List<List<CardInfoHeader>> matrix;

  ImageMatrixPainter({required this.matrix});

  @override
  Future<void> paint(Canvas canvas, Size size) async {
    final paint = Paint();

    for (var row = 0; row < matrix.length; row++) {
      for (var col = 0; col < matrix[row].length; col++) {
        ui.Image? image =
            matrix[row][col].isTransform && !matrix[row][col].isFront
                ? matrix[row][col].cardFaces[1].image
                : matrix[row][col].cardFaces[0].image;
        //ui.Codec codec = await instantiateImageCodec(kTransparentImage);
        //ui.Image transparent = (await codec.getNextFrame()).image;TODO:画像データが存在しない場合の処理
        canvas.drawImage(image!, calcOffset(row, col), paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  Offset calcOffset(int targetRow, int targetCol) {
    double x = 0;
    double y = 0;
    if (targetRow > 0) {
      for (int i = 0; i < targetRow; i++) {
        y = y +
            matrix[i].fold<double>(
                0,
                (max, card) =>
                    card.imageSize.height > max ? card.imageSize.height : max);
      }
    }

    if (targetCol > 0) {
      for (int i = 0; i < targetCol; i++) {
        x = x + matrix[targetRow][i].imageSize.width;
      }
    }

    double targetRowHeight = matrix[targetRow].fold<double>(
        0,
        (max, card) =>
            card.imageSize.height > max ? card.imageSize.height : max);
    if (matrix[targetRow][targetCol].imageSize.height < targetRowHeight) {
      y = y + (targetRowHeight - matrix[targetRow][targetCol].imageSize.height);
    }

    return Offset(x, y);
  }
}
