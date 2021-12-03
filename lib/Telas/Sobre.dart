//
// TELA SOBRE
//
import 'package:flutter/material.dart';

final List<String> entries = <String>['Desenvolvedor: Pedro Moris - ADS Noturo','Objetivo do app é ser um app de utilidades basicas do dia a dia;\nContendo as funções de cronômetro e notas!'];
final List<int> colorCodes = <int>[800,100];

class Sobre extends StatelessWidget {
  const Sobre({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Sobre')),
        body: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: entries.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 50,
              color: Colors.amberAccent[colorCodes[index]],
              child: Center(child: Text('${entries[index]}')),
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        ));
  }
}
