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
      home:FirstPage(title: 'FirstPage demo') ,
      //const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<FirstPage> createState() => _FirstPage();
}

class _FirstPage extends State<FirstPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sub Page Main'),
      ),
      body: Container(
        child: Center(
          child: Text('First Page'),
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push( MaterialPageRoute(builder: (context)=>SecondPage() ));
        },
        child: Icon(Icons.add),
      ),

    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      body: Container(
          child: Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Terminate current page
              },
              child: Text('going Back'),
            ),
          )
      ),
    );
  }
}