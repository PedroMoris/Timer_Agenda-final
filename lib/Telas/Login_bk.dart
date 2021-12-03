import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var txtEmail = TextEditingController();
  var txtSenha = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Café Store'),
          centerTitle: true,
          backgroundColor: Colors.brown),
      backgroundColor: Colors.brown[50],
      body: Container(
        padding: const EdgeInsets.all(50),
        child: ListView(
          children: [
            TextField(
              controller: txtEmail,
              style: const TextStyle(
                color: Colors.brown,
                fontWeight: FontWeight.w300,
              ),
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email), labelText: 'Email'),
            ),
            const SizedBox(height: 20),
            TextField(
              obscureText: true,
              controller: txtSenha,
              style: const TextStyle(
                color: Colors.brown,
                fontWeight: FontWeight.w300,
              ),
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.lock), labelText: 'Senha'),
            ),
            const SizedBox(height: 40),
            Container(
              width: 150,
              child: OutlinedButton(
                child: const Text('entrar'),
                onPressed: () {
                  setState(() {
                    isLoading = true;
                  });
                  login(txtEmail.text, txtSenha.text);
                },
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
    );
  }

  //
  // LOGIN com Firebase Auth
  //
  void login(email, senha) {

    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: senha).then((value) {

      Navigator.pushNamed(context, '/principal');

    }).catchError((erro){

      var mensagem = '';
      if (erro.code == 'user-not-found'){
        mensagem = 'ERRO: Usuário não encontrado';
      }else if (erro.code == 'wrong-password'){
        mensagem = 'ERRO: Senha incorreta';
      }else if ( erro.code == 'invalid-email'){
        mensagem = 'ERRO: Email inválido';
      }else{
        mensagem = erro.message;
      }

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(mensagem),
            duration: const Duration(seconds:2)
          )
      );

    });
  }
}
