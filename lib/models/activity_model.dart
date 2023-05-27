import 'dart:ffi';

class ActivityModel{
  String? aid;
  String? code;
  String? questions;
  String? teacher;


  ActivityModel({this.aid, this.code, this.questions, this.teacher});

  // recibir datos del servidor
  factory ActivityModel.fromMap(map){
    return ActivityModel(
      aid: map['aid'],
      code: map['code'],
      questions: map['questions'],
      teacher: map['teacher'],
    );
  }

  // enviar datos al servidor
  Map<String, dynamic> toMap(){
    return {
      'aid': aid,
      'code': code,
      'questions': questions,
      'teacher': teacher,
    };
  }


}