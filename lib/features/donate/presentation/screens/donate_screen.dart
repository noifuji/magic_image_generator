import 'package:flutter/cupertino.dart';
import 'package:magic_image_generator/core/widgets/kofi_button.dart';

class DonateScreen extends StatelessWidget {
  const DonateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 300,
        height: 80,
        child: KofiButton(
          width: 200,
          height: 50,
        ),
      ),
    );
  }
}
