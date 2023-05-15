import 'dart:ffi';

import 'package:aplicacion_cele/screens/questions/question_01.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class WaitingPage extends StatefulWidget {
  @override
  _WaitingPageState createState() => _WaitingPageState();
}

class _WaitingPageState extends State<WaitingPage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 4), () {
      // Navegar a otra página después de 4 segundos
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Question01()),
      );
    });
  }



  // firebase
  final FirebaseAuth _auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Waiting Page'),
      ),
      body: Center(
        child: Text(
          'Espera...',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }



  void questionSelector(){

    //Del código introducido, sacar el vector questions de la base de datos
    



  }

}

