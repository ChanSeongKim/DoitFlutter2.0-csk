import 'package:flutter/material.dart';
import 'people.dart';
import 'secondPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter animation example Demo1',
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
  double _opacity = 1 ;
  List<People> peoples = new List.empty(growable: true);
  Color weightColor = Colors.blue ;
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
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              AnimatedOpacity(
                  opacity: _opacity,
                  duration: Duration(seconds: 1),
                child: SizedBox(
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: 100, child: Text('NAME: ${peoples[current].name}')),
                      AnimatedContainer(
                        duration: Duration(seconds: 2),
                        curve: Curves.bounceIn,
                        color: Colors.amber,
                        child: Text(
                          'Height ${peoples[current].height}',
                          textAlign: TextAlign.center,
                        ),
                        width: 50 ,
                        height: peoples[current].height,
                      ),
                      AnimatedContainer(
                        duration: Duration(seconds: 2),
                        curve: Curves.easeInCubic,
                        color: weightColor,
                        child: Text(
                          'Weight: ${peoples[current].weight}',
                          textAlign: TextAlign.center,
                        ),
                        width: 50,
                        height: peoples[current].weight,
                      ),
                      AnimatedContainer(
                        duration: Duration(seconds: 2),
                        curve: Curves.linear,
                        color: Colors.pinkAccent,
                        child: Text(
                          'bmi ${peoples[current].bmi.toString().substring(0,2)}',
                          textAlign: TextAlign.center,
                        ),
                        width: 50,
                        height: peoples[current].bmi,
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                  ),
                  height: 200,
                ),
              ),

              ElevatedButton(
                  onPressed:  () {
                    setState(() {
                      if( current < peoples.length -1){
                        current++ ;
                      }
                    });
                    _changeWeightColor(peoples[current].weight);
                  },
                  child: Text('Next'),
              ),
              ElevatedButton(
                onPressed:  () {
                  setState(() {
                    if( current > 0 ){
                      current-- ;
                    }
                  });
                  _changeWeightColor(peoples[current].weight);
                },
                child: Text('Prev'),
              ),
              ElevatedButton(
                  onPressed: (){
                    setState(() {
                      _opacity ==1 ? _opacity=0 : _opacity=1;
                    });
                  },
                  child: Text('사라지기'),
              ),
              ElevatedButton(
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute( builder:
                    (context)=>SecondPage()));
                  },
                  child: SizedBox(
                    width: 200,
                    child: Row(
                      children: <Widget>[
                        Hero(tag: 'detail', child: Icon(Icons.cake)),
                        Text('이동하기')
                      ],
                    ),
                  ),
              ),

            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      ),
    );
  }
  void _changeWeightColor(double weight){
    if(weight < 40){
      weightColor = Colors.blueAccent;
    }else if( weight < 60){
      weightColor = Colors.indigo;
    }else if( weight < 80){
      weightColor = Colors.orange;
    }else {
      weightColor = Colors.red;
    }

  }
}
