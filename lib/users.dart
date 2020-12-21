class Users {
  final String token;
  final String name;

  final String email;
  final String password;
  final String role;
  final String fullname;
  final String icno;
  final String phoneno;


  Users({this.token,this.name, this.email, this.password, this.role, this.fullname, this.icno, this.phoneno});

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      token: json['token'],

      name: json['name'],
      email: json['email'],
      password: json['password'],
      role: json['role'],
      fullname: json['fullname'],
      icno: json['icno'] ,
      phoneno: json['phoneno'] ,

    );
  }
}
