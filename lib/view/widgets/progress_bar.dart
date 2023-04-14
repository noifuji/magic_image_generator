import 'package:flutter/material.dart';
import 'package:magic_image_generator/common/util.dart';

class ProgressBar extends StatefulWidget {
  final ProgressBarController controller;

  const ProgressBar({Key? key, required this.controller}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ProgressBarState();
}

class ProgressBarState extends State<ProgressBar> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: widget.controller,
        builder: (BuildContext context, double progress, Widget? child) {
          Util.printTimeStamp("progress updated = $progress");
          return TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeIn,
            tween: Tween<double>(
              begin: 0,
              end: progress,
            ),
            builder: (context, value, _) {
              Util.printTimeStamp("animation value = $value");
              return Column(children: [
                Text(
                  "Loading Data......${(value * 100).round()}%",
                  style: const TextStyle(color: Colors.white, fontSize: 20, decoration: TextDecoration.none),
                ),
                LinearProgressIndicator(
                  value: value,
                  semanticsLabel: 'progress',
                  minHeight: 15,
                )
              ]);
            },
          );
        });
  }
}

class ProgressBarController extends ValueNotifier<double> {
  ProgressBarController(double value) : super(value);
}
