class StudentModel{
  String? alias;
  String? activityCode;
  int? points;
  String? uid;
  String? inventedEmail;

  StudentModel({this.alias, this.activityCode, this.points, this.uid, this.inventedEmail});

  // recibir datos del servidor
  factory StudentModel.fromMap(map){
    return StudentModel(
      alias: map['alias'],
      activityCode: map['activityCode'],
      points: map['points'],
      uid: map['uid'],
      inventedEmail: map['inventedEmail'],
    );
  }

  // enviar datos al servidor
  Map<String, dynamic> toMap(){
    return {
      'alias': alias,
      'activityCode': activityCode,
      'points': points,
      'uid': uid,
      'inventedEmail': inventedEmail,
    };
  }


}