import 'package:flutter/material.dart';
import 'package:http/http.dart'  as http ;
import 'dart:convert';

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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: const HttpApp(title: 'HttpApp'),
    );
  }
}


class HttpApp extends StatefulWidget {
  const HttpApp({Key? key , required this.title }) : super(key: key);

  final String title ;

  @override
  State<StatefulWidget> createState()=> _HttpApp();

}

/*class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}*/

class _HttpApp extends State<HttpApp> {

  String result= '';
  List? data ;

  @override
  void initState(){
    super.initState() ;
    data = List.empty( growable: true) ;
  }



  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Container(
        child: Center(
          //child: Text('$result'),
          child: data!.length == 0 ? Text(
            'no data exist',
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          )
              : ListView.builder(
              itemBuilder:(context, index){
                return Card(
                  child: Container(
                    child: Row(
                      children: <Widget>[
/*                        Text(data![index]['title'].toString()),
                        Text(data![index]['authors'].toString()),
                        Text(data![index]['sale_price'].toString()),
                        Text(data![index]['status'].toString()),*/
                        Image.network(
                          data![index]['thumbnail'],
                          height: 100,
                          width: 100,
                          fit: BoxFit.contain,
                        ),
                        Column(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width - 150,
                              child: Text(
                                data![index]['title'].toString(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Text('author: ${data![index]['authors'].toString()}'),
                            Text('price: ${data![index]['sale_price'].toString()}'),
                            Text('status: ${data![index]['status'].toString()}'),
                          ],
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.start,
                    )
                  )
                );
              }
          )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()  {
          getJSONData();
        },
        child: Icon( Icons.file_download),
      ),
    );
  }
  Future<String> getJSONData() async {
    var url = 'https://dapi.kakao.com/v3/search/book?target=title&query=doit';
    var response = await http.get(Uri.parse(url) ,
        headers: {"Authorization": "KakaoAK bd0d95e63ad2adaafdd0748839cea3b9" });
    //print (response.body);
    setState(() {
      var dataConvertedToJSON = json.decode(response.body) ;
      List result = dataConvertedToJSON['documents'];
      data!.addAll(result);
    });
    return response.body ; // "Successful" ;
  }
}
