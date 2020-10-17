class User{
  int id;
  String email;
  String password;
  int point;

  User({this.id, this.email, this.password, this.point});

  factory User.fromJson(Map<String, dynamic> json){
    return User(
     id: json['id'] as int,
     email: json['email'],
     password: json['password'],
     point: json['point']
    );
  }

}