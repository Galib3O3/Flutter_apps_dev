class UserFunc {
  String? uid;
  String? email;
  String? firstName;
  String? lastName;
  String? password;
  UserFunc(
      {this.uid, this.email, this.firstName, this.lastName, this.password});
//data fetch server
  factory UserFunc.fromMap(map) {
    return UserFunc(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      password: map['password'],
    );
  }
  //data pass server

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'password': password
    };
  }
}
