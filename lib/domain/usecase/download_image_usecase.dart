import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:uuid/uuid.dart';
import 'dart:js_interop';

@JS('URL.createObjectURL')
external String createObjectURL(JSAny blob);

@JS('URL.revokeObjectURL')
external void revokeObjectURL(String url);

@JS('Blob')
@staticInterop
class JSBlob {
  external factory JSBlob(JSArray parts, JSObject options);
}

@JS('document.createElement')
external AnchorElement createElement(String tagName);

@JS()
@staticInterop
class AnchorElement {}

extension AnchorElementExtension on AnchorElement {
  external set href(String value);
  external set download(String value);
  external void click();
}

class DownloadImageUsecase {
  Future<void> call(ui.Image image) async {
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    if (byteData == null) throw Exception("Image conversion failed");
    final pngBytes = byteData.buffer.asUint8List();
    await _download(pngBytes);
  }

  Future<void> _download(Uint8List data) async {
    final blobParts = [data.toJS].toJS; // JSArray<JSAny>
    final blobOptions = ({
      'type': 'image/png',
    }).jsify() as JSObject; // JSObject

    final blob = JSBlob(blobParts, blobOptions);
    final url = createObjectURL(blob as JSAny);

    final anchor = createElement('a');
    anchor.href = url;
    anchor.download = '${const Uuid().v1()}.png';
    anchor.click();

    revokeObjectURL(url);
  }
}
