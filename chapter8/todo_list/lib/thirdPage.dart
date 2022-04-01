import 'package:flutter/material.dart';


class ThirdDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    final String args = ModalRoute.of(context)!.settings.arguments.toString();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Third Page'),
      ),
      body: Container(
          child: Center(
            child: Text(
              args, style: TextStyle(fontSize: 30 ),
            ),
/*            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Terminate current page
              },
              child: const Text('going Back to first Page'),
            ),*/
          )
      ),
    );
  }
}