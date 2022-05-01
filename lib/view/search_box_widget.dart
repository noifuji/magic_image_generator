import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../viewmodel/search_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchBoxWidget extends StatefulWidget {
  int responsiveColumns;
  double responsiveColumnWidth;
  double responsiveGutterWidth;

  SearchBoxWidget(
      {required this.responsiveColumns,
      required this.responsiveColumnWidth,
      required this.responsiveGutterWidth});

  @override
  State<StatefulWidget> createState() => _SearchBoxWidgetState();
}

class _SearchBoxWidgetState extends State<SearchBoxWidget> {
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        width: widget.responsiveColumnWidth * widget.responsiveColumns +
            widget.responsiveGutterWidth * (widget.responsiveColumns - 1),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary.withAlpha(50),
          borderRadius: BorderRadius.circular(30.0),
        ),
        child:
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
          Padding(
              padding: EdgeInsets.only(
                left: widget.responsiveColumnWidth * 0.3,
              ),
              child: SizedBox(
                  width: widget.responsiveColumnWidth *
                          (widget.responsiveColumns - 2) +
                      widget.responsiveGutterWidth *
                          (widget.responsiveColumns - 3),
                  child: TextField(
                    controller: myController,
                    decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.searchCardHint,
                        border: InputBorder.none),
                    autofocus: false,
                    onSubmitted: (value) async {
                      await Provider.of<SearchViewModel>(context, listen: false)
                          .search(value, Localizations.localeOf(context));
                    },
                  ))),
          Padding(
              padding: EdgeInsets.only(
                right: widget.responsiveColumnWidth * 0.1,
              ),
              child: SizedBox(
                  width: widget.responsiveColumnWidth * 0.5,
                  child: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () async {
                      await Provider.of<SearchViewModel>(context, listen: false)
                          .search(myController.text,
                              Localizations.localeOf(context));
                    },
                  ))),
        ]));
  }
}
