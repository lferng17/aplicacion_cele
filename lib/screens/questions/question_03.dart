import 'package:flutter/material.dart';

class Question03 extends StatefulWidget {
  const Question03({Key? key}) : super(key: key);

  @override
  _Question03State createState() => _Question03State();

}

class _Question03State extends State<Question03> {
  
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text('Pregunta 03'),
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
