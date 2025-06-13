import 'package:flutter/cupertino.dart';

import 'flippable_image.dart';

class OverlayFlippableImage extends StatefulWidget {
  final double width;
  final double height;
  final double rotationAngle;
  final Widget frontSide;
  final Widget? backSide;
  final List<Widget>? overlays;
  final FlippableImageController controller;
  final Function(bool isBegin)? onFlipped;

  const OverlayFlippableImage({
    Key? key,
    required this.width,
    required this.height,
    required this.frontSide,
    this.backSide,
    this.overlays,
    required this.controller,
    this.onFlipped,
    required this.rotationAngle,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _OverlayFlippableImageState();
}

class _OverlayFlippableImageState extends State<OverlayFlippableImage> {
  @override
  Widget build(BuildContext context) {
    List<Widget> stacks = [
      Align(
          alignment: Alignment.topCenter,
          child: FlippableImage(
            frontSide: widget.frontSide,
            backSide: widget.backSide,
            width: widget.width,
            height: widget.height,
            rotationAngle: widget.rotationAngle,
            controller: widget.controller,
            onFlipped: widget.onFlipped,
          ))
    ];

    stacks.addAll(widget.overlays!);

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Stack(children: stacks),
    );
  }
}
