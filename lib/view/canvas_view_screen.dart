import 'dart:async';
import 'dart:convert';
import 'dart:html' as html;
import 'dart:js' as js;
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image/image.dart' as IMG;
import 'package:magic_image_generator/view/canvas_card.dart';
import 'package:magic_image_generator/viewmodel/canvas_view_model.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../common/constants.dart' as constants;
import '../model/card_info_header.dart';

class CanvasViewScreen extends StatefulWidget {
  final int responsiveColumns;
  final double responsiveColumnWidth;
  final double responsiveGutterWidth;

  const CanvasViewScreen(
      {Key? key,
      required this.responsiveColumns,
      required this.responsiveColumnWidth,
      required this.responsiveGutterWidth})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => CanvasViewScreenState();
}

class CanvasViewScreenState extends State<CanvasViewScreen> {
  final GlobalKey _globalKey = GlobalKey();
  double _canvasViewZoomRatio = 1.0;

  @override
  Widget build(BuildContext context) {
    List<List<CardInfoHeader>> selectedCardMatrix =
        Provider.of<CanvasViewModel>(context).selectedCards;

    double matrixWidthMax = selectedCardMatrix.map((e) => e.fold<double>(0, (previousValue, element) => previousValue + element.imageSize.width))
    .fold<double>(0, (previousValue, element) => previousValue = previousValue < element ? element : previousValue);

    double matrixHeightMax = selectedCardMatrix.map((element) => element.fold<double>(0, (previous, e) => previous = (previous < e.imageSize.height ? e.imageSize.height : previous)))
    .fold<double>(0, (previousValue, element) => previousValue = previousValue + element);

    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      _canvasViewZoomRatio = min(
          constraints.maxWidth / (matrixWidthMax + 5),
          (constraints.maxHeight) /
              ((selectedCardMatrix.length + 1) * constants.rawCardImageHeight));

      if (_canvasViewZoomRatio > 1.0) {
        _canvasViewZoomRatio = 1.0;
      }

      List<Widget> draggableImageMatrix = [];

      draggableImageMatrix = selectedCardMatrix.map((row) {
        int rowIndex = selectedCardMatrix.indexWhere((e) => e == row);

        List<Widget> cardWidgets = row.map((card) {
          int colIndex = row.indexWhere((e) => e.displayId == card.displayId);

          return DragTarget<Map<String, int>>(
              builder: (
                BuildContext context,
                List<dynamic> accepted,
                List<dynamic> rejected,
              ) {
                return CanvasCard(
                  key: ValueKey(card.displayId),
                  card: card,
                  scale: _canvasViewZoomRatio,
                );
              },
              onAccept: (data) => Provider.of<CanvasViewModel>(context, listen: false)
                  .moveCard(data, {"row": rowIndex, "col": colIndex}),
              onWillAccept: (data) =>
                  data is Map<String, int> &&
                  data.keys.contains("row") &&
                  data.keys.contains("col"));
        }).toList();

        cardWidgets.add(DragTarget<Map<String, int>>(
          builder: (
            BuildContext context,
            List<dynamic> accepted,
            List<dynamic> rejected,
          ) {
            return SizedBox(
              //横方向の余白
              width: (matrixWidthMax - Provider.of<CanvasViewModel>(context, listen: false).getRowWidth(rowIndex))* _canvasViewZoomRatio,
              height: Provider.of<CanvasViewModel>(context, listen: false).getRowHeight(rowIndex) * _canvasViewZoomRatio,
            );
          },
          onAccept: (from) => Provider.of<CanvasViewModel>(context, listen: false)
              .moveCard(from, {"row": rowIndex, "col": row.length}),
          onWillAccept: (data) => data != null && data["row"] != null && data["col"] != null,
        ));

        return Row(children: cardWidgets);
      }).toList();

      return Row(children: [
        SizedBox(
            width: matrixWidthMax* _canvasViewZoomRatio,
            child: SingleChildScrollView(
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  SizedBox(
                      height: matrixHeightMax * _canvasViewZoomRatio,
                      child: RepaintBoundary(
                          key: _globalKey,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: draggableImageMatrix))),
                  DragTarget<Map<String, int>>(
                    builder: (
                      BuildContext context,
                      List<dynamic> accepted,
                      List<dynamic> rejected,
                    ) {
                      return SizedBox(
                        //縦方向の余白
                        width: matrixWidthMax * _canvasViewZoomRatio,
                        height: constraints.maxHeight - matrixHeightMax * _canvasViewZoomRatio,
                      );
                    },
                    onAccept: (from) => Provider.of<CanvasViewModel>(context, listen: false)
                        .moveCard(from, {"row": selectedCardMatrix.length, "col": 0}),
                    onWillAccept: (data) =>
                        data != null && data["row"] != null && data["col"] != null,
                  )
                ]))),
        SizedBox(
          //横方向の余白
          width: constraints.maxWidth - matrixWidthMax * _canvasViewZoomRatio,
        )
      ]);
    });
  }

  Future<ui.Image> createImage() async {
    var selectedCardMatrix = Provider.of<CanvasViewModel>(context, listen: false).selectedCards;
    double matrixWidthMax = selectedCardMatrix.map((e) => e.fold<double>(0, (previousValue, element) => previousValue + element.imageSize.width))
        .fold<double>(0, (previousValue, element) => previousValue = previousValue < element ? element : previousValue);

    double matrixHeightMax = selectedCardMatrix.map((element) => element.fold<double>(0, (previous, e) => previous = (previous < e.imageSize.height ? e.imageSize.height : previous)))
        .fold<double>(0, (previousValue, element) => previousValue = previousValue + element);
    await getImages(Localizations.localeOf(context));
    ImageMatrixPainter p = ImageMatrixPainter(matrix: Provider.of<CanvasViewModel>(context, listen: false).selectedCards,);

    ui.Image? image = await _generateRawImage(p,matrixWidthMax, matrixHeightMax);
    return image;
  }

  Future<void> copyImageToClipBoard(BuildContext context) async {

    Future(() async {
      try {

        ui.Image image = await createImage();

        ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

        if (byteData != null) {
          int zeroCount = 0;
          for (var i = 0; i < byteData.lengthInBytes; i++) {
            if (byteData.getInt8(i) == 0) {
              zeroCount++;
            }
          }
          Uint8List pngBytes = byteData.buffer.asUint8List();

          js.context.callMethod('copyImageToClipboard', [pngBytes]);

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(AppLocalizations.of(context)!.msgCopyDone),
          ));
        } else {
          print("failed");
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context)!.exceptionCode200),
        ));
        rethrow;
      }
    });
  }

  Future<void> downloadImage(BuildContext context) async {
    Future(() async {
      try {
        ui.Image image = await createImage();

        ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
        if (byteData != null) {
          Uint8List pngBytes = byteData.buffer.asUint8List();
          await _download(pngBytes);
        } else {
          print("failed");
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context)!.exceptionCode210),
        ));
        rethrow;
      }
    });
  }

  Future<void> _download(Uint8List data) async {
    try {
      // and encode them to base64
      final base64data = base64Encode(data);

      // then we create and AnchorElement with the html package
      final a = html.AnchorElement(href: 'data:image/png;base64,$base64data');

      // set the name of the file we want the image to get
      // downloaded to
      a.download = Uuid().v1() + '.png';

      // and we click the AnchorElement which downloads the image
      a.click();
      // finally we remove the AnchorElement
      a.remove();
    } catch (e) {
      print(e);
    }
  }


  Future<void> getImages(Locale locale) async {
    Provider.of<CanvasViewModel>(context, listen: false).selectedCards =
        await Future.wait(Provider.of<CanvasViewModel>(context, listen: false).selectedCards
        .map((row) => Future.wait(row.map((card) async {
      if (card.isTransform) {
        if (card.isFront) {
          ui.Image img = await _fetchImage(card.firstFace.imageUrlLocale(locale));
          ui.Image? rotated = await rotate(img, card.rotationAngle);
          return card.copyWith(cardFaces: [card.cardFaces[0].copyWith(image: rotated), card.cardFaces[1]]);
        } else {
          ui.Image img = await _fetchImage(card.secondFace!.imageUrlLocale(locale));
          ui.Image? rotated = await rotate(img, card.rotationAngle);
          return card.copyWith(cardFaces: [card.cardFaces[0], card.cardFaces[1].copyWith(image: rotated), ]);
        }
      } else {
        ui.Image img = await _fetchImage(card.firstFace.imageUrlLocale(locale));
        ui.Image? rotated = await rotate(img, card.rotationAngle);
        return card.copyWith(cardFaces: [card.cardFaces[0].copyWith(image: rotated), ]);
      }
    }).toList()))
        .toList());
  }

  Future<ui.Image> _fetchImage(String path) async {
    var completer = Completer<ImageInfo>();
    var img = NetworkImage(path, scale: 2.0);
    img.resolve(const ImageConfiguration()).addListener(ImageStreamListener((info, _) {
      completer.complete(info);
    }));
    ImageInfo imageInfo = await completer.future;

    return imageInfo.image;
  }

  Future<ui.Image> _generateRawImage(CustomPainter painter, double width, double height) async {
    final PictureRecorder recorder = PictureRecorder();
    painter.paint(Canvas(recorder), Size(width, height));
    final Picture picture = recorder.endRecording();

    return await picture.toImage(width.toInt(), height.toInt());
  }

  Future<ui.Image?> rotate(ui.Image image, double radian) async {
    ByteData? bytes = await image.toByteData(format: ui.ImageByteFormat.png);

    if (bytes == null) {
      return null;
    }

    ByteBuffer buffer = bytes.buffer;
    Uint8List unit8List = buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
    IMG.Image? baseSizeImage = IMG.decodeImage(unit8List);

    if (baseSizeImage == null) {
      return null;}

    IMG.Image rotatedImage = IMG.copyRotate(baseSizeImage, angle: radian * 180 / pi);
    ui.Codec codec = await instantiateImageCodec(IMG.encodePng(rotatedImage));
    FrameInfo fi = await codec.getNextFrame();
    return fi.image;
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
        double width = matrix[row][col].imageSize.width;
        double height = matrix[row][col].imageSize.height;

        ui.Image? image = matrix[row][col].isTransform && !matrix[row][col].isFront ? matrix[row][col].cardFaces[1].image : matrix[row][col].cardFaces[0].image;
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
    if(targetRow > 0) {
      for(int i = 0 ; i < targetRow; i++) {
        y = y + matrix[i].fold<double>(0, (max, card) => card.imageSize.height > max ? card.imageSize.height : max);
      }
    }

    if(targetCol > 0) {
      for(int i = 0 ; i < targetCol; i++) {
        x = x + matrix[targetRow][i].imageSize.width;
      }
    }

    double targetRowHeight = matrix[targetRow].fold<double>(0, (max, card) => card.imageSize.height > max ? card.imageSize.height : max);
    if(matrix[targetRow][targetCol].imageSize.height < targetRowHeight) {
      y = y + (targetRowHeight - matrix[targetRow][targetCol].imageSize.height)/2;
    }

    return Offset(x, y);
  }


}