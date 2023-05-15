import 'package:flutter/material.dart';

class Question02 extends StatefulWidget {
  const Question02({Key? key}) : super(key: key);

  @override
  _Question02State createState() => _Question02State();

}

class _Question02State extends State<Question02> {
  
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text('Pregunta 02'),
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
