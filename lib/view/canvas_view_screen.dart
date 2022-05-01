import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:magic_image_generator/view/search_box_widget.dart';
import 'package:magic_image_generator/viewmodel/canvas_view_model.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'dart:ui' as ui;
import 'dart:js' as js;

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../assets/constants.dart' as constants;
import '../assets/util.dart';
import '../model/card_info.dart';

class CanvasViewScreen extends StatefulWidget {
  int responsiveColumns;
  double responsiveColumnWidth;
  double responsiveGutterWidth;

  CanvasViewScreen(
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
    Util.printTimeStamp("_CanvasViewScreenState build");
    List<List<CardInfo>> selectedCardMatrix =
        Provider.of<CanvasViewModel>(context).selectedCards;
    int selectedCardRowLengthMax = selectedCardMatrix.fold<int>(
        0, (p, e) => p = p < e.length ? e.length : p);
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      _canvasViewZoomRatio = min(
          constraints.maxWidth /
              ((selectedCardRowLengthMax) * constants.rawCardImageWidth+5),
          (constraints.maxHeight) /
              ((selectedCardMatrix.length + 1) * constants.rawCardImageHeight));

      if (_canvasViewZoomRatio > 1.0) {
        _canvasViewZoomRatio = 1.0;
      }



      List<Widget> draggableImageMatrix = [];

      draggableImageMatrix = selectedCardMatrix.map((row) {
        List<Widget> cardWidgets = row
            .map((card) => _createDragTarget(
                context,
                selectedCardMatrix,
                card,
                Image.network(card.imageUrl(Localizations.localeOf(context))),
                selectedCardMatrix.indexWhere((e) => e == row),
                row.indexWhere((e) => e == card))) //Rowの末尾にDragTargetを追加
            .toList();

        cardWidgets.add(DragTarget<Map<String, int>>(
          builder: (
            BuildContext context,
            List<dynamic> accepted,
            List<dynamic> rejected,
          ) {
            return SizedBox(
              //横方向の余白
              width: (selectedCardRowLengthMax -
                  row.length) *
                      constants.rawCardImageWidth *
                      _canvasViewZoomRatio,
              height: constants.rawCardImageHeight * _canvasViewZoomRatio,
            );
          },
          onAccept: (data) {
            print('''new row''');
            CardInfo card = selectedCardMatrix[data["row"]!][data["col"]!];
            selectedCardMatrix[data["row"]!].removeAt(data["col"]!);

            selectedCardMatrix[selectedCardMatrix.indexOf(row)].add(card);

            selectedCardMatrix = selectedCardMatrix
                .where((element) => element.isNotEmpty)
                .toList();

            Provider.of<CanvasViewModel>(context, listen: false)
                .setSelectedCards(selectedCardMatrix);
          },
          onWillAccept: (data) {
            print('''onWillAccept:from$data''');
            return data != null && data["row"] != null && data["col"] != null;
          },
        ));

        return Row(children: cardWidgets);
      }).toList();

      print(constraints.maxWidth -
          selectedCardRowLengthMax *
              constants.rawCardImageWidth *
              _canvasViewZoomRatio);

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
                builder: (
                  BuildContext context,
                  List<dynamic> accepted,
                  List<dynamic> rejected,
                ) {
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
                onAccept: (data) {
                  print('''new row''');
                  CardInfo card =
                      selectedCardMatrix[data["row"]!][data["col"]!];
                  selectedCardMatrix.add([card]);
                  selectedCardMatrix[data["row"]!].removeAt(data["col"]!);

                  selectedCardMatrix = selectedCardMatrix
                      .where((element) => element.isNotEmpty)
                      .toList();

                  Provider.of<CanvasViewModel>(context, listen: false)
                      .setSelectedCards(selectedCardMatrix);
                },
                onWillAccept: (data) {
                  print('''onWillAccept:from$data''');
                  return data != null &&
                      data["row"] != null &&
                      data["col"] != null;
                },
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

  DragTarget _createDragTarget(
      BuildContext context,
      List<List<CardInfo>> selectedCardMatrix,
      CardInfo card,
      Image img,
      int row,
      int col) {
    return DragTarget<Map<String, int>>(
      builder: (
        BuildContext context,
        List<dynamic> accepted,
        List<dynamic> rejected,
      ) {
        return Draggable<Map<String, int>>(
            data: {"row": row, "col": col},
            child: SizedBox(
              width: constants.rawCardImageWidth * _canvasViewZoomRatio,
              child: img,
            ),
            feedback: SizedBox(
              width: constants.rawCardImageWidth * _canvasViewZoomRatio,
              child: img,
            ),
            childWhenDragging: SizedBox(
              width: constants.rawCardImageWidth * _canvasViewZoomRatio,
              child: Image.memory(kTransparentImage),
            ));
      },
      onAccept: (data) {
        //to position
        int row = selectedCardMatrix.fold<int>(
            0,
            (p, row) =>
                row.contains(card) ? selectedCardMatrix.indexOf(row) : p);
        int col = selectedCardMatrix[row].indexOf(card);

        print('''OnAccept:from$data, to${{"row": row, "col": col}}''');

        selectedCardMatrix = rearrangeCardInfoMatrix(
            selectedCardMatrix, data, {"row": row, "col": col});
        selectedCardMatrix =
            selectedCardMatrix.where((element) => element.isNotEmpty).toList();

        Provider.of<CanvasViewModel>(context, listen: false)
            .setSelectedCards(selectedCardMatrix);
      },
      onWillAccept: (data) {
        int row = selectedCardMatrix.fold<int>(
            0,
            (p, row) =>
                row.contains(card) ? selectedCardMatrix.indexOf(row) : p);
        int col = selectedCardMatrix[row].indexOf(card);
        print('''onWillAccept:from$data, to${{"row": row, "col": col}}''');

        return true;
      },
    );
  }

  List<List<CardInfo>> rearrangeCardInfoMatrix(
      List<List<CardInfo>> matrix, Map from, Map to) {
    print(
        '''positionFrom:(${from["row"]},${from["col"]}), positionTo:(${to["row"]},${to["col"]})''');

    List<List<CardInfo>> copy = matrix.map((row) => <CardInfo>[]).toList();

    if (from["col"] < 0 ||
        to["col"] < 0 ||
        from["row"] < 0 ||
        to["row"] < 0 ||
        from["row"] >= matrix.length ||
        to["row"] > matrix.length ||
        from["col"] >= matrix[from["row"]].length ||
        to["col"] >= matrix[to["row"]].length) {
      print("over size");
      return matrix;
    }

    if (from["col"] == to["col"] && from["row"] == to["row"]) {
      print("no change");
      return matrix;
    }

    //同じ行の場合
    if (from["row"] == to["row"]) {
      print("same row");

      int row = from["row"];

      if (from["col"] > to["col"]) {
        //右から左へ
        copy[row].addAll(matrix[row].sublist(0, to["col"]));
        copy[row].add(matrix[row][from["col"]]);
        copy[row].addAll(matrix[row].sublist(to["col"], from["col"]));
        copy[row].addAll(matrix[row].sublist(from["col"] + 1));
      } else {
        //左から右へ
        print("left to right");
        copy[row].insertAll(0, matrix[row].sublist(to["col"] + 1));
        print(copy);
        copy[row].insert(0, matrix[row][from["col"]]);
        print(copy);
        copy[row]
            .insertAll(0, matrix[row].sublist(from["col"] + 1, to["col"] + 1));
        print(copy);
        copy[row].insertAll(0, matrix[row].sublist(0, from["col"]));
        print(copy);
      }

      //row以外の行もコピーする。
      for (var i = 0; i < matrix.length; i++) {
        if (i != row) {
          copy[i].addAll(matrix[i]);
        }
      }
      print(copy);
    } else {
      //異なる行の場合
      copy[to["row"]].addAll(matrix[to["row"]].sublist(0, to["col"]));
      copy[to["row"]].add(matrix[from["row"]][from["col"]]);
      copy[to["row"]].addAll(matrix[to["row"]].sublist(to["col"]));

      copy[from["row"]].addAll(matrix[from["row"]].sublist(0, from["col"]));
      copy[from["row"]].addAll(matrix[from["row"]].sublist(from["col"] + 1));

      for (var i = 0; i < matrix.length; i++) {
        if (i != from["row"] && i != to["row"]) {
          copy[i].addAll(matrix[i]);
        }
      }
    }

    return copy;
  }

  Future<void> copyImageToClipBoard() async {
    Future(() async {
        RenderRepaintBoundary? boundary = _globalKey.currentContext
            ?.findRenderObject() as RenderRepaintBoundary?;
        if (boundary == null) {
          return;
        }
        ui.Image image =
        await boundary.toImage(pixelRatio: 1 / _canvasViewZoomRatio);
        ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
        if (byteData != null) {
          Uint8List pngBytes = byteData.buffer.asUint8List();
          js.context.callMethod('copyImageToClipboard', [pngBytes]);

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(AppLocalizations.of(context)!.msgCopyDone),
          ));

        } else {
          print("failed");
        }
    });
  }
}
