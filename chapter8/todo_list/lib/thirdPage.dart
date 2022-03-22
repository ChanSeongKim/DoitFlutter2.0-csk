import 'package:flutter/material.dart';


class ThirdDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Third Page'),
      ),
      body: Container(
          child: Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Terminate current page
              },
              child: const Text('going Back to first Page'),
            ),
          )
      ),
    );
  }
}