import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class LargeFileMain extends StatefulWidget{
  const LargeFileMain({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LargeFileMain();
}

class _LargeFileMain extends State<LargeFileMain> {
  // address to download
  final imgUrl =
      'https://images.pexels.com/photos/240040/pexels-photo-240040.jpeg'
      '?auto=compress';
  bool downloading = false ; // variable for checking if currently downloading state is or not
  var progressString = "" ; // variable current status of downloading progress
  String file = "" ;// file which is downloaded

  @override
  Widget build( BuildContext context ){
    //return null ;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Large File Example'),
      ),
      body: Center(
        child: downloading
            ? Container(
          height: 120.0,
          width: 200.0,
          child:  Card(
            color: Colors.black,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  <Widget>[
                CircularProgressIndicator(),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'Downloading File: $progressString',
                  style: TextStyle(
                    color: Colors.white,
                  )
                )
              ],
            ),
          ),
          )
            :// downloading is false then following code is executed
              FutureBuilder(
                builder: (context, snapshot){
                  switch( snapshot.connectionState){
                    case ConnectionState.none :
                      print('none');
                      return Text('No Data exist');
                    case ConnectionState.waiting:
                      print('waiting');
                      return CircularProgressIndicator();
                    case ConnectionState.active:
                      print('active');
                      return CircularProgressIndicator();
                    case ConnectionState.done:
                      print('done');
                      if( snapshot.hasData){
                      return snapshot.data as Widget ;
                      }
                  }
                  print('end process');
                  return Text('no data Exist');
                },
                future: downloadWidget( file) ,
              )
      )
    );
  }

  Future<Widget> downloadWidget(String filePath) async {
    File file = File(filePath) ;
    bool exist = await file.exists() ;
    //new FileImage(file).evict(); // initialize cache  , new is unnecessary
    FileImage(file).evict(); // initialize cache

    if( exist){
      return Center(
        child: Column(
          children: <Widget>[Image.file(File(filePath))],
        )
      );
    }else {
      return const Text('No Data');
    }
  }

  Future<void> downloadFile() async {
    Dio dio = Dio() ;
    try {
      var dir = await getApplicationDocumentsDirectory();
      await dio.download(imgUrl, '${dir.path}/myimage.jpg',
        onReceiveProgress: (rec, total) {
          print('Rec: $rec, Total: $total') ;
          file = '${dir.path}/myimage.jpg';
          setState(() {
            downloading = true ;
            progressString = (( rec / total) * 100).toStringAsFixed(0) + '%';
          });
        });
    } catch (e) {
      print(e) ;
    }
    setState(() {
      downloading = false ;
      progressString = 'Completed';
    });
    print('Download completed');
  }


}// end of class _LargeFileMain