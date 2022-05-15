import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'tabsPage.dart';
import 'memoPage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize() ;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorObservers: <NavigatorObserver>[observer],
      home:
        FutureBuilder(
          future: Firebase.initializeApp(),
          builder: (context, snapshot){
            if(snapshot.hasError) {
              return const Center(
                child: Text('Error'),
              );
            }

            //선언완료후 표시할 위젯
            if(snapshot.connectionState == ConnectionState.done){
              _initFirebaseMessaging(context);
              _getToken();
              return MemoPage() ;
            }

            //선언되는 동안 표시할 위젯
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        )
      // [2] MemoPage(),

/* //[1]
        FirebaseApp(
        analytics: analytics,
        observer: observer,
          ),*/
    );
  }

  _initFirebaseMessaging(BuildContext context) {

    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      if (kDebugMode) { //2022-05-07, cskimair , for debugging mode
        print(event.notification!.title);
        print(event.notification!.body);
      }

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("알림"),
            content: Text(event.notification!.body!),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }
      );
    }
    );
  }

  _getToken() async {
    FirebaseMessaging messaging= FirebaseMessaging.instance;
    print("messaging.getToken(), ${await messaging.getToken()}");
  }
}

class FirebaseApp extends StatefulWidget {
  const FirebaseApp({Key? key, required this.analytics, required this.observer}) : super(key: key);

  final FirebaseAnalytics analytics ;
  final FirebaseAnalyticsObserver observer ;

  @override
  _FirebaseAppState createState() => _FirebaseAppState(analytics, observer);
}

class _FirebaseAppState extends State<FirebaseApp>{
  _FirebaseAppState(this.analytics, this.observer);

  final FirebaseAnalyticsObserver observer ;
  final FirebaseAnalytics analytics ;
  String _message = '';

  void setMessage(String message){
    setState(() {
      _message = message ;
    });
  }

  Future<void> _sendAnalyticsEvent() async {
    //애널리틱스의 logEvent를 호출해 test_event라는 키값으로 데이터 저장
    await analytics.logEvent(
        name: 'test_event',
        parameters: <String, dynamic> {
          'string': 'hello flutter',
          'int': 100 ,
        },
        );
    setMessage('Analytics 보내기 성공');

  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Example'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            ElevatedButton(
                onPressed: _sendAnalyticsEvent,
                child: const Text('테스트 '),
            ),
            Text(_message, style: const TextStyle(color: Colors.blueAccent),),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
      floatingActionButton:
      FloatingActionButton(
        child: const Icon(Icons.tab),
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute<TabsPage>(
            settings: RouteSettings(name: '/tab'),
            builder: (BuildContext context){
              return TabsPage(observer);
            }
          ));
        },
      ),
    );
  }

}