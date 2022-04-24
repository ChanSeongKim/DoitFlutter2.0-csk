import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if(Platform.isIOS){
      // 운영체제가 iOS면 실행
      return CupertinoApp(
        home: CupertinoNativeApp(),
      );
    }else {
      //이외의 운영체제라면 실행
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: NativeApp(),
      );
    }
  }
}

class CupertinoNativeApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState(){
    return _NativeApp();
  }
}


class NativeApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NativeApp() ;
}


class _NativeApp extends State<NativeApp> {
  static const platform = const MethodChannel('com.flutter.dev/info') ;
  String _deviceInfo = 'Unknown info' ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Native 통신 예제 ')
      ),
      body: Container(
        child: Center(
          child: Text(
            _deviceInfo,
            style: TextStyle(fontSize: 30),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _getDeviceInfo();
        },
        child: Icon(Icons.get_app)
      ),
    );
  }

  Future<void> _getDeviceInfo() async {
    String deviceInfo ;
    try {
      final String result = await platform.invokeMethod('getDeviceInfo');
      deviceInfo = 'Device info : $result' ;
    } on PlatformException catch(e) {
      deviceInfo = 'Failed to get Devie Info: ${e.message}. ' ;
    }
    setState(() {
      _deviceInfo = deviceInfo ;
    });
  }
}