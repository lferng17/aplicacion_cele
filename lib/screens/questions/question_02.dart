import 'package:flutter/material.dart';

class Question02 extends StatefulWidget {
  const Question02({Key? key}) : super(key: key);

  @override
  _Question02State createState() => _Question02State();
}

class _Question02State extends State<Question02> {
  //Etiquetas
  String etiqueta1 = 'Provoca chaparrones inoportunos';
  String etiqueta2 = 'Llena de agua ríos y pantanos';
  String etiqueta3 = 'Domina las lluvias y las tempestades';
  String etiqueta4 = 'Provoca terribles tormentas que hacen que se vaya la luz';
  String etiqueta5 = 'Proporciona lluvias cálidas de primaavera que riegan los campos';
  String etiqueta6 = 'Es un personaje malhumorado, refunfuñón y cabezota';
  String etiqueta7 = 'Oscurece el cielo con nubarrones negros';
  String etiqueta8 = 'Le gusta aguar la fiesta a los humanos';
  String etiqueta9 = 'Le gustan los árboles y, en general, cuida de la naturaleza';
  String etiqueta10 = 'Llena los ríos de agua para que los animales puedan beber';



  //bool
  bool insideBueno = false;
  bool insideMalo = false;

  String active = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('B? ' + insideBueno.toString()),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            DragTarget<String>(
              builder: (context, data, rejectedDate){
                return Container(
                  width: 200.0,
                  height: 200.0,
                  color: Colors.blue,
                  child: active == '' ? null: Etiquetas(etiqueta1),
                );
              },
              onAccept: (etiqueta1){
                setState(() {
                  insideBueno = true;
                  active = etiqueta1;
                });
              } ,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Etiquetas(etiqueta1),
                Etiquetas(etiqueta2),
                Etiquetas(etiqueta3),
              
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class Etiquetas extends StatelessWidget {
  final String EtiquetaString;

  Etiquetas(this.EtiquetaString);

  @override
  Widget build(BuildContext context) {
    return Draggable(
              data: EtiquetaString,
              child: Container(
                height: 50,
                width: 180,
                child: Center(
                  child: Text(
                    EtiquetaString,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
              ),
              feedback: Material(
                child: Container(
                  height: 50,
                  width: 180,
                  child: Center(
                    child: Text(
                      EtiquetaString,
                      style: TextStyle(fontSize: 18, color: Colors.yellow),
                    ),
                  ),
                ),
              ),
              childWhenDragging: Container(
                height: 50,
                width: 180,
                child: Center(
                  child: Text(
                    EtiquetaString,
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ),
              ),
            );
  }
}