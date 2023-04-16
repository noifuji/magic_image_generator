import 'package:flutter/cupertino.dart';
import 'package:magic_image_generator/view/widgets/kofi_button_nonweb.dart'
    if (dart.library.html) 'package:magic_image_generator/view/widgets/kofi_button_web.dart';

class DonateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            width: 300,
            height: 80,
            child: KofiButton(
              width: 200,
              height: 50,
            )));
  }
}
