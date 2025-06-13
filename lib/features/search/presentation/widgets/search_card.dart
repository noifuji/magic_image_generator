import 'package:flutter/material.dart';
import 'package:magic_image_generator/features/search/domain/entity/card_info_header.dart';
import 'package:magic_image_generator/core/widgets/flippable_image.dart';
import 'package:magic_image_generator/core/widgets/overlay_flippable_image.dart';
import 'package:magic_image_generator/core/widgets/web_image.dart';
import 'package:provider/provider.dart';

import '../viewmodel/canvas_view_model.dart';
import '../viewmodel/search_view_model.dart';

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
    _fiController = FlippableImageController(
        initialRotationValue: widget.card.isFront ? 0 : 1);
  }

  @override
  Widget build(BuildContext context) {
    Widget frontImage;
    Widget? backImage;
    List<Widget> overlays = [];

    if (widget.card.isTransform && widget.card.cardFaces.length > 1) {
      overlays.add(_createFlipButton());

      final firstUrl =
          widget.card.firstFace.imageUrlLocale(Localizations.localeOf(context));
      final secondUrl = widget.card.secondFace!
          .imageUrlLocale(Localizations.localeOf(context));

      frontImage = WebImage(
        url: firstUrl,
        controller: widget.card.firstFace.webImageController!,
        placeHolder: _createDefaultCard(),
        errorBuilder: (context, error, stacktrace) =>
            _createErrorCard(firstUrl),
      );
      backImage = WebImage(
        url: secondUrl,
        controller: widget.card.secondFace!.webImageController!,
        placeHolder: _createDefaultCard(),
        errorBuilder: (context, error, stacktrace) =>
            _createErrorCard(secondUrl),
      );
    } else {
      final firstUrl =
          widget.card.firstFace.imageUrlLocale(Localizations.localeOf(context));
      frontImage = WebImage(
        url: firstUrl,
        controller: widget.card.firstFace.webImageController!,
        placeHolder: _createDefaultCard(),
        errorBuilder: (context, error, stacktrace) =>
            _createErrorCard(firstUrl),
      );
    }

    bool isInCanvas =
        Provider.of<CanvasViewModel>(context).isInCanvas(widget.card);
    return Container(
      foregroundDecoration: BoxDecoration(
        color: Colors.black.withOpacity(isInCanvas ? 0.4 : 0),
        //backgroundBlendMode: BlendMode.srcATop,
      ),
      child: OverlayFlippableImage(
        width: widget.card.imageSize.width,
        height: widget.card.imageSize.height,
        rotationAngle: widget.card.rotationAngle,
        frontSide: frontImage,
        controller: _fiController,
        backSide: backImage,
        overlays: overlays,
        onFlipped: (isBegin) {
          Provider.of<SearchViewModel>(context, listen: false)
              .flip(card: widget.card, toFront: isBegin);
        },
      ),
    );
  }

  Widget _createDefaultCard() {
    return Container(
      width: widget.card.imageSize.width,
      height: widget.card.imageSize.height,
      decoration: const BoxDecoration(color: Colors.white10),
    );
  }

  Widget _createErrorCard(String url) {
    return Container(
      width: widget.card.imageSize.width,
      height: widget.card.imageSize.height,
      decoration: const BoxDecoration(color: Colors.white10),
      child: Center(
        child: Column(
          children: [
            Text(
              "カード画像取得に失敗しました。",
              style: TextStyle(
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
            TextButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
              onPressed: () {
                widget.card.firstFace.webImageController!.fetchImage(url);
              },
              child: Text(
                "再取得",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
          ],
        ),
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
              onPressed: () => _fiController.flip()),
        ),
      ),
    );
  }
}
