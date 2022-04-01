import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';
import 'todo.dart';

class AddTodoApp extends StatefulWidget{
  final Future<Database> db ;
  //MyPublicWidget({Key? key}) : super(key: key);
  const AddTodoApp(this.db, {Key? key}) : super(key: key) ;

  @override
  State<StatefulWidget> createState() => _AddTodoApp() ;
}

class _AddTodoApp extends State<AddTodoApp> {
  @override
  void initState() {
    super.initState() ;
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adding Toto ')
      ),
      body: Container(
        child: Center (
          child: Column (
            children: <Widget>[],
          ),
        ),
      ),
    );
  }
}