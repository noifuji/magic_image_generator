import 'package:flutter/cupertino.dart';
import 'package:magic_image_generator/view/widgets/kofi_button.dart';

class DonateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Container(
        width:200,
        height:50,
        child:KofiButton())
    );
  }
  
}