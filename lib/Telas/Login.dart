import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../main.dart';

final TextEditingController nomeusuario = TextEditingController();
final TextEditingController senha = TextEditingController();

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

void _entrar(context, email, senha) {
  FirebaseAuth.instance
      .signInWithEmailAndPassword(email: email, password: senha)
      .then((value) {
    Navigator.pushNamed(context, '/homepage');
  }).catchError((erro) {
    var mensagem = '';
    if (erro.code == 'user-not-found') {
      mensagem = 'ERRO: Usuário não encontrado';
    } else if (erro.code == 'wrong-password') {
      mensagem = 'ERRO: Senha incorreta';
    } else if (erro.code == 'invalid-email') {
      mensagem = 'ERRO: Email inválido';
    } else {
      mensagem = erro.message;
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(mensagem), duration: const Duration(seconds: 2)));
  });
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[50],
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('../../imagens/logo.png', width: 150, height: 150),
                Divider(),
                TextField(
                    autofocus: true,
                    controller: nomeusuario,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.blue, fontSize: 30),
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(color: Colors.black),
                    )),
                Divider(),
                TextField(
                    autofocus: true,
                    controller: senha,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: Colors.blue, fontSize: 30),
                    decoration: InputDecoration(
                      labelText: "Senha",
                      labelStyle: TextStyle(color: Colors.black),
                    )),
                Divider(),
                ButtonTheme(
                  height: 60.0,
                  child: ElevatedButton(
                    onPressed: () =>
                        _entrar(context, nomeusuario.text, senha.text),
                    child: Text(
                      "Enviar",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ),
                ),
                const SizedBox(height: 60),
                Container(
                  width: 150,
                  child: TextButton(
                    child: const Text('Criar conta'),
                    onPressed: () {
                      Navigator.pushNamed(context, '/criar_conta');
                    },
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ));
  }
}
