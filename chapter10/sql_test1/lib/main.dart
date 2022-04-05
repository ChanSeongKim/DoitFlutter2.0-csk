
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
  Future<List<Todo>>? todoList ;

  @override
  void initState() {
    super.initState();
    todoList = getTodos() ;

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar( title: Text(widget.title), ),
      body: Container(
        child: Center(
          child: FutureBuilder(
            builder: (context, snapshot){
              switch( snapshot.connectionState){
                case ConnectionState.none:
                  return CircularProgressIndicator();
                case ConnectionState.waiting:
                  return CircularProgressIndicator();
                case ConnectionState.active:
                  return CircularProgressIndicator();
                case ConnectionState.done:
                  if( snapshot.hasData){
                    return ListView.builder(
                        itemBuilder: (context, index){
                          Todo todo = (snapshot.data as List<Todo>)[index];
                          return Card(
                            child: Column(
                              children: <Widget>[
                                Text(todo.title!),
                                Text(todo.content!),
                                Text('${todo.active == 1 ? 'true': 'false'}'),
                              ],
                            ),
                          );
                        },
                      itemCount: (snapshot.data as List<Todo>).length,
                    );
                  }else {
                    return Text('No Data');
                  }
              }
              return CircularProgressIndicator();
            },
            future: todoList,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final todo = await Navigator.of(context).pushNamed('/add') ;
          if( todo != null){
            _insertTodo( todo as Todo) ;
            showAlertDialog(context);
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
    setState(() {
      todoList = getTodos();
    });
  }

  Future<List<Todo>> getTodos() async {
    final Database database = await widget.db  ;
    final List<Map<String, dynamic>> maps = await database.query('todos');

    return List.generate( maps.length, (i){
      int active = maps[i]['active']== 1 ? 1 : 0 ;
      return Todo(
        title: maps[i]['title'].toString(),
        content: maps[i]['content'].toString(),
        active: active,
        id: maps[i]['id']
      );
    });
  }

  showAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Simple Alert"),
      content: Text("This is an alert message."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}
