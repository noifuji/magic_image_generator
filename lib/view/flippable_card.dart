import 'dart:math';

import 'package:flutter/cupertino.dart';
import '../assets/constants.dart' as constants;

class FlippableCard extends StatefulWidget {
  Image firstFace;
  double scale;
  Image? secondFace;
  Function? onFlip;
  bool? isFirstFaceFront = true;

  FlippableCard({
    Key? key,
    required this.firstFace,
    required this.scale,
    this.secondFace,
    this.isFirstFaceFront,
    this.onFlip}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FlippableCardState();
}

class _FlippableCardState extends State<FlippableCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;
  AnimationStatus _status = AnimationStatus.dismissed;


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
  void didUpdateWidget(FlippableCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    //firstFaceとsecondFaceが入れ替わっている場合はresetする。
    //isFirstFaceFrontが変わっている場合は、アニメーションを実行する。
    print("didUpdateWidget");

    if(widget.firstFace != oldWidget.firstFace) {
      _controller.reset();
    }

    if(widget.isFirstFaceFront != oldWidget.isFirstFaceFront) {
      if (widget.onFlip != null) {
        widget.onFlip!();
      }
      if (_status == AnimationStatus.dismissed) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget img;
    if(widget.secondFace != null) {
      Widget back = Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(pi),
          child: widget.secondFace);

      if( _animation.value <= 0.5) {
        img = Transform(
            alignment: FractionalOffset.center,
            transform: Matrix4.identity()..setEntry(3, 2, 0.0015)..rotateY(pi * _animation.value),
            child: widget.firstFace);
      } else {
        img = Transform(
            alignment: FractionalOffset.center,
            transform: Matrix4.identity()..setEntry(3, 2, 0.0015)..rotateY(pi * _animation.value),
            child:back);
      }
    }else {
      img  = widget.firstFace;
    }

    return SizedBox(
        width: constants.rawCardImageWidth * widget.scale,
        child: img,
    );
  }

}