import 'package:activepoint_frontend/customWidget/cards/gradientCardView.dart';
import 'package:activepoint_frontend/model/reward.dart';
import 'package:activepoint_frontend/service/http/getReward.dart';
import 'package:activepoint_frontend/utils/colorConstants.dart';
import 'package:flutter/material.dart';

import 'customWidget/button/primaryButton.dart';

class RewardPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyRewardPageState();
  }
}

class _MyRewardPageState extends State<RewardPage>{

  RewardHTTP rewardHTTP = new RewardHTTP();

  @override
  Widget build(BuildContext context) {

//    double windowWidth = MediaQuery.of(context).size.height;
//    double windowHeight = MediaQuery.of(context).size.height;

    return Container(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Reward",
                style: TextStyle(
                    fontFamily: "Nunito",
                    fontWeight: FontWeight.w900,
                    fontSize: 28,
                    color: Color(0xff000000)
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: FutureBuilder(
                  future: rewardHTTP.getRewards(),
                  // ignore: missing_return
                  builder: (BuildContext buildContext, AsyncSnapshot<List<Reward>> snapshot){
                    if(snapshot.hasData){
                      List<Reward> rewards = snapshot.data;

                      return ListView(
                        children: rewards.map(
                        (Reward reward) => GestureDetector(
                          onTap: (){
                            print(reward.desc);
                            showModalBottomSheet(context: context, builder: (context){
                              return Container(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: secondaryColor,
                                          ),
                                          Text(reward.desc,
                                            style: TextStyle(
                                                fontFamily: "Nunito",
                                                fontSize: 20
                                            ),
                                          ),
                                        ],
                                      ),

                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Reward Type",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 20
                                            ),
                                          ),
                                          Text(reward.rewardType.typeName,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: "Nunito",
                                                fontSize:18
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Claim Point",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 20
                                            ),
                                          ),
                                          Text(reward.claimPoint.toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: "Nunito",
                                                fontSize:18
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Voucher",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 20
                                            ),
                                          ),
                                          Text(reward.quantity.toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: "Nunito",
                                                fontSize:18
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        rewardHTTP.insertReward(reward.id).then((value) => {
                                          print(value)
                                        });
                                        setState(() {

                                        });
                                      },
                                      child: PrimaryButton("Claim Reward")
                                    )
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).canvasColor,
                                  borderRadius: BorderRadius.only(
                                      topLeft: const Radius.circular(10),
                                      topRight: const Radius.circular(10)
                                  ),
                                ),
                              );
                            });
                          },
                          child: GradientCardView(reward.desc, "Quantity: " + reward.claimPoint.toString(), reward.quantity),
                        )).toList(),
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            )
          ]
        ),
      ),
    );
  }
}
