import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:js_interop';
import 'dart:js_interop_unsafe';

@JS('copyImageToClipboard') // ← JSのグローバル関数名と一致させる
external void copyImageToClipboard(JSUint8Array data);

class CopyImageToClipboardUsecase {
  Future<void> call(ui.Image image) async {
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    if (byteData == null) {
      throw Exception("Failed to convert image to byte data.");
    }

    final pngBytes = byteData.buffer.asUint8List();
    final jsBytes = pngBytes.toJS; // Uint8List → JSUint8Array 変換

    copyImageToClipboard(jsBytes); // JS関数呼び出し
  }
}
