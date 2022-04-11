import 'package:flutter/material.dart';
import 'people.dart';

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
      home: const AnimationApp(title: 'animation example'),
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
  List<People> peoples = new List.empty(growable: true);
  int current = 0 ;

  @override
  void initState() {
    peoples.add( People('스미스', 180, 92 ));
    peoples.add( People('메리', 162, 55 ));
    peoples.add( People('존', 177, 75 ));
    peoples.add( People('바트', 130, 40 ));
    peoples.add( People('콘', 194, 140 ));
    peoples.add( People('디디', 100, 80 ));
    super.initState();


  }


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
