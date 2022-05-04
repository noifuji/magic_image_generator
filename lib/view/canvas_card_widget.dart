import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:magic_image_generator/model/card_info_header.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

import '../model/card_info.dart';
import '../assets/constants.dart' as constants;
import '../viewmodel/canvas_view_model.dart';


/*
* ドラッガブル
* マウスオンでボタン表示
* 不リップ機能
* 画像データ表示
*
*
*
* */
class CanvasCardWidget extends StatefulWidget {
  CardInfoHeader header;
  CardInfo front;
  CardInfo? back;
  double canvasViewZoomRatio;
  Function? onFlip;

  CanvasCardWidget(
      {Key? key,
      required this.header,
      required this.front,
      this.back,
        this.onFlip,
      required this.canvasViewZoomRatio})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _CanvasCardWidgetState();
}

class _CanvasCardWidgetState extends State<CanvasCardWidget> with SingleTickerProviderStateMixin  {
  bool _isMouseOn = false;
  late AnimationController _controller;
  late Animation _animation;
  AnimationStatus _status = AnimationStatus.dismissed;


  @override
  void didUpdateWidget(CanvasCardWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    _controller.reset();
  }

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
      _status = AnimationStatus.dismissed;
      _animation = Tween(end: 1.0, begin: 0.0).animate(_controller)
        ..addListener(() {
          setState(() {});
        })
        ..addStatusListener((status) {
          _status = status;
        });

  }

  @override
  Widget build(BuildContext context) {
    Widget img;
    Widget front = Image.network(widget.front.imageUrl(Localizations.localeOf(context)));
    if(widget.back != null) {
      Widget back = Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(pi),
          child: Image.network(widget.back!.imageUrl(Localizations.localeOf(context))));

      if( _animation.value <= 0.5) {
        img = Transform(
            alignment: FractionalOffset.center,
            transform: Matrix4.identity()..setEntry(3, 2, 0.0015)..rotateY(pi * _animation.value),
            child: front);
      } else {
        img = Transform(
            alignment: FractionalOffset.center,
            transform: Matrix4.identity()..setEntry(3, 2, 0.0015)..rotateY(pi * _animation.value),
            child:back);
      }
    }else {
      img  = front;
    }

    var selectedCards = Provider.of<CanvasViewModel>(context).selectedCards;
    int rowIndex = selectedCards.indexWhere((row) => row.where((card) => card.displayId == widget.header.displayId).toList().isNotEmpty);
    int colIndex = selectedCards[rowIndex].indexWhere((card) => card.displayId == widget.header.displayId);


    return MouseRegion(
        onEnter: (details) => setState(() {
              _isMouseOn = true;
            }),
        onExit: (details) => setState(() {
              _isMouseOn = false;
            }),
        child: Draggable<Map<String, int>>(
            data: {"row": rowIndex, "col": colIndex},
            child: SizedBox(
              width: constants.rawCardImageWidth * widget.canvasViewZoomRatio,
              child: Stack(children: [
                img,
                if (_isMouseOn)
                  Container(
                    width: 30.0 * widget.canvasViewZoomRatio,
                    height: 30.0 * widget.canvasViewZoomRatio,
                    margin: EdgeInsets.only(
                        top: 10.0 * widget.canvasViewZoomRatio,
                        left: 10.0 * widget.canvasViewZoomRatio),
                    decoration: BoxDecoration(
                      color:
                          Theme.of(context).colorScheme.primary.withAlpha(200),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      padding: const EdgeInsets.all(0.0),
                      alignment: Alignment.center,
                      icon: Icon(
                        Icons.close_rounded,
                        size: 20.0 * widget.canvasViewZoomRatio,
                      ),
                      color: Theme.of(context).colorScheme.onPrimary,
                      onPressed: () =>
                          Provider.of<CanvasViewModel>(context, listen: false)
                              .removeCard(rowIndex, colIndex),
                    ),
                  ),
                if (_isMouseOn && widget.back != null)
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            width: 30.0 * widget.canvasViewZoomRatio,
                            height: 30.0 * widget.canvasViewZoomRatio,
                            margin: const EdgeInsets.only(),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withAlpha(200),
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              padding: const EdgeInsets.all(0.0),
                              alignment: Alignment.center,
                              icon: Icon(
                                Icons.autorenew,
                                size: 20.0 * widget.canvasViewZoomRatio,
                              ),
                              color: Theme.of(context).colorScheme.onPrimary,
                              onPressed: () {
                                if(widget.onFlip != null) {
                                  widget.onFlip!();
                                }
                                if (_status == AnimationStatus.dismissed) {
                                  _controller.forward();
                                } else {
                                  _controller.reverse();
                                }},
                            ),
                          ))),
              ]),
            ),
            feedback: SizedBox(
              width: constants.rawCardImageWidth * widget.canvasViewZoomRatio,
              child: img,
            ),
            childWhenDragging: SizedBox(
                width: constants.rawCardImageWidth * widget.canvasViewZoomRatio,
                child: Image.memory(kTransparentImage))));
  }
}
