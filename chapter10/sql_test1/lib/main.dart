
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'addTodo.dart';
import 'todo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Future<Database> database = initDatabase() ;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => DatabaseApp( database,  'sqlite demo-19'),
        '/add': (context) => AddTodoApp(database),
      },
      //home: const DatabaseApp(title: 'sqlite demo--8') ,
      //const MyHomePage(title: 'sql_example Flutter Home Page'),
    );
  }

  Future<Database> initDatabase()  async {
    return openDatabase(
      join(await getDatabasesPath(), 'todo_database.db'),
      onCreate: (db, version){
        return db.execute(
          "CREATE TABLE todos(id INTEGER PRIMARY KEY AUTOINCREMENT, "
              "title Text , content TEXT, active INTEGER"
        );
      },
      version: 1,
    );
  }
}

class DatabaseApp extends StatefulWidget {
  final Future<Database> db ;
//  const DatabaseApp( this.db, this.title) ;{Key? key}) : super(key: key);
  const DatabaseApp( this.db, this.title, {Key? key}) : super(key: key) ;

  //const DatabaseApp({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<DatabaseApp> createState() => _DatabaseApp();
}

class _DatabaseApp extends State<DatabaseApp> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar( title: Text(widget.title), ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final todo = await Navigator.of(context).pushNamed('/add') ;
          if( todo != null){
            _insertTodo( todo as Todo) ;
          }
        },
        child: const Icon(Icons.add),),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

    );
  }

  void _insertTodo(Todo todo )  async {
    final Database database = await widget.db ;
    await database.insert('todos', todo.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace );
  }
}
