import 'dart:async';
import 'package:flutter/material.dart';

class Cronometro extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Cronometro> {
  bool _iniciado = true;
  String _textocronometro = '00:00:00';
  final _cronometro = new Stopwatch();
  final _timeout = const Duration(seconds: 1);

  void _startTimeout() {
    new Timer(_timeout, _handleTimeout);
  }

  void _handleTimeout() {
    if (_cronometro.isRunning) {
      _startTimeout();
    }
    setState(() {
      _setStopwatchText();
    });
  }

  void _startStopButtonPressed() {
    setState(() {
      if (_cronometro.isRunning) {
        _iniciado = true;
        _cronometro.stop();
      } else {
        _iniciado = false;
        _cronometro.start();
        _startTimeout();
      }
    });
  }

  void _resetButtonPressed() {
    if (_cronometro.isRunning) {
      _startStopButtonPressed();
    }
    setState(() {
      _cronometro.reset();
      _setStopwatchText();
    });
  }

  void _setStopwatchText() {
    _textocronometro = _cronometro.elapsed.inHours.toString().padLeft(2, '0') +
        ':' +
        (_cronometro.elapsed.inMinutes % 60).toString().padLeft(2, '0') +
        ':' +
        (_cronometro.elapsed.inSeconds % 60).toString().padLeft(2, '0');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cronômetro'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      children: <Widget>[
        Expanded(
          child: FittedBox(
            fit: BoxFit.none,
            child: Text(
              _textocronometro,
              style: TextStyle(fontSize: 72),
            ),
          ),
        ),
        Center(
          child: Column(
            children: <Widget>[
              ElevatedButton(
                child: Icon(_iniciado ? Icons.play_arrow : Icons.stop),
                onPressed: _startStopButtonPressed,
              ),
              ElevatedButton(
                child: Text('Reset'),
                onPressed: _resetButtonPressed,
              ),
              TextButton(
                onPressed: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Cronômetro'),
                    content: Text('Tempo atual Marcado: ${_textocronometro}'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'OK'),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                ),
                child: const Text('Tempo na tela'),
              )
            ],
          ),
        ),
      ],
    );
  }
}
