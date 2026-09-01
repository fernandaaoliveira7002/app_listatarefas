import 'package:flutter/material.dart';

class ListaTarefaPage extends StatelessWidget {
  const ListaTarefaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Minhas Tarefas"),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(12),
        children: [
          Card(
            child: ListTile(
              leading: Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
              title: Text(
                "Configurar o ambiente de desenvolvimento",
                style: TextStyle(decoration: TextDecoration.lineThrough),
              ),
              subtitle: Text("Concluída"),
              trailing: Icon(
                Icons.delete_outline,
                color: Colors.grey,
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(
                Icons.circle_outlined,
                color: Colors.blueGrey,
              ),
              title: Text(
                "Fazer a atividade Flutter",
              ),
              subtitle: Text("Pendente"),
              trailing: Icon(
                Icons.delete_outline,
                color: Colors.grey,
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
              title: Text(
                "Arrumar um emprego",
                style: TextStyle(decoration: TextDecoration.lineThrough),
              ),
              subtitle: Text("Concluída"),
              trailing: Icon(
                Icons.delete_outline,
                color: Colors.grey,
              ),
            ),
          ),
        ],
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
