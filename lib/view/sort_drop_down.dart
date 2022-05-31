import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:magic_image_generator/viewmodel/search_view_model.dart';
import 'package:provider/provider.dart';

enum SortKey { name, cmc }
enum SortOrder {asc, dsc}

class SortDropdown extends StatefulWidget {
  late SortKey defaultSortKey;
  late SortOrder defaultSortOrder;

  SortDropdown({
    Key? key,
    required this.defaultSortKey,
    required this.defaultSortOrder,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SortDropdownState();
}

class _SortDropdownState extends State<SortDropdown> {
  late SortKey dropdownSortKeyValue;
  late SortOrder dropdownSortOrderValue;

  @override
  void initState() {
    super.initState();
    dropdownSortKeyValue = widget.defaultSortKey;
    dropdownSortOrderValue = widget.defaultSortOrder;
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
/*      Expanded(
          flex: 1,
          child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                  margin: const EdgeInsets.only(
                    right: 10.0,
                  ),
                  child: Text(AppLocalizations.of(context)!.sort)))),*/
      Expanded(
          flex: 2,
          child: DropdownButton<SortKey>(
            isExpanded: true,
            value: dropdownSortKeyValue,
            //icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            //style: TextStyle(color: Theme.of(context).colorScheme.primary),
            underline: Container(
              height: 2,
              color: Theme.of(context).colorScheme.secondary.withAlpha(50),
            ),
            onChanged: (SortKey? newValue) {
              setState(() {
                dropdownSortKeyValue = newValue!;
              });
              Provider.of<SearchViewModel>(context, listen: false)
                  .setSortKey(newValue!, Localizations.localeOf(context));
            },
            items: getSortKeys(context)
                .map<DropdownMenuItem<SortKey>>((Map<String, dynamic> value) {
              return DropdownMenuItem<SortKey>(
                value: value["value"],
                child: Text(value["text"], overflow: TextOverflow.ellipsis),
              );
            }).toList(),
          )),
      Expanded(
          flex: 2,
          child: DropdownButton<SortOrder>(
            isExpanded: true,
            value: dropdownSortOrderValue,
            //icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            underline: Container(
              height: 2,
              color: Theme.of(context).colorScheme.secondary.withAlpha(50),
            ),
            onChanged: (SortOrder? newValue) {
              setState(() {
                dropdownSortOrderValue = newValue!;
              });
              Provider.of<SearchViewModel>(context, listen: false)
                  .setSortOrder(newValue!, Localizations.localeOf(context));
            },
            items: getSortOrders(context)
                .map<DropdownMenuItem<SortOrder>>((Map<String, dynamic> value) {
              return DropdownMenuItem<SortOrder>(
                value: value["value"],
                child: Text(value["text"], overflow: TextOverflow.ellipsis),

              );
            }).toList(),
          ))
    ]);
  }

  List<Map<String, dynamic>> getSortKeys(BuildContext context) {
    return [
      {"value": SortKey.name, "text": AppLocalizations.of(context)!.name},
      {"value": SortKey.cmc, "text": AppLocalizations.of(context)!.cmc},
    ];
  }

  List<Map<String, dynamic>> getSortOrders(BuildContext context) {
    return [
      {"value": SortOrder.asc, "text": AppLocalizations.of(context)!.asc},
      {"value": SortOrder.dsc, "text": AppLocalizations.of(context)!.dsc},
    ];
  }
}
