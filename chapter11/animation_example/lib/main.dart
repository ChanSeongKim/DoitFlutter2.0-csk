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
      title: 'Flutter animation example Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AnimationApp(),
    );
  }
}

class AnimationApp extends StatefulWidget {
  final String title ;
  const AnimationApp({Key? key, required this.title}) : super(key: key);

  @override
  State<AnimationApp> createState() => _AnimationApp();
}

class _AnimationApp extends State<AnimationApp> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(),
    );
  }
}
