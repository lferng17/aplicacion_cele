class StudentModel{
  String? alias;
  String? activityCode;
  String? points;
  String? studentID;


  StudentModel({this.alias, this.activityCode, this.points, this.studentID});

  // recibir datos del servidor
  factory StudentModel.fromMap(map){
    return StudentModel(
      alias: map['alias'],
      activityCode: map['activityCode'],
      points: map['points'],
      studentID: map['studentID'],
    );
  }

  // enviar datos al servidor
  Map<String, dynamic> toMap(){
    return {
      'alias': alias,
      'activityCode': activityCode,
      'points': points,
      'studentID': studentID,
    };
  }


}