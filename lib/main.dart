import 'dart:async';

import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:isar/isar.dart';
import 'package:magic_image_generator/view/canvas_view_screen.dart';
import 'package:magic_image_generator/view/search_view_screen.dart';
import 'package:magic_image_generator/viewmodel/canvas_view_model.dart';
import 'package:magic_image_generator/viewmodel/search_view_model.dart';
import 'package:provider/provider.dart';

import './assets/configure_nonweb.dart'
    if (dart.library.html) './assets/configure_web.dart';
import './assets/constants.dart' as constants;
import 'assets/util.dart';
import 'data/card.dart';
import 'data/card_fetch_csv_api.dart';
import 'data/card_local_data_source.dart';
import 'data/card_master_version.dart';
import 'data/card_remote_data_source.dart';
import 'data/card_repository_impl.dart';
import 'domain/card_repository.dart';

/*
 * ・両面札　scryfallからmultiverseを2種とってひもつけをつくる ->ok
 * ・画像データ収集後、自鯖配布 -> ok
 * ・#形式やめる -> ok
 * ・copy -> ok
 *　・index.html -> ok
 * ・ロード遅すぎる。->ok
 * ・左から並び替えられない -> ok
 * ・スマホ対応 -> ok
 * ・「t:creature -t:encha -t:arti pow=4」おかしい ->ok
 * ・color指定
 * 　　white blue black red green colorless multicolor ->ok
 * 　　略称　w, u, b, r, g, c, m, multi
 * 　　多色を指定できる rgは赤緑 grも化
 * 　　多色指定は略称のみ指定可能
 * ・キャンバスで複数行 -> ok
 * ・スマホナビゲーション -> ok
 * ・コピー成功時にエフェクト->ok
 * ・両面カードクルクル -> ok
 * ・キャンバスから画像削除 -> ok
 * ・スマホでコピーできない->ok
 * ・スマホにダウンロードボタンない -> ok
 * ・並び替え機能 -> ok
 * ・ヒット件数表示 -> ok
 *
 * ・テキスト検索でオペレーターをつかえない
 * ・大量に画像いれると余白がマイナスになる。
 * ・キャンバスで右端移動できない
 * ・CanvasScreen汚すぎ
 * ・ソート順でオーバーフロー
 *
 *　・画像データ読み込み中になんか出す
 * ・スマホのときは検索ボックス下へ(検索ボックス位置オプションをsearchScreeenにつける。)
 * ・クエリ入力補助(プルダウンで選択できる　o:xxx オラクル　c:xxx 色指定など)
 * ・検索失敗メッセージ
 * ・画像データ履歴保持
 * ・アリーナっぽい検索画面
 * ・カード移動時のエフェクト
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
          brightness: Brightness.dark, fontFamily: "NotoSansJP-Regular"),
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
  int _selectedIndex = 0;
  bool _localeSwitch = false;
  late Future<CardRepository> _initialize;
  SearchViewModel? _searchViewModel;
  CanvasViewModel? _canvasViewModel;

  final List<Widget> _widgetOptions = <Widget>[];

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
        schemas: [CardSchema, CardMasterVersionSchema],
      );
    }

    CardLocalDataSource localDataSource = CardLocalDataSource(isar);
    CardRemoteDataSource remoteDataSource =
        CardRemoteDataSource(CardFetchCsvApi());
    CardRepository repo = CardRepositoryImpl(localDataSource, remoteDataSource);
    await repo.init();

    return Future<CardRepository>.value(repo);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
                child: LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  final _breakpoint = Breakpoint.fromConstraints(constraints);
                  int _columns = _breakpoint.columns;
                  double _gutterWidth = _breakpoint.gutters;
                  double _marginWidth = _breakpoint.gutters;
                  double _columnWidth = (constraints.maxWidth -
                          _marginWidth * 2 -
                          _gutterWidth * (_columns - 1)) /
                      _columns;

                  if (_columns > 4) {
                    return Scaffold(
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
                                  child: Container(
                                      margin: EdgeInsets.only(
                                          left: _marginWidth,
                                          right: _gutterWidth),
                                      child: SearchViewScreen(
                                        responsiveColumns: _columns ~/ 2,
                                        responsiveColumnWidth: _columnWidth,
                                        responsiveGutterWidth: _gutterWidth,
                                      ))),
                              Expanded(
                                  flex: constants.canvasViewRatio,
                                  child: Container(
                                      margin:
                                          EdgeInsets.only(right: _marginWidth),
                                      child: CanvasViewScreen(
                                        key: key,
                                        responsiveColumns: _columns ~/ 2,
                                        responsiveColumnWidth: _columnWidth,
                                        responsiveGutterWidth: _gutterWidth,
                                      )))
                            ]),
                        floatingActionButton: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                          FloatingActionButton(
                            onPressed: () async {
                              await key.currentState?.copyImageToClipBoard(context);
                              //await key.currentState?.captureImage(context);
                            },
                            tooltip: AppLocalizations.of(context)!.copy,
                            child: const Icon(Icons.copy),
                          ),

                              const SizedBox(height: 16),

                          FloatingActionButton(
                            onPressed: () async {
                              await key.currentState?.downloadImage(context);
                            },
                            tooltip: AppLocalizations.of(context)!.download,
                            child: const Icon(Icons.download),
                          ),
                        ]));
                  } else {
                    _widgetOptions.add(SearchViewScreen(
                      responsiveColumns: _columns,
                      responsiveColumnWidth: _columnWidth,
                      responsiveGutterWidth: _gutterWidth,
                    ));

                    _widgetOptions.add(CanvasViewScreen(
                      key: key,
                      responsiveColumns: _columns,
                      responsiveColumnWidth: _columnWidth,
                      responsiveGutterWidth: _gutterWidth,
                    ));

                    return Scaffold(
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
                                  child: Container(
                                      margin: EdgeInsets.only(
                                          left: _marginWidth,
                                          right: _gutterWidth),
                                      child: _widgetOptions[_selectedIndex])),
                            ]),
                        floatingActionButton: Container(
                            margin: EdgeInsets.only(bottom: 0.0),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  if (_selectedIndex == 1)
                                    FloatingActionButton(
                                      onPressed: () async {
                                        await key.currentState?.copyImageToClipBoard(context);
                                        //await key.currentState?.captureImage(context);
                                      },
                                      tooltip:
                                          AppLocalizations.of(context)!.copy,
                                      child: const Icon(Icons.copy),
                                    ),

                                  if (_selectedIndex == 1)
                                  const SizedBox(height: 16),

                                  if (_selectedIndex == 1)
                                  FloatingActionButton(
                                    onPressed: () async {
                                      await key.currentState?.downloadImage(context);
                                    },
                                    tooltip: AppLocalizations.of(context)!.download,
                                    child: const Icon(Icons.download),
                                  ),
                                ])),
                        bottomNavigationBar: BottomNavigationBar(
                          items: <BottomNavigationBarItem>[
                            BottomNavigationBarItem(
                                icon: Icon(Icons.search),
                                label: AppLocalizations.of(context)!
                                    .menuSearchCard),
                            BottomNavigationBarItem(
                                icon: Icon(Icons.style),
                                label: AppLocalizations.of(context)!
                                    .menuEditCardImage),
                          ],
                          currentIndex: _selectedIndex,
                          onTap: _onItemTapped,
                        ));
                  }
                }));
          }
        });
  }
}
