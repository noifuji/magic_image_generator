// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic_image_generator/common/search_filter.dart';
import 'package:magic_image_generator/common/search_filter_factory.dart';
import 'package:magic_image_generator/domain/analyze_filter_usecase.dart';
import 'package:magic_image_generator/domain/analyze_query_usecase.dart';
import 'package:magic_image_generator/domain/relational_operator_type.dart';
import 'package:magic_image_generator/domain/search_condition.dart';
import 'package:magic_image_generator/domain/search_keyword_type.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class LocalizationsInj extends StatelessWidget {
  final Widget child;
  const LocalizationsInj({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: child,
    );
  }
}

void main() {
  testWidgets('False flags return empty query.', (WidgetTester tester) async {
    await tester.pumpWidget(
        LocalizationsInj(child:
      Builder(
        builder: (BuildContext context) {
          Map<SearchFilter, bool> searchFilters = {};
          for(var v in SearchFilter.values) {
            searchFilters[v] = false;
          }

          List<SearchFilterData> filterDataList = searchFilters.keys.map((e) => SearchFilterFactory.createSearchFilter(context, e)).toList();
          var analyzer = AnalyzeFilterUseCase();
          var result = analyzer.call(searchFilters, filterDataList);

          expect(result, "");

          // The builder function must return a widget.
          return const Placeholder();
        },
      ),)
    );
  });

  testWidgets('True artifact flag returns an artifact query.', (WidgetTester tester) async {
    await tester.pumpWidget(
        LocalizationsInj(child:
      Builder(
        builder: (BuildContext context) {
          Map<SearchFilter, bool> searchFilters = {};
          for(var v in SearchFilter.values) {
            if(v == SearchFilter.typeArtifact) {
              searchFilters[v] = true;
            } else {
              searchFilters[v] = false;
            }
          }

          List<SearchFilterData> filterDataList = searchFilters.keys.map((e) => SearchFilterFactory.createSearchFilter(context, e)).toList();
          var analyzer = AnalyzeFilterUseCase();
          var result = analyzer.call(searchFilters, filterDataList);

          expect(result, "( (t:artifact ))");

          // The builder function must return a widget.
          return const Placeholder();
        },
      ),)
    );
  });

  testWidgets('Multiple true flags return multiple queries.', (WidgetTester tester) async {
    await tester.pumpWidget(
        LocalizationsInj(child:
        Builder(
          builder: (BuildContext context) {
            Map<SearchFilter, bool> searchFilters = {};
            for(var v in SearchFilter.values) {
                searchFilters[v] = false;
            }

            searchFilters[SearchFilter.manaValue1] = true;
            searchFilters[SearchFilter.colorRed] = true;
            searchFilters[SearchFilter.colorBlue] = true;
            searchFilters[SearchFilter.colorMulti] = true;

            List<SearchFilterData> filterDataList = searchFilters.keys.map((e) => SearchFilterFactory.createSearchFilter(context, e)).toList();
            var analyzer = AnalyzeFilterUseCase();
            var result = analyzer.call(searchFilters, filterDataList);

            expect(result, "( (c:u and c:r and c:m ) (cmc=1 ))");

            // The builder function must return a widget.
            return const Placeholder();
          },
        ),)
    );
  });

}
