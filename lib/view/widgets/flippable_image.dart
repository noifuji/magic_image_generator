import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class FlippableImage extends StatefulWidget {
  Image frontSide;
  double width;
  Image? backSide;
  Function? onFlipped;
  FlippableImageController controller;

  FlippableImage({
    Key? key,
    required this.frontSide,
    required this.width,
    required this.controller,
    this.backSide,
    this.onFlipped,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FlippableImageState();
}

class _FlippableImageState extends State<FlippableImage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;
  AnimationStatus _status = AnimationStatus.dismissed;

  void flip() {
    _controller.forward();
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

        if(status == AnimationStatus.completed && widget.onFlipped != null) {
          widget.onFlipped!();
        }
      });

    widget.controller.state = this;
  }

  @override
  void didUpdateWidget(FlippableImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    //isFrontが変わっている場合は、アニメーションを実行する。
    //isFront=trueなら右方向に回転する。falseなら逆回転。
    //frontとbackが途中で変わった場合、

    if(widget.backSide != null && widget.frontSide != oldWidget.frontSide) {
      _controller.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget img;
    if(widget.backSide != null) {
      Widget back = Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(pi),
          child: widget.backSide);

      if( _animation.value <= 0.5) {
        img = Transform(
            alignment: FractionalOffset.center,
            transform: Matrix4.identity()..setEntry(3, 2, 0.0015)..rotateY(pi * _animation.value),
            child: widget.frontSide);
      } else {
        img = Transform(
            alignment: FractionalOffset.center,
            transform: Matrix4.identity()..setEntry(3, 2, 0.0015)..rotateY(pi * _animation.value),
            child:back);
      }
    }else {
      img  = widget.frontSide;
      //img  = FittedBox(child:widget.frontSide, fit: BoxFit.fill,);
    }

    return SizedBox(
        width: widget.width,
        child: img,
    );
  }

}

class FlippableImageController {
  _FlippableImageState? state;

  void flip() => state?.flip();
}