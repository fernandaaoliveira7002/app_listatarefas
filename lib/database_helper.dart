import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _db;

  //Abre (ou cria, se não existe) o arquivo de banco de dados

  static Future<Database> abrirBanco() async {
    final caminho = join(await getDatabasesPath(), 'tarefas.db');

    return openDatabase(
      caminho,
      version: 1,
      onCreate: (db, versao) {
        return db.execute(
          'CREATE TABLE tarefas ('
          'id INTEGER PRIMARY KEY AUTOINCREMENT,'
          'titulo TEXT,'
          'situacao INTEGER' //0 - False, 1  true
          ')',
        );
      },
    );
  }

  //Getter que devolve o banco de dados já aberto, ou abre se ainda não existe
  static Future<Database> get database async {
    _db ??= await abrirBanco();
    return _db!;
  }

  //READ: buscar todas as tarefas salvas no banco
  static Future<List<Map<String, dynamic>>> buscarTarefas() async {
    final db = await DatabaseHelper.database;
    return db.query("tarefas"); //SELECT * FROM tarefas
  }

  //CREATE: Inserir uma nova tarefa no banco de dados
  static Future<void> inserirTarefa(String titulo) async {
    final db = await DatabaseHelper.database;
    await db.insert("tarefas", {
      'titulo': titulo,
      'situacao': 0,
    });
  }

  //UPDATE = Atualização da situação datarefa
  static Future<void> atualizarTarefa(int id, int situacao) async {
    final db = await DatabaseHelper.database;
    await db.update(
      'tarefas',
      {'situacao': situacao},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  //DELETE = deletar uma tarefa do banco de dados
  static Future<void> deletarTarefa(int id) async {
    final db = await DatabaseHelper.database;
    await db.delete(
      'tarefas',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
