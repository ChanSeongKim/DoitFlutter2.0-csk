import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DatabaseApp(title: 'sqlite demo') ,
      //const MyHomePage(title: 'sql_example Flutter Home Page'),
    );
  }
}

class DatabaseApp extends StatefulWidget {
  const DatabaseApp({Key? key, required this.title}) : super(key: key);

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
        },
        child: const Icon(Icons.add),),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

    );
  }
}
