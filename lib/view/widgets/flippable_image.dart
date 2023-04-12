import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FlippableImage extends StatefulWidget {
  final Widget frontSide;
  final double width;
  final double height;
  final double rotationAngle;
  final FlippableImageController controller;
  final Widget? backSide;
  final Function? onFlipped;

  const FlippableImage({
    Key? key,
    required this.frontSide,
    required this.width,
    required this.height,
    required this.rotationAngle,
    required this.controller,
    this.backSide, this.onFlipped,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FlippableImageState();
}

class _FlippableImageState extends State<FlippableImage> with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
    widget.controller.onFlipped ??= widget.onFlipped;
    widget.controller.initAnimation(this, Size(widget.width, widget.height));
  }


  @override
  void didUpdateWidget(FlippableImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    //isFrontが変わっている場合は、アニメーションを実行する。
    //isFront=trueなら右方向に回転する。falseなら逆回転。
    //frontとbackが途中で変わった場合、

    if(widget.backSide != null && widget.frontSide != oldWidget.frontSide) {
      widget.controller.animationController.reset();
    }
  }


  @override
  void dispose() {
    super.dispose();
    widget.controller.animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(animation: widget.controller, builder: (BuildContext context, Widget? child) {
      return SizedBox(
        width: widget.width,
        height: widget.height,
        child: _createImageView(),
      );
    });

  }

  Widget _createImageView() {
    Widget img;
    if(widget.backSide != null) {
      Widget back = Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(pi),
          //child: Transform.rotate(angle: widget.rotationAngle, child:widget.backSide));
          child: RotatedBox(quarterTurns:  widget.rotationAngle/(pi/2) as int, child:widget.backSide));

      if( widget.controller.animation.value <= 0.5) {
        img = Transform(
            alignment: FractionalOffset.center,
            transform: Matrix4.identity()..setEntry(3, 2, 0.0015)..rotateY(pi * widget.controller.animation.value),
            //child: Transform.rotate(angle: widget.rotationAngle, child:widget.frontSide));
            child: RotatedBox(quarterTurns:  widget.rotationAngle/(pi/2) as int, child:widget.frontSide));
      } else {
        img = Transform(
            alignment: FractionalOffset.center,
            transform: Matrix4.identity()..setEntry(3, 2, 0.0015)..rotateY(pi * widget.controller.animation.value),
            child:back);
      }
    }else {
      //img  = Transform.rotate(angle: widget.rotationAngle, child:widget.frontSide);
      img  = RotatedBox(quarterTurns:  widget.rotationAngle/(pi/2) as int, child:widget.frontSide);
    }

    return img;
  }

}


class FlippableImageController extends ChangeNotifier{
  late AnimationController _animationController;
  late Animation _animation;
  late Size _imageSize;
  Function? onFlipped;
  AnimationStatus _status = AnimationStatus.dismissed;

  AnimationController get animationController => _animationController;
  Animation get animation => _animation;
  Size get imageSize => _imageSize;

  void initAnimation(TickerProvider tickerProvider, Size imageSize) {
    _imageSize = imageSize;

    _animationController =
        AnimationController(vsync: tickerProvider, duration: const Duration(milliseconds: 500));
    _status = AnimationStatus.dismissed;
    _animation = Tween(end: 1.0, begin: 0.0).animate(_animationController)
      ..addListener(() {
        notifyListeners();
      })
      ..addStatusListener((status) {
        _status = status;
        if(status == AnimationStatus.completed && onFlipped != null) {
          onFlipped!();
        }
      });
  }
  void flip() {
    _animationController.forward();
  }
}