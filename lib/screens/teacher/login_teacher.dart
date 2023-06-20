import 'package:aplicacion_cele/screens/teacher/theme_selection.dart';
import 'package:aplicacion_cele/screens/teacher/registration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginTeacher extends StatefulWidget {
  const LoginTeacher({Key? key}) : super(key: key);

  @override
  _LoginTeacherState createState() => _LoginTeacherState();
}

class _LoginTeacherState extends State<LoginTeacher> {
  // form key
  final _formKey = GlobalKey<FormState>();

  // Editing controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // firebase
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    // email field
    final emailField = Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey[200]!))),
      child: TextFormField(
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
          decoration: const InputDecoration(
            hintText: "Email",
            hintStyle: TextStyle(color: Colors.grey),
            border: InputBorder.none),),
    );

    // password field
    final passwordField = Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey[200]!))),
      child: TextFormField(
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
        obscureText: true,
        decoration: const InputDecoration(
            hintText: "Contraseña",
            hintStyle: TextStyle(color: Colors.grey),
            border: InputBorder.none),
        textInputAction: TextInputAction.done,
      ),
    );

    // login button
    final loginButton = Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 50),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.green[400]!),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
        onPressed: () {
          signIn(emailController.text, passwordController.text);
        },
        child: const Text("Iniciar Sesión",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.green[600]!,
          Colors.green[400]!,
          Colors.green[200]!
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 80,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    "Iniciar Sesión",
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Bienvenido de nuevo",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 60,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromRGBO(17, 79, 179, 0.29),
                                    blurRadius: 20,
                                    offset: Offset(0, 10))
                              ]),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                emailField,
                                passwordField,
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        loginButton,
                        const SizedBox(
                          height: 40,
                        ),
                        const Text(
                          "¿No tienes cuenta?",
                          style: TextStyle(color: Colors.grey),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Registration()));
                          },
                          child: const Text(
                            "Registrarse",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // Login function
  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                Fluttertoast.showToast(msg: "Login successful"),
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => ThemeSelection()))
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }
}
