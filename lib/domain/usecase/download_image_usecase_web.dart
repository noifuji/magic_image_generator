import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
//ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:uuid/uuid.dart';

class DownloadImageUsecase {
  Future<void> call(ui.Image image) async {
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    if (byteData == null) {
      throw Exception();
    }

    Uint8List pngBytes = byteData.buffer.asUint8List();
    await _download(pngBytes);
  }

  Future<void> _download(Uint8List data) async {
    try {
      // and encode them to base64
      final base64data = base64Encode(data);

      // then we create and AnchorElement with the html package
      final a = html.AnchorElement(href: 'data:image/png;base64,$base64data');

      // set the name of the file we want the image to get
      // downloaded to
      a.download = '${const Uuid().v1()}.png';

      // and we click the AnchorElement which downloads the image
      a.click();
      // finally we remove the AnchorElement
      a.remove();
    } catch (e) {
      throw Exception("Failed to download image file:$e");
    }
  }
}
