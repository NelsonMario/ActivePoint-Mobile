import 'package:activepoint_frontend/model/rewardType.dart';

class Reward{

  int id;
  String desc;
  int claimPoint;
  int quantity;
  RewardType rewardType;

  Reward({this.id, this.desc, this.claimPoint, this.quantity, this.rewardType});

  factory Reward.fromJson(dynamic json){
    return Reward(
      id: json['id'] as int,
      desc: json['description'],
      claimPoint: json['claim_point'],
      quantity: json['quantity'],
      rewardType: RewardType.fromJson(json['reward_type'])
    );
  }

}