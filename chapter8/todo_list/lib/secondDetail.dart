import 'package:flutter/material.dart';


class SecondDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      body: Container(
          child: Center(
            child: ElevatedButton(
              onPressed: () {
                //Navigator.of(context).pop(); // Terminate current page
                Navigator.of(context).pushReplacementNamed('/third'); // Terminate current page
              },
              //child: Text('going Back'),
              child: const Text('Moving forward to third Page'),
            ),
          )
      ),
    );
  }
}