

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

import '../assets/constants.dart' as constants;
import '../assets/util.dart';
import '../model/card_info.dart';

class CanvasViewScreen extends StatefulWidget {
  CanvasViewScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CanvasViewScreenState();
}

class _CanvasViewScreenState extends State<CanvasViewScreen> {
  final GlobalKey _globalKey = GlobalKey();
  double _canvasViewZoomRatio = 1.0;

  @override
  Widget build(BuildContext context) {
    Util.printTimeStamp("_CanvasViewScreenState build");
    List<CardInfo> selectedCards = Provider.of<CanvasViewModel>(context).selectedCards;

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {

          _canvasViewZoomRatio = constraints.maxWidth / (selectedCards.length * constants.cardWidth+10);
          if(_canvasViewZoomRatio > 1.0) {
            _canvasViewZoomRatio = 1.0;
          }

          List<Widget> draggableImages = [];

          for (var card in selectedCards) {
            var img = Image.network(card.imageUrl(Localizations.localeOf(context)));

            draggableImages.add(createDragTarget(context, selectedCards, card, img));
          }

          return Scaffold(
            body: Row(children: [
              SizedBox(
                  width: draggableImages.length *
                      constants.cardWidth *
                      _canvasViewZoomRatio,
                  child: Column(children: [
                    SizedBox(
                        height: constants.cardHeight * _canvasViewZoomRatio,
                        child: RepaintBoundary(
                            key: _globalKey,
                            child: Column(children: [
                              Row(
                                children: draggableImages,
                              )
                            ]))),
                    SizedBox(
                      //縦方向の余白
                      height: constraints.maxHeight -
                          constants.cardHeight * _canvasViewZoomRatio,
                    )
                  ])),
              SizedBox(
                //横方向の余白
                width: constraints.maxWidth -
                    draggableImages.length *
                        constants.cardWidth *
                        _canvasViewZoomRatio,
              )
            ]),
            floatingActionButton: FloatingActionButton(
              onPressed: _incrementCounter,
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ), // This trailing comma makes auto-formatting nicer for build methods.
          );

        });
  }

  DragTarget createDragTarget(BuildContext context,List<CardInfo> selectedCards,CardInfo card, Image img) {
    return DragTarget<int>(
      builder: (
          BuildContext context,
          List<dynamic> accepted,
          List<dynamic> rejected,
          ) {
        return Draggable<int>(
            data: selectedCards.indexWhere((element) => element.imageUrl == card.imageUrl),
            child: SizedBox(
              width: constants.cardWidth * _canvasViewZoomRatio,
              child: img,
            ),
            feedback: SizedBox(
              width: constants.cardWidth * _canvasViewZoomRatio,
              child: img,
            ),
            childWhenDragging: SizedBox(
              width: constants.cardWidth * _canvasViewZoomRatio,
              child: Image.memory(kTransparentImage),
            ));
      },
      onAccept: (data) {
        print('''OnAccept:$data''');
        Provider.of<CanvasViewModel>(context, listen: false).setSelectedCards(rearrange(selectedCards, data, selectedCards.indexWhere((element) => element.imageUrl == card.imageUrl)));
      },
      onWillAccept: (data) {
        print('''onWillAccept:$data''');
        return data is int;
      },
      onMove: (data) {
        print("onmove");
      },
    );
  }

  /*
   * [0,1,2,3,4,5,6,7]
   * from = 5 to = 3
   * [0,1,2](first - to-1) + [5](from) + [3,4](to+1 - from-1) + [6,7](from+1 - last)
   *
   * from = 3 to = 5
   * [0,1,2](first - from-1) + [4](from+1 - to-1) + [3]from + [5,6,7](to+1 - last)
   */
  List<CardInfo> rearrange(List<CardInfo> items, int indexFrom, int indexTo) {
    print('''indexFrom:$indexFrom, indexTo:$indexTo''');

    List<CardInfo> copy = [];
    if (indexFrom < 0 ||
        indexTo < 0 ||
        indexFrom >= items.length ||
        indexTo > items.length) {
      return items;
    }

    if (indexFrom == indexTo) {
      return items;
    }

    if (indexFrom > indexTo) {
      copy.addAll(items.sublist(0, indexTo));
      copy.add(items[indexFrom]);
      copy.addAll(items.sublist(indexTo, indexFrom));
      copy.addAll(items.sublist(indexFrom + 1));
    } else {
      copy.addAll(items.sublist(0, indexFrom));
      copy.addAll(items.sublist(indexFrom + 1, indexTo));
      copy.add(items[indexFrom]);

      if (indexTo < items.length) {
        copy.addAll(items.sublist(indexTo));
      }
    }

    return copy;
  }

  Future<void> _incrementCounter() async {
    Future(() async {
      RenderRepaintBoundary? boundary = _globalKey.currentContext
          ?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) {
        return;
      }
      ui.Image image = await boundary.toImage(pixelRatio: 1/_canvasViewZoomRatio);
      ByteData? byteData =
      await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData != null) {
        Uint8List pngBytes = byteData.buffer.asUint8List();
        js.context.callMethod('copyImageToClipboard', [pngBytes]);
      } else {
        print("failed");
      }
    });
  }

}