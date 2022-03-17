import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

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
        title: Text('Large File Example'),
      ),
    );
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