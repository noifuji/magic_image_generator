import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

//受け取ったURLから画像を取得して表示
//画像の取得に失敗したら、エラー用のウィジェットを表示
//ウィジェット外部からリロード操作が可能

class WebImage extends StatefulWidget {
  final String url;
  final BoxFit? fit;
  final Widget Function(BuildContext, Object?, StackTrace?)? errorBuilder;
  final Widget? placeHolder;
  final WebImageController controller;
  const WebImage({
    super.key,
    required this.url,
    required this.controller,
    this.fit,
    this.errorBuilder,
    this.placeHolder,
  });

  @override
  State<StatefulWidget> createState() => WebImageState();
}

class WebImageState extends State<WebImage> {
  String url = "";

  @override
  void initState() {
    url = widget.url;
    super.initState();
    if (widget.controller.value.image == null) {
      widget.controller.fetchImage(widget.url);
    }
  }

  @override
  void dispose() {
    widget.controller.cancelToken?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if (url != widget.url) {
      widget.controller.fetchImage(widget.url);
      url = widget.url;
    }

    return ValueListenableBuilder(
        valueListenable: widget.controller,
        builder: (context, value, child) {
          if (widget.controller.value.hasError) {
            if (widget.errorBuilder != null) {
              return widget.errorBuilder!(
                  context,
                  widget.controller.value.error,
                  widget.controller.value.stackTrace);
            }

            return Container();
          }

          if (widget.controller.value.image == null) {
            return widget.placeHolder ?? Container();
          }

          return Image.memory(
            widget.controller.value.image!,
            fit: widget.fit,
            frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
              if (wasSynchronouslyLoaded || frame != null) {
                // すでに取得済みの場合
                return child;
              } else {
                // render前
                return widget.placeHolder ?? Container();
              }
            },
          );
        });
  }
}

class WebImageData {
  Uint8List? image;
  bool hasError;
  Object? error;
  StackTrace? stackTrace;

  WebImageData({
    this.image,
    this.hasError = false,
    this.error,
    this.stackTrace,
  });

  WebImageData copyWith({
    Uint8List? image,
    bool? hasError,
    Object? error,
    StackTrace? stackTrace,
  }) {
    return WebImageData(
      image: image ?? this.image,
      hasError: hasError ?? this.hasError,
      error: error ?? this.error,
      stackTrace: stackTrace ?? this.stackTrace,
    );
  }
}

class WebImageController extends ValueNotifier<WebImageData> {
  late final Dio dio;
  CancelToken? cancelToken;

  WebImageController()
      : dio = Dio(),
        super(WebImageData());

  Future<void> fetchImage(String url, {bool cache = true}) async {
    cancelToken = CancelToken();
    try {
      Response<List<int>> response;

      response = await dio.get<List<int>>(
        url,
        cancelToken: cancelToken,
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            headers: cache ? {} : {"Cache-Control": "no-cache"}),
      );

      if (response.statusCode == null ||
          response.statusCode != 200 ||
          response.data == null) {
        throw Exception();
      }

      value = value.copyWith(
        image: Uint8List.fromList(response.data!),
        hasError: false,
      );
    } catch (error, stacktrace) {
      debugPrint(error.toString());
      value = value.copyWith(
        image: null,
        hasError: true,
        error: error,
        stackTrace: stacktrace,
      );
    }
  }
}
