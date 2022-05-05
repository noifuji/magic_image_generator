import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:magic_image_generator/model/card_info_header.dart';
import 'package:magic_image_generator/view/widgets/overlay_flippable_image.dart';
import 'package:magic_image_generator/viewmodel/search_view_model.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import '../assets/constants.dart' as constants;
import '../viewmodel/canvas_view_model.dart';

class SearchCard extends StatefulWidget {
  late CardInfoHeader card;
  late double scale;

  SearchCard({
    Key? key,
    required this.card,
    required this.scale
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchCardState();
}

class _SearchCardState extends State<SearchCard> {
  late OverlayFlippableImageController _ofiController;


  @override
  void initState() {
    super.initState();
    _ofiController = OverlayFlippableImageController();

  }

  @override
  Widget build(BuildContext context) {
    Image frontImage;
    Image? backImage;
    List<Widget> overlays = [];


    if(widget.card.isTransform) {
      overlays.add(_createFlipButton());

      if (widget.card.isFront) {
        frontImage =
            Image.network(widget.card.firstFace.imageUrlLocale(context));
        backImage =
            Image.network(widget.card.secondFace!.imageUrlLocale(context));
      } else {
        frontImage =
            Image.network(widget.card.secondFace!.imageUrlLocale(context));
        backImage =
            Image.network(widget.card.firstFace.imageUrlLocale(context));
      }
    } else {
      frontImage = Image.network(widget.card.firstFace.imageUrlLocale(context));
    }

    return OverlayFlippableImage(
          width: constants.rawCardImageWidth * widget.scale,
          frontSide: frontImage,
          controller: _ofiController,
          backSide: backImage,
          onFlipped: () =>
              Provider.of<SearchViewModel>(context, listen: false).flip(widget.card),
          overlays: overlays,
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
          ),
        ));
  }
}
