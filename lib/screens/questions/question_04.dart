import 'package:flutter/material.dart';

class Question04 extends StatefulWidget {
  const Question04({Key? key}) : super(key: key);

  @override
  _Question04State createState() => _Question04State();

}

class _Question04State extends State<Question04> {
  
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text('Pregunta 04'),
      ),
      body: Center(
        child: Text(
          'Holaaaaaaa',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
  
 
  
}
