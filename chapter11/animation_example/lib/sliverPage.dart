import 'package:flutter/material.dart';

class SliverPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SliverPage() ;
}

class _SliverPage extends State<SliverPage>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 150.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Sliver Example-1'),
              background: Image.asset('repo/images/sunny.png'),
            ),
            backgroundColor: Colors.deepOrangeAccent,
          )
        ],
      )
    );
  }
}
