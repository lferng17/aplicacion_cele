class UserModel{
  String? uid;
  String? email;
  String? firstName;
  String? secondName;


  UserModel({this.uid, this.email, this.firstName, this.secondName});

  // recibir datos del servidor
  factory UserModel.fromMap(map){
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      secondName: map['secondName'],
    );
  }

  // enviar datos al servidor
  Map<String, dynamic> toMap(){
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'secondName': secondName,
    };
  }


}