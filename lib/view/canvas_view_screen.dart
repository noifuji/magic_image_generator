import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:magic_image_generator/view/canvas_card.dart';
import 'package:magic_image_generator/viewmodel/canvas_view_model.dart';
import 'package:provider/provider.dart';

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

    double matrixWidth = Provider.of<CanvasViewModel>(context).getMatrixWidth();
    double matrixHeight =
        Provider.of<CanvasViewModel>(context).getMatrixHeight();

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      _canvasViewZoomRatio = min(
          constraints.maxWidth / (matrixWidth + 5),
          (constraints.maxHeight) /
              (matrixHeight + constants.rawCardImageHeight));

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
              onAccept: (data) =>
                  Provider.of<CanvasViewModel>(context, listen: false)
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
              width: (matrixWidth -
                      Provider.of<CanvasViewModel>(context, listen: false)
                          .getMatrixRowWidth(rowIndex)) *
                  _canvasViewZoomRatio,
              height: Provider.of<CanvasViewModel>(context, listen: false)
                      .getMatrixRowHeight(rowIndex) *
                  _canvasViewZoomRatio,
            );
          },
          onAccept: (from) =>
              Provider.of<CanvasViewModel>(context, listen: false)
                  .moveCard(from, {"row": rowIndex, "col": row.length}),
          onWillAccept: (data) =>
              data != null && data["row"] != null && data["col"] != null,
        ));

        return Row(
            crossAxisAlignment: CrossAxisAlignment.end, children: cardWidgets);
      }).toList();

      return Row(children: [
        SizedBox(
            width: matrixWidth * _canvasViewZoomRatio,
            child: SingleChildScrollView(
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  SizedBox(
                      height: matrixHeight * _canvasViewZoomRatio,
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
                        width: matrixWidth * _canvasViewZoomRatio,
                        height: constraints.maxHeight -
                            matrixHeight * _canvasViewZoomRatio,
                      );
                    },
                    onAccept: (from) => Provider.of<CanvasViewModel>(context,
                            listen: false)
                        .moveCard(
                            from, {"row": selectedCardMatrix.length, "col": 0}),
                    onWillAccept: (data) =>
                        data != null &&
                        data["row"] != null &&
                        data["col"] != null,
                  )
                ]))),
        SizedBox(
          //横方向の余白
          width: constraints.maxWidth - matrixWidth * _canvasViewZoomRatio,
        )
      ]);
    });
  }

  Future<void> copyImageToClipBoard(BuildContext context) async {
    Provider.of<CanvasViewModel>(context, listen: false)
        .copyImageToClipBoard(Localizations.localeOf(context), callback: () {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(AppLocalizations.of(context)!.msgCopyDone),
      ));
    }, error: () {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(AppLocalizations.of(context)!.exceptionCode200),
      ));
    });
  }

  Future<void> downloadImage(BuildContext context) async {
    Provider.of<CanvasViewModel>(context, listen: false)
        .downloadImage(Localizations.localeOf(context), error: () {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(AppLocalizations.of(context)!.exceptionCode210),
      ));
    });
  }
}
