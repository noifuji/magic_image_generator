import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:magic_image_generator/model/card_info_header.dart';
import 'package:magic_image_generator/view/widgets/overlay_flippable_image.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import '../assets/constants.dart' as constants;
import '../viewmodel/canvas_view_model.dart';

class CanvasCard extends StatefulWidget {
  late CardInfoHeader card;
  late double scale;

  CanvasCard({
    Key? key,
    required this.card,
    required this.scale
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CanvasCardState();
}

class _CanvasCardState extends State<CanvasCard> {
  late OverlayFlippableImageController _ofiController;


  @override
  void initState() {
    super.initState();
    _ofiController = OverlayFlippableImageController();

  }

  @override
  Widget build(BuildContext context) {
    var selectedCards = Provider.of<CanvasViewModel>(context).selectedCards;
    int rowIndex = selectedCards.indexWhere((row) => row
        .where((card) => card.displayId == widget.card.displayId)
        .toList()
        .isNotEmpty);

    if(rowIndex < 0) {
      return const SizedBox.shrink();
    }

    int colIndex = selectedCards[rowIndex]
        .indexWhere((card) => card.displayId == widget.card.displayId);

    Image frontImage;
    Image? backImage;
    List<Widget> overlays = [_createRemoveButton()];


    if(widget.card.isTransform) {
      overlays.add(_createFlipButton());

      if (widget.card.isFront) {
        frontImage =
            Image.network(widget.card.firstFace.imageUrlLocale(Localizations.localeOf(context)));
        backImage =
            Image.network(widget.card.secondFace!.imageUrlLocale(Localizations.localeOf(context)));
      } else {
        frontImage =
            Image.network(widget.card.secondFace!.imageUrlLocale(Localizations.localeOf(context)));
        backImage =
            Image.network(widget.card.firstFace.imageUrlLocale(Localizations.localeOf(context)));
      }
    } else {
      frontImage = Image.network(widget.card.firstFace.imageUrlLocale(Localizations.localeOf(context)));
    }

    return Draggable<Map<String, int>>(
        data: {"row": rowIndex, "col": colIndex},
        child: OverlayFlippableImage(
          width: constants.rawCardImageWidth * widget.scale,
          frontSide: frontImage,
          controller: _ofiController,
          backSide: backImage,
          onFlipped: () =>
            Provider.of<CanvasViewModel>(context, listen: false).flip(widget.card),
          overlays: overlays,
        ),
        feedback: SizedBox(
          width: constants.rawCardImageWidth * widget.scale,
          child: frontImage,
        ),
        childWhenDragging: SizedBox(
            width: constants.rawCardImageWidth * widget.scale,
            child: Image.memory(kTransparentImage)));
  }

  Widget _createRemoveButton() {
    return Container(
      width: 30.0 * widget.scale,
      height: 30.0 * widget.scale,
      margin:
          EdgeInsets.only(top: 10.0 * widget.scale, left: 10.0 * widget.scale),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withAlpha(200),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        padding: const EdgeInsets.all(0.0),
        alignment: Alignment.center,
        icon: Icon(
          Icons.close_rounded,
          size: 20.0 * widget.scale,
        ),
        color: Theme.of(context).colorScheme.onPrimary,
        onPressed: () => Provider.of<CanvasViewModel>(context, listen: false)
            .removeCard(widget.card),
      ),
    );
  }

  Widget _createFlipButton() {
    return Positioned.fill(
        child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 30.0 * widget.scale,
              height: 30.0 * widget.scale,
              margin: const EdgeInsets.only(),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withAlpha(200),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                padding: const EdgeInsets.all(0.0),
                alignment: Alignment.center,
                icon: Icon(
                  Icons.autorenew,
                  size: 20.0 * widget.scale,
                ),
                color: Theme.of(context).colorScheme.onPrimary,
                onPressed: () => _ofiController.flip()),
                    //Provider.of<CanvasViewModel>(context, listen: false).flip(widget.card), //provider
              ),
            ));
  }
}
