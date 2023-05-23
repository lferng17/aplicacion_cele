import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Question01 extends StatefulWidget {
  const Question01({Key? key}) : super(key: key);

  @override
  _Question01State createState() => _Question01State();

}

class _Question01State extends State<Question01> {


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text('Pregunta 01'),
      ),
      body: Center(
        child: Text(
          'Bienvenido: ' + FirebaseAuth.instance.currentUser!.email.toString(),
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
  
 
  
}