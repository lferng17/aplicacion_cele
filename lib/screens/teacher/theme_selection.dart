import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ThemeSelection extends StatefulWidget {
  const ThemeSelection({Key? key}) : super(key: key);
  
  @override
  _ThemeSelectionState createState() => _ThemeSelectionState();
}


class _ThemeSelectionState extends State<ThemeSelection>{
  
  // auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

   @override
  Widget build(BuildContext context){

    // boton para seleccionar el tema del renubero
    final renuberoButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.blue,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0,20.0,15.0),
        onPressed: (){
          // generar codigo aleatorio
          String code = codigoAleatorio();
          Fluttertoast.showToast(msg: "Codigo: $code");
          // guardar actividad en la base de datos
          FirebaseFirestore.instance.collection("activities").doc(code).set({
            "code": code,         
            "questions": ["01","02","03","04"],
            "teacher": _auth.currentUser!.email,
          });
        },
        child: Text("Reñubero",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    // boton para seleccionar el tema del pendon
    final pendonButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.blue,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0,20.0,15.0),
        onPressed: (){},
        child: Text("Pendón",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );






    return Scaffold(
      appBar: AppBar(
        title: Text('Seleccionar Tema'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text("Bienvenido"),
            renuberoButton,
            pendonButton,
          ],
        ),
      ),
    );
  }


  // funcion para generar un codigo aleatorio de 6 digitos
  String codigoAleatorio(){
    var rng = Random();
    var code = rng.nextInt(900000) + 100000;
    return code.toString();

  }





}