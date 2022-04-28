import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:isar/isar.dart';
import 'package:magic_image_generator/view/canvas_view_screen.dart';
import 'package:magic_image_generator/view/search_view_screen.dart';
import 'package:magic_image_generator/viewmodel/canvas_view_model.dart';
import 'package:magic_image_generator/viewmodel/search_view_model.dart';
import 'package:provider/provider.dart';

import './assets/constants.dart' as constants;
import 'assets/util.dart';
import 'data/card.dart';
import 'data/card_fetch_csv_api.dart';
import 'data/card_local_data_source.dart';
import 'data/card_remote_data_source.dart';
import 'data/card_repository_impl.dart';
import 'domain/card_repository.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/*
 * ・検索機能が不安定
 * ・テキスト検索でオペレーターをつかえない
 * ・「t:creature -t:encha -t:arti pow=4」おかしい
 * ・color指定
 * ・両面札　scryfallからmultiverseを2種とってひもつけをつくる ->ok
 * 　　第一面ヒット　そのまま出す
 * 　　第二面ヒット　第一面をかわりに出す
 * 　　両方ヒット　　第一面のみをだす
 * ・スマホ対応
 * ・画像データ収集後、自鯖配布 -> ok
 * ・ヒット件数表示
 *　・画像データ読み込み中になんか出す
 *
 */

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();

  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  late Locale _locale;

  void setLocale(Locale value) {
    setState(() {
      _locale = value;
    });
  }

  @override
  void initState() {
    super.initState();
    setLocale(const Locale.fromSubtags(languageCode: 'ja'));
  }

  @override
  Widget build(BuildContext context) {
    Util.printTimeStamp("_MyAppState build");
    return MaterialApp(
      title: 'Magic Image Generator',
      locale: _locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ja', ''), //日本語
        Locale('en', ''), //英語
      ],
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.dark,
      home: const MyHomePage(title: 'Magic Image Generator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _localeSwitch = false;
  late Future<CardRepository> _initialize;
  SearchViewModel? _searchViewModel;
  CanvasViewModel? _canvasViewModel;


  @override
  void initState() {
    super.initState();
    _initialize = initializeApp();
  }

  Future<CardRepository> initializeApp() async {
    Util.printTimeStamp("_MyHomePageState initializeApp");
    var isar = Isar.getInstance();
    if (isar == null || !isar.isOpen) {
      isar = await Isar.open(
        schemas: [CardSchema],
      );
    }

    CardLocalDataSource localDataSource = CardLocalDataSource(isar);
    CardRemoteDataSource remoteDataSource =
        CardRemoteDataSource(CardFetchCsvApi());
    CardRepository repo = CardRepositoryImpl(localDataSource, remoteDataSource);
    await repo.init();

    return Future<CardRepository>.value(repo);
  }

  @override
  Widget build(BuildContext context) {
    Util.printTimeStamp("_MyHomePageState build");
    return FutureBuilder<CardRepository>(
        future: _initialize,
        builder: (context, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return  const Center();
          } else if (dataSnapshot.error != null) {
            if (kDebugMode) {
              print(dataSnapshot.error);
            }
            return Text(AppLocalizations.of(context)!.errorReload);
          } else {
            Util.printTimeStamp("_MyHomePageState Scaffold");
            _searchViewModel = _searchViewModel?? SearchViewModel(dataSnapshot.data!);
            _canvasViewModel = _canvasViewModel?? CanvasViewModel();
            return MultiProvider(
                providers: [
                  ChangeNotifierProvider.value(
                      value: _searchViewModel),
                  ChangeNotifierProvider.value(value: _canvasViewModel),
                ],
                child: Scaffold(
                  appBar: AppBar(
                    title: Text(AppLocalizations.of(context)!.appTitle),
                    actions: [
                      Switch(
                          value: _localeSwitch,
                          onChanged: (value) {
                            if (value) {
                              MyApp.of(context)?.setLocale(
                                  const Locale.fromSubtags(languageCode: 'en'));
                            } else {
                              MyApp.of(context)?.setLocale(
                                  const Locale.fromSubtags(languageCode: 'ja'));
                            }

                            setState(() {
                              _localeSwitch = value;
                            });
                          })
                    ],
                  ),
                  body:
                      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Expanded(
                        flex: constants.searchViewRatio,
                        child: SearchViewScreen()),
                    Expanded(
                        flex: constants.canvasViewRatio,
                        child: CanvasViewScreen())
                  ]),
                ));
          }
        });
  }
}
