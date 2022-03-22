import 'package:flutter/material.dart';

class SubDetail extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SubDetail();
}

class _SubDetail extends State<SubDetail> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sub Detail Example'),
      ),
      body: Container(
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              //Navigator.of(context).pushReplacementNamed('/second');
              Navigator.of(context).pushNamed('/second');
            },
            child: Text('Moveforward to second page'),
          ),
        ),
      )
    );
  }
}
