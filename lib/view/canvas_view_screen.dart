import 'dart:async';
import 'dart:convert';
import 'dart:html' as html;
import 'dart:js' as js;
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:magic_image_generator/view/canvas_card.dart';
import 'package:magic_image_generator/viewmodel/canvas_view_model.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:image/image.dart' as IMG;

import '../assets/constants.dart' as constants;
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

    int selectedCardRowLengthMax = selectedCardMatrix.fold<int>(
        0, (p, e) => p = p < e.length ? e.length : p);

    return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              _canvasViewZoomRatio = min(
                  constraints.maxWidth /
                      ((selectedCardRowLengthMax) *
                          constants.rawCardImageWidth + 5),
                  (constraints.maxHeight) /
                      ((selectedCardMatrix.length + 1) *
                          constants.rawCardImageHeight));

              if (_canvasViewZoomRatio > 1.0) {
                _canvasViewZoomRatio = 1.0;
              }

              List<Widget> draggableImageMatrix = [];

              draggableImageMatrix = selectedCardMatrix.map((row) {
                int rowIndex = selectedCardMatrix.indexWhere((e) => e == row);

                List<Widget> cardWidgets = row.map((card) {
                  int colIndex = row.indexWhere((e) =>
                  e.displayId == card.displayId);

                  return DragTarget<Map<String, int>>(
                      builder: (BuildContext context,
                          List<dynamic> accepted,
                          List<dynamic> rejected,) {
                        return CanvasCard(
                          key: ValueKey(card.displayId),
                          card: card,
                          scale: _canvasViewZoomRatio,
                        );
                      },
                      onAccept: (data) =>
                          Provider.of<CanvasViewModel>(context, listen: false)
                              .moveCard(
                              data, {"row": rowIndex, "col": colIndex}),
                      onWillAccept: (data) =>
                      data is Map<String, int> &&
                          data.keys.contains("row") &&
                          data.keys.contains("col"));
                }).toList();

                cardWidgets.add(DragTarget<Map<String, int>>(
                  builder: (BuildContext context,
                      List<dynamic> accepted,
                      List<dynamic> rejected,) {
                    return SizedBox(
                      //横方向の余白
                      width: (selectedCardRowLengthMax - row.length) *
                          constants.rawCardImageWidth *
                          _canvasViewZoomRatio,
                      height: constants.rawCardImageHeight *
                          _canvasViewZoomRatio,
                    );
                  },
                  onAccept: (from) =>
                      Provider.of<CanvasViewModel>(context, listen: false)
                          .moveCard(from, {"row": rowIndex, "col": row.length}),
                  onWillAccept: (data) =>
                  data != null && data["row"] != null && data["col"] != null,
                ));

                return Row(children: cardWidgets);
              }).toList();

              return Row(children: [
                SizedBox(
                    width: selectedCardRowLengthMax *
                        constants.rawCardImageWidth *
                        _canvasViewZoomRatio,
                    child: SingleChildScrollView(
                        child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: constants.rawCardImageHeight *
                                    _canvasViewZoomRatio *
                                    selectedCardMatrix.length,
                                child: RepaintBoundary(
                                    key: _globalKey,
                                    child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: draggableImageMatrix))),
                              DragTarget<Map<String, int>>(
                                builder: (BuildContext context,
                                    List<dynamic> accepted,
                                    List<dynamic> rejected,) {
                                  return SizedBox(
                                    //縦方向の余白
                                    width: selectedCardRowLengthMax *
                                        constants.rawCardImageWidth *
                                        _canvasViewZoomRatio,
                                    height: constraints.maxHeight -
                                        constants.rawCardImageHeight *
                                            _canvasViewZoomRatio *
                                            selectedCardMatrix.length,
                                  );
                                },
                                onAccept: (from) =>
                                    Provider.of<CanvasViewModel>(context,
                                        listen: false)
                                        .moveCard(
                                        from, {
                                      "row": selectedCardMatrix.length,
                                      "col": 0
                                    }),
                                onWillAccept: (data) =>
                                data != null &&
                                    data["row"] != null &&
                                    data["col"] != null,
                              )
                            ]))),
                SizedBox(
                  //横方向の余白
                  width: constraints.maxWidth -
                      selectedCardRowLengthMax *
                          constants.rawCardImageWidth *
                          _canvasViewZoomRatio,
                )
              ]);
            });
      }



  Future<void> copyImageToClipBoard(BuildContext context) async {
    Future(() async {
      try {
/*        RenderRepaintBoundary? boundary = _globalKey.currentContext
            ?.findRenderObject() as RenderRepaintBoundary?;
        if (boundary == null) {
          return;
        }

        ui.Image image =
        await boundary.toImage(pixelRatio: 1 / _canvasViewZoomRatio);*/

        List<List<ui.Image>> images = await getImages(
            Provider.of<CanvasViewModel>(context, listen: false).selectedCards, Localizations.localeOf(context));
        ImageMatrixPainter p = ImageMatrixPainter(matrix: images, imageWidth: constants.rawCardImageWidth, imageHeight: constants.rawCardImageHeight);

        ui.Image? image = await _generateRawImage(
            p,
            images.fold<int>(0, (p, e) => e.length>p? e.length: p) * constants.rawCardImageWidth,
            images.length * constants.rawCardImageHeight);

        ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);

        if (byteData != null) {
          int zeroCount = 0;
          for(var i = 0; i < byteData.lengthInBytes; i++) {
            if(byteData.getInt8(i) == 0) {
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
/*        RenderRepaintBoundary? boundary = _globalKey.currentContext
            ?.findRenderObject() as RenderRepaintBoundary?;
        if (boundary == null) {
          return;
        }

        ui.Image image =
        await boundary.toImage(pixelRatio: 1 / _canvasViewZoomRatio);*/

        List<List<ui.Image>> images = await getImages(
            Provider.of<CanvasViewModel>(context, listen: false).selectedCards, Localizations.localeOf(context));


        ImageMatrixPainter p = ImageMatrixPainter(matrix: images, imageWidth: constants.rawCardImageWidth, imageHeight: constants.rawCardImageHeight);

        print("_generateRawImage");
        ui.Image? image = await _generateRawImage(
            p,
            images.fold<int>(0, (p, e) => e.length>p? e.length: p) * constants.rawCardImageWidth,
            images.length * constants.rawCardImageHeight);

        ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
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

  Future<List<List<ui.Image>>> getImages(List<List<CardInfoHeader>> cards, Locale locale) {
    return Future.wait(cards.map((row) => Future.wait(row.map((card)  {
      if(card.isTransform) {
        if(card.isFront) {
          return  _fetchImage(card.firstFace.imageUrlLocale(locale));
          //return await _fetchImage(card.firstFace.imageUrlLocale(locale));
        } else {
          return  _fetchImage(card.secondFace!.imageUrlLocale(locale));
          //return await _fetchImage(card.secondFace!.imageUrlLocale(locale));
        }
      } else {
        return _fetchImage(card.firstFace.imageUrlLocale(locale));
        //ui.Image img = await  _fetchImage(card.firstFace.imageUrlLocale(locale));
        //return img;
      }
    }).toList())).toList());
  }

  Future<ui.Image> _fetchImage(String path) async {
    var completer = Completer<ImageInfo>();
    var img = NetworkImage(path, scale: 2.0);
    img.resolve(const ImageConfiguration()).addListener(ImageStreamListener((info, _) {
      completer.complete(info);
    }));
    ImageInfo imageInfo = await completer.future;

    /*
    if(imageInfo.image.width != constants.rawCardImageWidth) {
      print("imageInfo.image.toByteData");
      ByteData? byteData = await imageInfo.image.toByteData(format: ui.ImageByteFormat.png);
      print("IMG.Image.fromBytes");
      IMG.Image image = IMG.Image.fromBytes(imageInfo.image.width, imageInfo.image.height, byteData!.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
      print("${image.numberOfChannels }, ${image.width}, ${image.height}");
      print("IMG.copyResize");
      //IMG.Image resized = IMG.copyResize(image, width: constants.rawCardImageWidth.toInt(), height: constants.rawCardImageHeight.toInt());
      //print("${resized.numberOfChannels }, ${resized.width}, ${resized.height}");

      print("resized.getBytes");
      Uint8List resizedBytes = image.getBytes();
      
      ui.Codec codec = await ui.instantiateImageCodec(resizedBytes, allowUpscaling: true);
      ui.FrameInfo fi = await codec.getNextFrame();
      return fi.image;

      final Completer<ui.Image> completer = Completer();
      print("ui.decodeImageFromPixels");
      ui.decodeImageFromList(
          resizedBytes,
          //constants.rawCardImageWidth.toInt(),
          //constants.rawCardImageHeight.toInt(),
          //PixelFormat.rgba8888,
              (ui.Image img) {
        print("ui.decodeImageFromList callback");
        return completer.complete(img);
      });

      print("completer.future");
      ui.Image result = await completer.future;

      print("return result");
      return result;

    }*/

    return imageInfo.image;
  }

  Future<ui.Image> _generateRawImage(CustomPainter painter, double width, double height) async {
    final PictureRecorder recorder = PictureRecorder();
    painter.paint(Canvas(recorder), Size(width, height));
    final Picture picture = recorder.endRecording();

    return await picture.toImage(width.toInt(), height.toInt());
  }

}

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