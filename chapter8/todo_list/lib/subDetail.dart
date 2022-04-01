import 'package:flutter/material.dart';

class SubDetail extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SubDetail();
}

class _SubDetail extends State<SubDetail> {
  List<String> todoList = new List.empty(growable: true);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    todoList.add('buying carrot !');
    todoList.add('buying medicine');
    todoList.add('doing cleaning the room');
    todoList.add('making phone call to parents');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sub Detail Example'),
      ),
      body: ListView.builder(
          itemBuilder: (context, index){
            return Card(
              child: InkWell(
                child: Text(
                  todoList[index],
                  style: TextStyle(fontSize: 30),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed('/third', arguments: todoList[index]);
                }
              )
            );
          },
        itemCount: todoList.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //Navigator.of(context).pushNamed('/second');
          _addNavigation(context) ;
        },
        child: Icon( Icons.add),
      ),
/*      Container(
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              //Navigator.of(context).pushReplacementNamed('/second');
              Navigator.of(context).pushNamed('/second');
            },
            child: Text('Moveforward to second page'),
          ),
        ),
      )*/
    );
  }

  void _addNavigation(BuildContext context) async {
    final result = await Navigator.of(context).pushNamed('/second') ;
    setState(() {
      todoList.add( result as String);
    });
  }
}
