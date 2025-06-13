import 'package:flutter/material.dart';
import 'package:magic_image_generator/core/util.dart';

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
        builder: (BuildContext context, Progress progress, Widget? child) {
          Util.printTimeStamp("progress updated = ${progress.progressValue}");
          return TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeIn,
            tween: Tween<double>(
              begin: 0,
              end: progress.progressValue,
            ),
            builder: (context, value, _) {
              return Column(children: [
                Text(
                  "${progress.taskName}......${(value * 100).round()}%",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      decoration: TextDecoration.none),
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

class Progress {
  final double progressValue;
  final String taskName;

  Progress({
    required this.progressValue,
    required this.taskName,
  });

  Progress copyWith(
    double? progressValue,
    String? taskName,
  ) {
    return Progress(
      progressValue: progressValue ?? this.progressValue,
      taskName: taskName ?? this.taskName,
    );
  }
}

class ProgressBarController extends ValueNotifier<Progress> {
  ProgressBarController(Progress value) : super(value);
}
