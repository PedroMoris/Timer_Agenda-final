import 'package:flutter/material.dart';

import 'Login.dart';

class Home extends StatelessWidget {
  Home({ Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bem vindo '+ nomeusuario.text),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text("Bem vindo " + nomeusuario.text),
                Text("Utilize dos menus abaixo para acessar as funcionalidades e aproveite o APP!"),
                Image.asset('../../imagens/start.gif', width: 450, height: 450),
              ],
            ),
          ),
      ),
    );
  }
}