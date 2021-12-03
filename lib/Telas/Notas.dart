import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Lista.dart';

class Anotacao extends StatefulWidget {
  @override
  AnotacaoState createState() {
    return new AnotacaoState();
  }
}

enum Prioridade { maxima, normal }

// ...

Prioridade? _prioridade = Prioridade.normal;

class AnotacaoState extends State<Anotacao> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _textoController = TextEditingController();
  final TextEditingController _prioridadeController = TextEditingController();
  String prioridade = "";

  @override
  void didChangeDependencies() {
    /* if (widget.anotacaoModo == AnotacaoModo.Editar){
      _tituloController.text = widget.anotacao['titulo'];
      _textoController.text = widget.anotacao['texto'];
      _dataController.text = widget.anotacao['data_criacao'];
    }*/

    super.didChangeDependencies();
  }
  
  getDocumentById(id) async {
    await FirebaseFirestore.instance
        .collection('notas')
        .doc(id)
        .get()
        .then((doc) {
      _tituloController.text = doc.get('titulo');
      _textoController.text = doc.get('texto');
      _prioridadeController.text = doc.get('prioridade');
    });
  }
  late CollectionReference notas;

  @override
  void initState(){
    super.initState();

    notas = FirebaseFirestore.instance.collection('notas');
  }
  Widget build(BuildContext context) {
    
    var id = ModalRoute.of(context)?.settings.arguments;

    if (id != null){
      if (_tituloController.text.isEmpty && _textoController.text.isEmpty){
        getDocumentById(id);
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Nova Anotação'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _tituloController,
              decoration: InputDecoration(
                hintText: 'Titulo',
              ),
            ),
            Container(
              height: 8,
            ),
            TextField(
              controller: _textoController,
              decoration: InputDecoration(
                hintText: 'Texto',
              ),
            ),
            Column(
              children: <Widget>[
                ListTile(
                  title: const Text('Normal'),
                  leading: Radio<Prioridade>(
                    value: Prioridade.normal,
                    groupValue: _prioridade,
                    onChanged: (Prioridade? value) {
                      setState(() {
                        _prioridade = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Máxima'),
                  leading: Radio<Prioridade>(
                    value: Prioridade.maxima,
                    groupValue: _prioridade,
                    onChanged: (Prioridade? value) {
                      setState(() {
                        _prioridade = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            Container(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _AnotacaoButton('Guardar', Colors.purple, () {
                  final titulo = _tituloController.text;
                  final texto = _textoController.text;
                  prioridade == Prioridade.maxima
                      ? "Máxima"
                      : "Normal";

                  if (id == null) {
                    //
                    // ADICIONAR DOCUMENTO NO FIRESTORE
                    //
                    FirebaseFirestore.instance.collection('notas').add({
                      'titulo': _tituloController.text,
                      'texto': _textoController.text ,
                      'prioridade': prioridade
                    });
                  } else {
                    //
                    // ATUALIZAR DOCUMENTO NO FIRESTORE
                    //
                    FirebaseFirestore.instance
                        .collection('notas')
                        .doc(id.toString()).set({'titulo': titulo,'texto': texto,'prioridade': _prioridade});
                  }
                  _tituloController.text = '';
                  _textoController.text = '';

                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Operação realizada com sucesso!'),
                    duration: Duration(seconds: 2),
                  ));

                  showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                            title: const Text('Cronômetro'),
                            content: Text(
                                'Nota salva com sucesso!\nCheque a lista para conferir suas notas.'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'OK'),
                                child: const Text('OK'),
                              ),
                            ],
                          ));
                  Navigator.pop(context);
                }),
                Container(
                  height: 16,
                ),
                _AnotacaoButton('Cancelar', Colors.grey, () {
                  Navigator.pop(context);
                }),
                Container(
                  height: 16,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _AnotacaoButton extends StatelessWidget {
  final String _texto;
  final Color _cor;
  final _onPressed;

  _AnotacaoButton(this._texto, this._cor, this._onPressed);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Text(
        _texto,
        style: TextStyle(color: Colors.white),
      ),
      height: 40,
      minWidth: 80,
      color: _cor,
      onPressed: _onPressed,
    );
  }
}
