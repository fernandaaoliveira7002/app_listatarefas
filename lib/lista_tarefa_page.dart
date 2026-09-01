import 'package:flutter/material.dart';

class ListaTarefaPage extends StatelessWidget {
  const ListaTarefaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> tarefas = [
      {"titulo": 'Fazer compras', 'situacao': false},
      {"titulo": 'Pagar cartão', 'situacao': false},
      {"titulo": 'Terminar o Empreenda', 'situacao': false},
      {"titulo": 'Vir no casa aberta senac', 'situacao': true},
      {"titulo": 'Exame médico', 'situacao': true},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Minhas Tarefas"),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(12),
        itemCount: tarefas.length,
        itemBuilder: (context, index) {
          final tarefa = tarefas[index];
          final bool situacao = tarefa['situacao'];

          return Card(
            child: ListTile(
              leading: Icon(
                situacao ? Icons.check_circle : Icons.circle_outlined,
                color: situacao ? Colors.green : Colors.grey,
              ),
              title: Text(
                tarefa['titulo'],
                style: TextStyle(
                  decoration: situacao
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              subtitle: Text(situacao ? "Concluída" : 'Pendente'),
              trailing: Icon(
                Icons.delete_outline,
                color: Colors.grey,
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        //shape:CircleBorder(),
        child: Icon(Icons.add),
      ),
    );
  }
}






  // Card(
  //           child: ListTile(
  //             leading: Icon(
  //               Icons.check_circle,
  //               color: Colors.green,
  //             ),
  //             title: Text(
  //               "Configurar o ambiente de desenvolvimento",
  //               style: TextStyle(decoration: TextDecoration.lineThrough),
  //             ),
  //             subtitle: Text("Concluída"),
  //             trailing: Icon(
  //               Icons.delete_outline,
  //               color: Colors.grey,
  //             ),
  //           ),
  //         ),