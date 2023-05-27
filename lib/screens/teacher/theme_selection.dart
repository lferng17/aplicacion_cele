import 'dart:math';

import 'package:aplicacion_cele/screens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/user_model.dart';

class ThemeSelection extends StatefulWidget {
  const ThemeSelection({Key? key}) : super(key: key);
  
  @override
  _ThemeSelectionState createState() => _ThemeSelectionState();
}


class _ThemeSelectionState extends State<ThemeSelection>{
  
  // auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // user
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    final User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.email)
          .get()
          .then((value) {
        setState(() {
          loggedInUser = UserModel.fromMap(value.data());
        });
      });
    }
  }

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
          //Ventana emergente para mostrar el codigo, con un botón para aceptar y cerrar la ventana y la sesión
          showDialog(
            context: context,
            builder: (BuildContext context){
              return AlertDialog(
                title: Text("Código de acceso"),
                content: Text(code),
                actions: [
                  TextButton(
                    onPressed: (){
                      // cerrar ventana emergente, sesión y volver a la pantalla de Home
                      Navigator.of(context).pop();
                      signOut(context);
                    },
                    child: Text("Aceptar"),
                  ),
                ],
              );
            }
          );
          // guardar actividad en la base de datos
          addActivity(code);
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
            //Imprime el correo del usuario que ha iniciado sesión
            Text(loggedInUser.email ?? 'Correo electrónico no disponible'),
            Text("Bienvenido ${loggedInUser.email}"),
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

  // funcion para añadir la actividad en la base de datos
  Future<void> addActivity(String code) async {
  // Comprobar si existe una actividad con el mismo código
  final activityRef = FirebaseFirestore.instance.collection("activities").doc(code);
  final activityDoc = await activityRef.get();

  if (activityDoc.exists) {
    // Si existe, eliminar la actividad antes de insertar la nueva
    await activityRef.delete();
  }

  // Insertar la nueva actividad en la base de datos
  await activityRef.set({
    "code": code,
    "questions": "renubero",
    "teacher": loggedInUser.email,
  });
}


Future<void> signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home()));
  }




}