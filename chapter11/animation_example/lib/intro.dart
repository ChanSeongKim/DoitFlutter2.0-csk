import 'package:flutter/material.dart';
import 'package:animation_example/saturnLoading.dart';
import 'dart:async';
import 'package:animation_example/main.dart';

class IntroPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _IntroPage() ;
}

class _IntroPage extends State<IntroPage> {
  @override
  void initState() {
    super.initState();
    loadData() ;
  }

  Future<Timer> loadData() async {
    return Timer(const Duration(seconds: 5), onDoneLoading);
  }

  onDoneLoading() async {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) =>const AnimationApp(title: '2-intro animation')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Text('애니메이션 앱'),
              SizedBox(
                height: 20,
              ),
              SaturnLoading()
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          )
        )
      )
    );
  }
}