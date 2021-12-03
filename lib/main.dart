import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Telas/Cronometro.dart';
import 'Telas/Home.dart';
import 'Telas/Login.dart';
import 'Telas/Notas.dart';
import 'Telas/Sobre.dart';
import 'Telas/Lista.dart';
import 'Telas/criar_conta.dart';
import 'config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //initConfigurations();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Navegação',
      home: Login(),
      routes: <String, WidgetBuilder>{
        '/homepage': (BuildContext context) => new TelaPrincipal(),
        '/criar_conta': (BuildContext context) => new CriarContaPage(),
        '/inserir': (context) => Anotacao(),
      },
    ),
  );
}
//
// TELA PRINCIPAL
//
class TelaPrincipal extends StatefulWidget {
  TelaPrincipal({Key? key}) : super(key: key);

  @override
  _TelaPrincipalState createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  //Index da tela que será carregada
  var telaAtual = 0;

  //Controlador utilizado na troca das telas (páginas)
  var pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      // BODY
      //
      body: PageView(
        controller: pageController,
        children: [
          Home(),
          Cronometro(),
          ListaAnotacoes(),
          Anotacao(),
          Sobre(),
        ],

        //Mudança de página: quando ocorrer a mudança de página
        //por meio da interação do usuário, é necessário
        //atualizar o valor da variável telaAtual
        onPageChanged: (index) {
          setState(() {
            telaAtual = index;
          });
        },
      ),

      //
      // BARRA DE NAVEGAÇÃO
      //
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blue.shade900,

        iconSize: 48,

        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.40),

        selectedFontSize: 16,
        unselectedFontSize: 16,

        //Index do botão selecionado
        currentIndex: telaAtual,

        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timer_sharp),
            label: 'Cronômetro',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Listagem de anotações',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note_alt_sharp),
            label: 'Notas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            label: 'Sobre',
          ),
        ],

        //Mudança de página através da interação com os
        //botões do BottomNavigationBar
        onTap: (index) {
          //atualizar o valor da variável telaAtual
          setState(() {
            telaAtual = index;
          });

          //efetuar a troca da página
          pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 200),
            curve: Curves.easeIn,
          );
        },
      ),
    );
  }
}
