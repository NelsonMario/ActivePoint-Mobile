class User{
  String name;
  String pictureId;
  int point;

  User({this.name, this.pictureId, this.point});

  factory User.fromJson(Map<String, dynamic> json){
    return User(
       name: json['name'],
       pictureId: json['picture_id'],
       point: json['point']
    );
  }
}