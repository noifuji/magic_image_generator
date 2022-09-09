import 'package:flutter/material.dart';

class ProgressBar extends StatefulWidget {
  final ProgressController controller;

  ProgressBar({required this.controller});

  @override
  State<StatefulWidget> createState() => ProgressBarState();

}

class ProgressBarState extends State<ProgressBar> {
  double _progress = 0;

  void setProgress(double value) {
    setState(() {
      _progress = value;
    });
  }

  @override
  void initState() {
    super.initState();
    widget.controller.state = this;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children:[
      Text("Loading Data......${(_progress*100).round()}%",
        style: const TextStyle(color: Colors.white,fontSize: 20,decoration: TextDecoration.none),),
      LinearProgressIndicator(
      value: _progress,
      semanticsLabel: 'progress',
    )]);
  }

}

class ProgressController {
  ProgressBarState? state;

  void setProgress(double value) => state?.setProgress(value);
}