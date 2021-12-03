import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ListaAnotacoes extends StatefulWidget {
  const ListaAnotacoes({Key? key}) : super(key: key);

  @override
  _PrincipalPageState createState() => _PrincipalPageState();
}

class _PrincipalPageState extends State<ListaAnotacoes> {

  //Referenciar a Coleção de Cafés
  late CollectionReference notas;

  @override
  void initState(){
    super.initState();

    notas = FirebaseFirestore.instance.collection('notas');
  }

  //
  // Item Lista
  // Definir a aparência de cada item da lista
  Widget itemLista(item){

    String titulo = item.data()['titulo'];
    String texto = item.data()['texto'];
    String prioridade = item.data()['prioridade'];

    return ListTile(
      title: Text(titulo, style: const TextStyle(fontSize: 30)),
      subtitle: Text('$texto \nPrioridade: $prioridade', style: const TextStyle(fontSize: 25)),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: (){

          //
          // APAGAR UM DOCUMENTO DA COLEÇÃO
          //
          notas.doc(item.id).delete();

        }
      ),
      onTap: (){
        Navigator.pushNamed(context, '/inserir', arguments: item.id);
      },
    );

  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: const Text('Lista de anotações'),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
        automaticallyImplyLeading: false,

      ),
      
      //
      // EXIBIR OS DOCUMENTOS DA COLEÇÃO DE CAFÉS      
      //
      body: StreamBuilder<QuerySnapshot>(

        //fonte de dados (coleção)
        stream: notas.snapshots(),

        //exibir os dados retornados
        builder: (context, snapshot){

          switch(snapshot.connectionState){

            case ConnectionState.none:
              return const Center(child:Text('Não foi possível conectar ao Firebase'));

            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());

            //dados recebidos
            default: 
              final dados = snapshot.requireData;
              return ListView.builder(
                itemCount: dados.size,
                itemBuilder: (context,index){
                  return itemLista(dados.docs[index]);
                }
              );

          }


        }

      ),


      backgroundColor: Colors.blue[50],
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue[900],
        child: const Icon(Icons.add),
        onPressed: (){
          Navigator.pushNamed(context, '/inserir');
        },
      ),
    );
  }
}
