class Scoreboard{
  String name;
  int point;

  Scoreboard({this.name, this.point});

  factory Scoreboard.fromJson(dynamic json){
    return Scoreboard(
        name: json['name'],
        point: json['total_point'] as int
    );
  }
}