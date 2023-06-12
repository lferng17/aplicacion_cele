import 'package:flutter/material.dart';

class Question02 extends StatefulWidget {
  const Question02({Key? key}) : super(key: key);

  @override
  _Question02State createState() => _Question02State();
}

class _Question02State extends State<Question02> {

  // Etiquetas
  List<String> etiquetas = [
    'Provoca chaparrones inoportunos',
    'Llena de agua ríos y pantanos',
    'Domina las lluvias y las tempestades',
    'Provoca terribles tormentas que hacen que se vaya la luz',
    'Proporciona lluvias cálidas de primavera que riegan los campos',
    'Es un personaje malhumorado, refunfuñón y cabezota',
    'Oscurece el cielo con nubarrones negros',
    'Le gusta aguar la fiesta a los humanos',
    'Le gustan los árboles y, en general, cuida de la naturaleza',
    'Llena los ríos de agua para que los animales puedan beber',
  ];

  List<String> etiquetasAceptadasTop = [];
  List<String> etiquetasAceptadasBottom = [];

  int currentEtiquetaIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pregunta 2'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildDragTargetTop(),
            _buildDraggable(),
            _buildDragTargetBottom(),
          ],
        ),
      ),
    );
  }

  Widget _buildDraggable() {
    return Draggable<String>(
      data: etiquetas[currentEtiquetaIndex],
      child: Container(
        color: Colors.orange,
        width: 200,
        height: 200,
        child: Center(
          child: Text(
            etiquetas[currentEtiquetaIndex],
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      feedback: Container(
        color: Colors.orange,
        width: 200,
        height: 200,
        child: Center(
          child: Text(
            etiquetas[currentEtiquetaIndex],
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      childWhenDragging: Container(
        color: Colors.red,
        width: 200,
        height: 200,
      ),
    );
  }

  Widget _buildDragTargetTop() {
    return DragTarget<String>(
      onAccept: (data) => setState(() {
        etiquetasAceptadasTop.add(data);
        currentEtiquetaIndex++;
      }),
      builder: (context, candidateData, rejectedData) => Container(
        color: Colors.blue,
        width: 200,
        height: 200,
        child: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                etiquetasAceptadasTop.join('\n'),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      onWillAccept: (data) {
        // Verificar si el dragtarget acepta la etiqueta
        return [1, 2, 4, 8, 9].contains(etiquetas.indexOf(data!));
      },
    );
  }

  Widget _buildDragTargetBottom() {
    return DragTarget<String>(
      onAccept: (data) => setState(() {
        etiquetasAceptadasBottom.add(data);
        currentEtiquetaIndex++;
      }),
      builder: (context, candidateData, rejectedData) => Container(
        color: Colors.green,
        width: 200,
        height: 200,
        child: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                etiquetasAceptadasBottom.join('\n'),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      onWillAccept: (data) {
        return [0, 3, 5, 6, 7].contains(etiquetas.indexOf(data!));
      },
    );
  }
}
