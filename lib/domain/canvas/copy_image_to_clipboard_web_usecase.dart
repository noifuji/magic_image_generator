import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:js' as js;

class CopyImageToClipboardWebUsecase {
  Future<void> call(ui.Image image) async {
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    if (byteData == null) {
      throw Exception();
    }

    Uint8List pngBytes = byteData.buffer.asUint8List();
    js.context.callMethod('copyImageToClipboard', [pngBytes]);
  }
}
