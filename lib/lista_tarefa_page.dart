import 'package:app_listatarefas/database_helper.dart';
import 'package:app_listatarefas/sobre_app_page.dart';
import 'package:flutter/material.dart';

class ListaTarefaPage extends StatefulWidget {
  const ListaTarefaPage({super.key});

  @override
  State<ListaTarefaPage> createState() => _ListaTarefaPageState();
}

class _ListaTarefaPageState extends State<ListaTarefaPage> {
  List<Map<String, dynamic>> tarefas = [];

  @override
  void initState() {
    super.initState();
    carregarTarefas();
  }

  void carregarTarefas() async {
    final dados = await DatabaseHelper.buscarTarefas();
    setState(() {
      tarefas = dados;
    });
  }

  Future<void> marcarSituacao(int index) async {
    final tarefa = tarefas[index];
    final novoValor = tarefa['situacao'] == 1 ? 0 : 1;
    await DatabaseHelper.atualizarTarefa(tarefa['id'], novoValor);
    carregarTarefas();
  }

  Future<void> deletarTarefa(int index) async {
    final tarefa = tarefas[index];
    await DatabaseHelper.deletarTarefa(tarefa['id']);
    carregarTarefas();
  }

  void adicionarTarefa() {
    final novaTarefaController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Nova tarefa"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: novaTarefaController,
                decoration: InputDecoration(
                  hintText: 'Digite o título...',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                //função para fechar qualquer janela/tela
                Navigator.pop(context);
              },
              child: Text(
                'Cancelar',
              ),
            ),
            TextButton(
              onPressed: () async {
                if (novaTarefaController.text.isNotEmpty) {
                  await DatabaseHelper.inserirTarefa(novaTarefaController.text);
                  carregarTarefas();

                  if (!context.mounted) return;

                  Navigator.pop(context);
                }
              },
              child: Text(
                'Adicionar',
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Minhas Tarefas"),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.indigo),
              child: Text(
                "Minhas Tarefas",
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text("Todas as tarefas"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.check_circle),
              title: Text("Concluídas"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.circle_outlined),
              title: Text("Pendentes"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.info_outline),
              title: Text("Sobre o APP"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SobreAppPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: tarefas.isEmpty
          ? Center(
              child: Text(
                'Nenhuma tarefa ainda. Clique em + para adicionar uma',
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(12),
              itemCount: tarefas.length,
              itemBuilder: (context, index) {
                final tarefa = tarefas[index];
                final bool situacao = tarefa['situacao'] == 1;

                return Card(
                  child: ListTile(
                    leading: GestureDetector(
                      // gesturedetector detecta tudo o que o usuario faz na tela
                      onTap: () => marcarSituacao(index),
                      child: Icon(
                        situacao ? Icons.check_circle : Icons.circle_outlined,
                        color: situacao ? Colors.green : Colors.grey,
                      ),
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
                    trailing: GestureDetector(
                      onTap: () => deletarTarefa(index),
                      child: Icon(
                        Icons.delete_outline,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            adicionarTarefa(), //pode chamar direto, só colocando o nome da "variável", pq o flutter é inteligente para saber o que vc está tentando fazer
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        //shape:CircleBorder(),
        child: Icon(Icons.add),
      ),
    );
  }
}
