import 'dart:async';

import 'package:breakpoint/breakpoint.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:magic_image_generator/view/canvas_view_screen.dart';
import 'package:magic_image_generator/view/donate_screen.dart';
import 'package:magic_image_generator/view/search_view_screen.dart';
import 'package:magic_image_generator/view/widgets/kofi_button_nonweb.dart'
    if (dart.library.html) 'package:magic_image_generator/view/widgets/kofi_button_web.dart';
import 'package:magic_image_generator/view/widgets/language_drop_down_list.dart';
import 'package:magic_image_generator/view/widgets/progress_bar.dart';
import 'package:magic_image_generator/viewmodel/app_language.dart';
import 'package:magic_image_generator/viewmodel/canvas_view_model.dart';
import 'package:magic_image_generator/viewmodel/search_view_model.dart';
import 'package:provider/provider.dart';

import './common/configure_nonweb.dart'
    if (dart.library.html) './common/configure_web.dart';
import './common/constants.dart' as constants;
import 'common/util.dart';
import 'data/card_fetch_csv_api.dart';
import 'data/card_memory_datasource.dart';
import 'data/card_remote_data_source.dart';
import 'data/card_repository_impl.dart';
import 'data/data_source.dart';
import 'domain/card_repository.dart';
import 'firebase_options.dart';

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
 * ・言語設定の保存 ->ok
 * ・検索エラーでメッセージ表示 -> ok
 * ・アイコンがない->ok
 * ・ソート順でオーバーフロー -> ok
 * ・使い方 -> ok
 * ・スマホでけせない -> ok
 * ・日本語名のソートがきかない -> ok
 * ・Edit Imageいったらクエリ消えてる問題 -> ok
 * ・カード移動時のエフェクト->OK
 * ・o:oがおそい -> ok
 * ・コンタクト&寄付 -> ok
 * ・アリーナっぽい検索画面->ok
 * ・エラーメッセージでない
 *　・画像データ読み込み中になんか出す
 *
 * ・かっこつける
 * ・テキスト検索でオペレーターをつかえない
 * ・大量に画像いれると余白がマイナスになる。
 * ・キャンバスで右端移動できない
 * ・CanvasScreen汚すぎ
 *
 * ・スマホのときは検索ボックス下へ(検索ボックス位置オプションをsearchScreeenにつける。)
 * ・クエリ入力補助(プルダウンで選択できる　o:xxx オラクル　c:xxx 色指定など)
 * ・画像データ履歴保持
 * ・シェア機能
 */

final key = GlobalKey<CanvasViewScreenState>();

Future<void> main() async {
  configureApp();

  if (Util.getCurrentEnvironment() == constants.Environment.production) {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();

  static MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<MyAppState>();
}

class MyAppState extends State<MyApp> {
  late ProgressBarController _progressController;
  late Future<CardRepository> _initAppFuture;
  late final SearchViewModel _searchViewModel;
  late final CanvasViewModel _canvasViewModel;
  final AppLanguage _appLanguage = AppLanguage();

  @override
  void initState() {
    super.initState();
    _initAppFuture = _initApp();
  }

  Future<CardRepository> _initApp() async {
    Util.printTimeStamp("_MyAppState _initApp");
    _progressController = ProgressBarController(
        Progress(progressValue: 0, taskName: "Initialize Languages"));
    await _appLanguage.loadLocale();

    DataSource localDataSource = CardMemoryDataSource();
    CardRemoteDataSource remoteDataSource =
        CardRemoteDataSource(CardFetchCsvApi());
    CardRepository repo = CardRepositoryImpl(localDataSource, remoteDataSource);
    await repo.init(
        onProgress: (value, task) => _progressController.value =
            Progress(progressValue: 0.5 + 0.5 * value, taskName: task));

    _searchViewModel = SearchViewModel(repo);
    _canvasViewModel = CanvasViewModel();

    _progressController.value = Progress(progressValue: 1.0, taskName: "");

    return Future<CardRepository>.value(repo);
  }

  @override
  Widget build(BuildContext context) {
    Util.printTimeStamp("_MyAppState build");
    return FutureBuilder<CardRepository>(
        future: _initAppFuture,
        builder: (context, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            Util.printTimeStamp("_MyHomePageState build waiting");
            return MaterialApp(
                onGenerateTitle: (context) =>
                    AppLocalizations.of(context)!.appTitle,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: AppLocalizations.supportedLocales,
                theme: ThemeData(
                    brightness: Brightness.dark,
                    fontFamily: "NotoSansJP-Regular"),
                darkTheme: ThemeData(
                    brightness: Brightness.dark,
                    fontFamily: "NotoSansJP-Regular"),
                themeMode: ThemeMode.dark,
                home: Row(children: [
                  const Expanded(flex: 1, child: SizedBox.shrink()),
                  Expanded(
                      flex: 1,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ProgressBar(
                              controller: _progressController,
                            )
                          ])),
                  const Expanded(flex: 1, child: SizedBox.shrink()),
                ]));
          } else if (dataSnapshot.error != null) {
            debugPrint(dataSnapshot.error.toString());
            debugPrint(dataSnapshot.stackTrace.toString());
            return MaterialApp(
              onGenerateTitle: (context) =>
                  AppLocalizations.of(context)!.appTitle,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: AppLocalizations.supportedLocales,
              theme: ThemeData(
                  brightness: Brightness.dark,
                  fontFamily: "NotoSansJP-Regular"),
              darkTheme: ThemeData(
                  brightness: Brightness.dark,
                  fontFamily: "NotoSansJP-Regular"),
              themeMode: ThemeMode.dark,
              home: Builder(
                builder: (context) => Scaffold(
                  body: Center(
                    child: Text(AppLocalizations.of(context)!.errorReload),
                  ),
                ),
              ),
            );
          } else {
            return MultiProvider(
                providers: [
                  ChangeNotifierProvider.value(value: _searchViewModel),
                  ChangeNotifierProvider.value(value: _canvasViewModel),
                  ChangeNotifierProvider.value(value: _appLanguage),
                ],
                child: Builder(
                    builder: (context) => GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        child: MaterialApp(
                          onGenerateTitle: (context) =>
                              AppLocalizations.of(context)!.appTitle,
                          locale: Provider.of<AppLanguage>(context).appLocale,
                          localizationsDelegates: const [
                            AppLocalizations.delegate,
                            GlobalMaterialLocalizations.delegate,
                            GlobalWidgetsLocalizations.delegate,
                            GlobalCupertinoLocalizations.delegate,
                          ],
                          supportedLocales: AppLocalizations.supportedLocales,
                          theme: ThemeData(
                              brightness: Brightness.dark,
                              fontFamily: "NotoSansJP-Regular"),
                          darkTheme: ThemeData(
                              brightness: Brightness.dark,
                              fontFamily: "NotoSansJP-Regular"),
                          themeMode: ThemeMode.dark,
                          home: const MyHomePage(),
                        ))));
          }
        });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Util.printTimeStamp("_MyHomePageState build start");
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final breakpoint = Breakpoint.fromConstraints(constraints);
      int columns = breakpoint.columns;
      double gutterWidth = breakpoint.gutters;
      double marginWidth = breakpoint.gutters;
      double columnWidth = (constraints.maxWidth -
              marginWidth * 2 -
              gutterWidth * (columns - 1)) /
          columns;

      if (columns > 4) {
        return Scaffold(
            appBar: AppBar(
              title: Text(AppLocalizations.of(context)!.appTitle),
              actions: const [
                KofiButton(),
                LanguageDropDownList(),
              ],
            ),
            body: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(
                  flex: constants.searchViewRatio,
                  child: Container(
                      margin: EdgeInsets.only(
                          left: marginWidth, right: gutterWidth),
                      child: SearchViewScreen(
                        responsiveColumns: columns ~/ 2,
                        responsiveColumnWidth: columnWidth,
                        responsiveGutterWidth: gutterWidth,
                      ))),
              Expanded(
                  flex: constants.canvasViewRatio,
                  child: Container(
                      margin: EdgeInsets.only(right: marginWidth),
                      child: CanvasViewScreen(
                        key: key,
                        responsiveColumns: columns ~/ 2,
                        responsiveColumnWidth: columnWidth,
                        responsiveGutterWidth: gutterWidth,
                      )))
            ]),
            floatingActionButton:
                Column(mainAxisSize: MainAxisSize.min, children: [
              FloatingActionButton(
                heroTag: "copy",
                onPressed: () async {
                  await copyImageToClipBoard();

                  if (Util.getCurrentEnvironment() ==
                      constants.Environment.production) {
                    await FirebaseAnalytics.instance
                        .logEvent(name: "click_copy_button");
                  }
                },
                tooltip: AppLocalizations.of(context)!.copy,
                child: const Icon(Icons.copy),
              ),
              const SizedBox(height: 16),
              FloatingActionButton(
                heroTag: "download",
                onPressed: () async {
                  await downloadImage();

                  if (Util.getCurrentEnvironment() ==
                      constants.Environment.production) {
                    await FirebaseAnalytics.instance
                        .logEvent(name: "click_download_button");
                  }
                },
                tooltip: AppLocalizations.of(context)!.download,
                child: const Icon(Icons.download),
              ),
            ]));
      } else {
        _widgetOptions.add(SearchViewScreen(
          responsiveColumns: columns,
          responsiveColumnWidth: columnWidth,
          responsiveGutterWidth: gutterWidth,
        ));

        _widgetOptions.add(CanvasViewScreen(
          key: key,
          responsiveColumns: columns,
          responsiveColumnWidth: columnWidth,
          responsiveGutterWidth: gutterWidth,
        ));

        _widgetOptions.add(const DonateScreen());

        return Scaffold(
            appBar: AppBar(
              title: Text(AppLocalizations.of(context)!.appTitle),
              actions: const [LanguageDropDownList()],
            ),
            body: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(
                  flex: constants.searchViewRatio,
                  child: Container(
                      margin: EdgeInsets.only(
                          left: marginWidth, right: gutterWidth),
                      child: _widgetOptions[_selectedIndex])),
            ]),
            floatingActionButton: Container(
                margin: const EdgeInsets.only(bottom: 0.0),
                child:
                    Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                  if (_selectedIndex == 1)
                    FloatingActionButton(
                      heroTag: "copy",
                      onPressed: () async {
                        await copyImageToClipBoard();

                        if (Util.getCurrentEnvironment() ==
                            constants.Environment.production) {
                          await FirebaseAnalytics.instance
                              .logEvent(name: "click_copy_button");
                        }
                      },
                      tooltip: AppLocalizations.of(context)!.copy,
                      child: const Icon(Icons.copy),
                    ),
                  if (_selectedIndex == 1) const SizedBox(height: 16),
                  if (_selectedIndex == 1)
                    FloatingActionButton(
                      heroTag: "download",
                      onPressed: () async {
                        await downloadImage();

                        if (Util.getCurrentEnvironment() ==
                            constants.Environment.production) {
                          await FirebaseAnalytics.instance
                              .logEvent(name: "click_download_button");
                        }
                      },
                      tooltip: AppLocalizations.of(context)!.download,
                      child: const Icon(Icons.download),
                    ),
                ])),
            bottomNavigationBar: BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: const Icon(Icons.search),
                    label: AppLocalizations.of(context)!.menuSearchCard),
                BottomNavigationBarItem(
                    icon: const Icon(Icons.style),
                    label: AppLocalizations.of(context)!.menuEditCardImage),
                BottomNavigationBarItem(
                    icon: const Icon(Icons.favorite),
                    label: AppLocalizations.of(context)!.donate),
              ],
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
            ));
      }
    });
  }

  Future<void> copyImageToClipBoard() async {
    Provider.of<CanvasViewModel>(context, listen: false)
        .copyImageToClipBoard(Localizations.localeOf(context), callback: () {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(AppLocalizations.of(context)!.msgCopyDone),
      ));
    }, error: () {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(AppLocalizations.of(context)!.exceptionCode200),
      ));
    });
  }

  Future<void> downloadImage() async {
    Provider.of<CanvasViewModel>(context, listen: false)
        .downloadImage(Localizations.localeOf(context), error: () {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(AppLocalizations.of(context)!.exceptionCode210),
      ));
    });
  }
}
