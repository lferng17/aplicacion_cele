import 'package:aplicacion_cele/screens/teacher/login_teacher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../models/user_model.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {

  // auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // form key
  final _formKey = GlobalKey<FormState>();

  // Editing controller
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController secondNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    // email field
    final emailField = TextFormField(
        autofocus: false,
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Por favor ingrese su correo';
          }
          // reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return 'Por favor ingrese un correo valido';
          }
          return null;
        },
        onSaved: (value) {
          emailController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.email),
        ));

    // first name field
    final firstNameField = TextFormField(
      autofocus: false,
      controller: firstNameController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Por favor ingrese su nombre';
        }
        // reg expression for password validation
        if (value.length < 3) {
          return 'El nombre debe tener al menos 3 caracteres';
        }
        return null;
      },
      onSaved: (value) {
        firstNameController.text = value!;
      },

      textInputAction: TextInputAction.next,
    );

    // second name field
    final secondNameField = TextFormField(
      autofocus: false,
      controller: secondNameController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Por favor ingrese su apellido';
        }
        // reg expression for password validation
        if (value.length < 3) {
          return 'El apellido debe tener al menos 3 caracteres';
        }
        return null;
      },
      onSaved: (value) {
        secondNameController.text = value!;
      },

      textInputAction: TextInputAction.next,
    );

    // password field
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Por favor ingrese su contraseña';
        }
        // reg expression for password validation
        if (value.length < 6) {
          return 'La contraseña debe tener al menos 6 caracteres';
        }
        return null;
      },
      onSaved: (value) {
        passwordController.text = value!;
      },

      textInputAction: TextInputAction.next,
    );

    // second name field
    final confirmPasswordField = TextFormField(
      autofocus: false,
      controller: confirmPasswordController,
      validator:(value){
        if(passwordController.text != confirmPasswordController.text){
          return 'Las contraseñas no coinciden';
        }
        return null;

      },
      onSaved: (value) {
        confirmPasswordController.text = value!;
      },

      textInputAction: TextInputAction.done,
    );

    // register button
    final registerButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.blue,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
        onPressed: () {
          signUp(emailController.text, passwordController.text);
        },
        child: Text("Registrarse",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    firstNameField,
                    secondNameField,
                    emailField,
                    passwordField,
                    confirmPasswordField,
                    registerButton,
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  void signUp(String email, String password) async {

    if (_formKey.currentState!.validate()) {
      await _auth.createUserWithEmailAndPassword(email: email, password: password)
      .then((value) => {
        postDetailsToFirestore()
      }).catchError((e){
        Fluttertoast.showToast(msg: e!.message);
      });
    }

  }


  postDetailsToFirestore() async{

    // calling our firestore
    // calling our user model
    // sending these values
 
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstName = firstNameController.text;
    userModel.secondName = secondNameController.text;
    
    await firebaseFirestore.collection("users")
        .doc(user.email)
        .set(userModel.toMap());
    
    Fluttertoast.showToast(msg: "Cuenta creada correctamente");

    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginTeacher()), (route) => false);

  }


}
