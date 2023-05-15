import 'package:aplicacion_cele/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_teacher.dart';

class CourseSelection extends StatefulWidget {
  const CourseSelection({Key? key}) : super(key: key);
  
  @override
  _CourseSelectionState createState() => _CourseSelectionState();
}

class _CourseSelectionState extends State<CourseSelection>{
 
  // form key
  final _formKey = GlobalKey<FormState>();

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedUser = UserModel();


  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedUser = UserModel.fromMap(value.data());
      setState(() {
        
      });
    });
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Seleccionar Curso'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text("Bienvenido ${loggedUser.firstName} ${loggedUser.secondName}"),
          ],
        ),
      ),
    );
  }


  Future<void> _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginTeacher()));
  }


}