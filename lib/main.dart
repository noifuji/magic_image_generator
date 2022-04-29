import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
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

import './assets/configure_nonweb.dart' if (dart.library.html) './assets/configure_web.dart';


/*
 * ・両面札　scryfallからmultiverseを2種とってひもつけをつくる ->ok
 * ・画像データ収集後、自鯖配布 -> ok
 * ・#形式やめる -> ok
 *
 * ・アリーナっぽい検索画面
 * ・検索機能が不安定
 * ・テキスト検索でオペレーターをつかえない
 * ・「t:creature -t:encha -t:arti pow=4」おかしい
 * ・color指定
 * 　white blue black red green colorless multicolor
 * 　略称　w, u, b, r, g, c, m, multi
 * 　多色を指定できる rgは赤緑 grも化
 * 　多色指定は略称のみ指定可能
 * ・検索失敗メッセージ
 * ・スマホ対応
 * ・ヒット件数表示
 *　・画像データ読み込み中になんか出す
 * ・ロード遅すぎる。
 * ・keyの謎
 * ・キャンバスで複数行
 * ・カード移動時のエフェクト
 * ・コピー成功時にエフェクト
 *
 */

final key = GlobalKey<CanvasViewScreenState>();

void main() {
  configureApp();
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

    if (WidgetsBinding.instance != null) {
      final List<Locale> systemLocales =
          WidgetsBinding.instance!.window.locales;
      _locale = systemLocales.first;
    } else {
      _locale = AppLocalizations.supportedLocales.first;
    }
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
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
          brightness: Brightness.light, fontFamily: "NotoSansJP-Regular"),
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
    Util.printTimeStamp("_MyHomePageState build start");
    return FutureBuilder<CardRepository>(
        future: _initialize,
        builder: (context, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            Util.printTimeStamp("_MyHomePageState build waiting");
            return const Center();
          } else if (dataSnapshot.error != null) {
            if (kDebugMode) {
              print(dataSnapshot.error);
            }
            return Text(AppLocalizations.of(context)!.errorReload);
          } else {
            Util.printTimeStamp("_MyHomePageState Scaffold");
            _searchViewModel =
                _searchViewModel ?? SearchViewModel(dataSnapshot.data!);
            _canvasViewModel = _canvasViewModel ?? CanvasViewModel();
            return MultiProvider(
                providers: [
                  ChangeNotifierProvider.value(value: _searchViewModel),
                  ChangeNotifierProvider.value(value: _canvasViewModel),
                ],
                child: Scaffold(
                  appBar: AppBar(
                    title: Text(AppLocalizations.of(context)!.appTitle),
                    actions: [
                      Switch(
                          value: _localeSwitch,
                          onChanged: (value) {
                            MyApp.of(context)?.setLocale(AppLocalizations
                                .supportedLocales
                                .firstWhere((element) =>
                                    element.languageCode !=
                                    Localizations.localeOf(context)
                                        .languageCode));
                            setState(() {
                              _localeSwitch = value;
                            });
                          })
                    ],
                  ),
                  body: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: constants.searchViewRatio,
                            child: SearchViewScreen()),
                        Expanded(
                            flex: constants.canvasViewRatio,
                            child: CanvasViewScreen(key: key))
                      ]),
                  floatingActionButton: FloatingActionButton(
                    onPressed: () async {
                      await key.currentState?.copyImageToClipBoard();
                    },
                    tooltip: 'Copy',
                    child: const Icon(Icons.copy),
                  ), // ,
                ));
          }
        });
  }
}
