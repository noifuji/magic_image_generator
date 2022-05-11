import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:magic_image_generator/model/card_info_header.dart';
import 'package:transparent_image/transparent_image.dart';

import 'flippable_image.dart';

class OverlayFlippableImage extends StatefulWidget {
  late double width;
  late Image frontSide;
  Image? backSide;
  List<Widget>? overlays;
  Function? onFlipped;
  OverlayFlippableImageController controller;

  OverlayFlippableImage({
    Key? key,
    required this.frontSide,
    required this.width,
    required this.controller,
    this.backSide,
    this.overlays,
    this.onFlipped,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _OverlayFlippableImageState();
}

class _OverlayFlippableImageState extends State<OverlayFlippableImage> {
  bool _isMouseOn = false;
  late FlippableImageController _fIController;

  @override
  void initState() {
    super.initState();
    _fIController = FlippableImageController();

    widget.controller.state = this;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> stacks = [
      Align(
          alignment: Alignment.topCenter,
          child: FlippableImage(
            frontSide: widget.frontSide,
            backSide: widget.backSide,
            width: widget.width,
            onFlipped: widget.onFlipped,
            controller: _fIController,
          ))
    ];

    if (widget.overlays != null && _isMouseOn) {
      stacks.addAll(widget.overlays!);
    }

    return SizedBox(
      width: widget.width,
      child: MouseRegion(
        onEnter: (details) => setState(() {
          _isMouseOn = true;
        }),
        onExit: (details) => setState(() {
          _isMouseOn = false;
        }),
        child: Stack(children: stacks),
      ),
    );
  }

  void flip() {
    _fIController.flip();
  }
}

class OverlayFlippableImageController {
  _OverlayFlippableImageState? state;

  void flip() => state?.flip();
}
