import 'package:flutter/material.dart';
import 'package:magic_image_generator/model/card_info_header.dart';
import 'package:magic_image_generator/view/widgets/flippable_image.dart';
import 'package:magic_image_generator/view/widgets/overlay_flippable_image.dart';
import 'package:provider/provider.dart';

import '../viewmodel/canvas_view_model.dart';

class SearchCard extends StatefulWidget {
  final CardInfoHeader card;
  final double scale;

  const SearchCard({
    Key? key,
    required this.card,
    required this.scale,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchCardState();
}

class _SearchCardState extends State<SearchCard> {
  late final FlippableImageController _fiController;


  @override
  void initState() {
    super.initState();
    _fiController = FlippableImageController();

  }

  @override
  Widget build(BuildContext context) {
    Image frontImage;
    Image? backImage;
    List<Widget> overlays = [];


    if(widget.card.isTransform && widget.card.cardFaces.length > 1) {
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

    bool isInCanvas = Provider.of<CanvasViewModel>(context).isInCanvas(widget.card);
    return Container(
        foregroundDecoration: BoxDecoration(
          color: Colors.black.withOpacity(isInCanvas ? 0.4 : 0),
          //backgroundBlendMode: BlendMode.srcATop,
        ),
        child:OverlayFlippableImage(
          width: widget.card.imageSize.width,
          height: widget.card.imageSize.height,
          rotationAngle: widget.card.rotationAngle,
          frontSide: frontImage,
          controller: _fiController,
          backSide: backImage,
          overlays: overlays,
          onFlipped: ()=> Provider.of<CanvasViewModel>(context, listen: false).flip(widget.card),
        ));
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
                onPressed: () => _fiController.flip()),
          ),
        ));
  }
}
