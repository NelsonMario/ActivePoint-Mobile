class RewardType{
  int id;
  String typeName;

  RewardType({this.id, this.typeName});

  factory RewardType.fromJson(dynamic json){
    return RewardType(
      id: json['id'] as int,
      typeName: json['type_name']
    );
  }
}