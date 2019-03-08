import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: "Stopwatch",
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: HomeWidget(),
  ));
}

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  String _buttonText = "Start";
  String _stopwatchText = "00:00:00";
  final _stopWatch = Stopwatch();
  final _timeout = const Duration(seconds: 1);

  void _startTimeout() {
    /*Timer(_timeout, _handleTimeout);*/
    Timer(_timeout, () {
      if (_stopWatch.isRunning) {
        _startTimeout();
      }
      setState(() {
        _setStopwatchText();
      });
    });
  }

  void _handleTimeoutBak() {
    if (_stopWatch.isRunning) {
      _startTimeout();
    }
    setState(() {
      _setStopwatchText();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stopwatch"),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      children: <Widget>[
        Center(
          child: Column(
            children: <Widget>[
              RaisedButton(
                onPressed: _startStopButtonPressed,
                child: Text(_buttonText),
              ),
              RaisedButton(
                onPressed: _resetButtonPressed,
                child: Text("Reset"),
              ),
            ],
          ),
        ),
        Expanded(
          child: FittedBox(
            fit: BoxFit.none,
            child: Text(
              _stopwatchText,
              style: TextStyle(
                fontSize: 72,
              ),
            ),
          ),
        )
      ],
    );
  }

  void _startStopButtonPressed() {
    setState(() {
      if (_stopWatch.isRunning) {
        _buttonText = "Start";
        _stopWatch.stop();
      } else {
        _buttonText = "Stop";
        _stopWatch.start();
        _startTimeout();
      }
    });
  }

  void _resetButtonPressed() {
    if (_stopWatch.isRunning) {
      _startStopButtonPressed();
    }
    setState(() {
      _stopWatch.reset();
      _setStopwatchText();
    });
  }

  void _setStopwatchText() {
    _stopwatchText = _stopWatch.elapsed.inHours.toString().padLeft(2, "0") +
        ":" +
        (_stopWatch.elapsed.inMinutes % 60).toString().padLeft(2, "0") +
        ":" +
        (_stopWatch.elapsed.inSeconds % 60).toString().padLeft(2, "0");
  }
}
