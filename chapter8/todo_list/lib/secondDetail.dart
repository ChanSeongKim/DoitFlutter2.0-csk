import 'package:flutter/material.dart';


class SecondDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    TextEditingController controller = TextEditingController();


    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      body: Container(
          child: Center(
            child: Column(
              children: <Widget> [
                TextField(
                  controller: controller,
                  keyboardType: TextInputType.text ,
                )
              ,
              ElevatedButton(
              onPressed: () {
                //Navigator.of(context).pop(); // Terminate current page
                //Navigator.of(context).pushReplacementNamed('/third'); // Terminate current page
                //Navigator.of(context).pushNamed('/third', arguments: 'from second Page');
                Navigator.of(context).pop(controller.value.text);
              },
              //child: Text('going Back'),
              child: Text('Save'),
              ),
             ],
            ),
          ),
      ),
    );
  }
}