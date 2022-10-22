// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:twaquat/services/firebase_auth_methods.dart';
import 'package:twaquat/widgets/voting_button.dart';

class VotingMatchCard extends StatefulWidget {
  const VotingMatchCard({
    Key? key,
    this.firstTeam = 'Qatar',
    this.secondTeam = 'Saudi Arabia',
    this.time = '07:15',
    this.date = '2022/08/22',
    this.fixture = 1,
    this.close = true,
  }) : super(key: key);

  final String firstTeam;
  final String secondTeam;
  final String time;
  final String date;
  final int fixture;
  final bool close;

  @override
  State<VotingMatchCard> createState() => _VotingMatchCardState();
}

class _VotingMatchCardState extends State<VotingMatchCard> {
  int firstTeamScore = 0;
  int secondTeamScore = 0;
  int firstTeamVotes = 0;
  int secondTeamVotes = 0;
  int drawVotes = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPrediction();
  }

  void getPrediction() async {
    final lastSavePredictoin = await FirebaseFirestore.instance
        .collection('users')
        .doc(context.read<FirebaseAuthMethods>().user.uid)
        .collection("predictions")
        .doc(widget.fixture.toString())
        .get();
    var fbFixture = await FirebaseFirestore.instance
        .collection('fixtures')
        .doc(widget.fixture.toString())
        .collection('predictions')
        .get();

    for (var doc in fbFixture.docs) {
      if (doc['votingFor'] == "HOME") {
        firstTeamVotes += 1;
      } else if (doc['votingFor'] == "AWAY") {
        secondTeamVotes += 1;
      } else if (doc['votingFor'] == "DRAW") {
        drawVotes += 1;
      }
      print(doc['votingFor']);
    }

    if (lastSavePredictoin != null) {
      firstTeamScore = lastSavePredictoin.data()!['home'];
      secondTeamScore = lastSavePredictoin.data()!['away'];
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // DateFormat.jm().format(DateTime.parse(DateTime.now().toString().substring(0, 10)));
    return Container(
      height: 185,
      width: 350,
      padding: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                widget.close
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          VotingButton(
                            ontapFunction: () {
                              firstTeamScore++;
                              // print(firstTeamScore);
                              savePrediction(context);
                              setState(() {});
                            },
                          ),
                          VotingButton(
                              ontapFunction: () {
                                if (firstTeamScore > 0) {
                                  firstTeamScore--;
                                }
                                // print(firstTeamScore);

                                savePrediction(context);
                                setState(() {});
                              },
                              upArraw: true),
                        ],
                      )
                    : SizedBox(),
                SvgPicture.asset(
                  'assets/matchesFlags/${widget.firstTeam}.svg',
                  colorBlendMode: BlendMode.colorBurn,
                  height: 65,
                ),
                Container(
                  height: 50,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        firstTeamScore.toString(),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        ':',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        secondTeamScore.toString(),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
                SvgPicture.asset(
                  'assets/matchesFlags/${widget.secondTeam}.svg',
                  colorBlendMode: BlendMode.colorBurn,
                  height: 65,
                ),
                widget.close
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          VotingButton(
                            ontapFunction: () {
                              secondTeamScore++;
                              // print(secondTeamScore);

                              savePrediction(context);
                              setState(() {});
                            },
                          ),
                          VotingButton(
                              ontapFunction: () {
                                if (secondTeamScore > 0) {
                                  secondTeamScore--;
                                }
                                // print(secondTeamScore);

                                savePrediction(context);
                                setState(() {});
                              },
                              upArraw: true),
                        ],
                      )
                    : SizedBox(),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    height: 40,
                    width: 175,
                    margin: EdgeInsets.only(top: 5),
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    color: Colors.green,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            widget.firstTeam.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.white),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: SvgPicture.asset(
                              'assets/svg/vs.svg',
                            ),
                          ),
                          Text(
                            widget.secondTeam.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 40,
                    width: 175,
                    margin: EdgeInsets.only(top: 5),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SvgPicture.asset('assets/svg/Clock.svg'),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 2.0),
                            child: Text(widget.time),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    height: 40,
                    width: 175,
                    margin: EdgeInsets.only(top: 5),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SvgPicture.asset('assets/svg/Calendar.svg'),
                          Text(widget.date)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
          ),
          SizedBox(
            height: 35 + 10,
            width: 350,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 115,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // SvgPicture.asset(
                      //   'assets/svg/Document.svg',
                      //   height: 17,
                      // ),
                      SizedBox(
                        width: 5,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 80,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  widget.firstTeam.tr(),
                                  textAlign: TextAlign.start,
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "$firstTeamVotes",
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(
                                  color: Colors.grey,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                VerticalDivider(
                  color: Colors.grey.shade300,
                  width: 1,
                ),
                SizedBox(
                  width: 115,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // SvgPicture.asset(
                      //   'assets/svg/HandsClapping.svg',
                      //   height: 20,
                      // ),
                      SizedBox(
                        width: 5,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Draw'.tr(),
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          Text(
                            "$drawVotes",
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(
                                  color: Colors.green,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                VerticalDivider(
                  color: Colors.grey.shade300,
                  width: 1,
                ),
                SizedBox(
                  width: 115,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // SvgPicture.asset(
                      //   'assets/svg/HandFist.svg',
                      //   height: 20,
                      // ),
                      SizedBox(
                        width: 5,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 80,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  widget.secondTeam.tr(),
                                  textAlign: TextAlign.start,
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "$secondTeamVotes",
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(
                                  color: Colors.red,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> savePrediction(BuildContext context) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(context.read<FirebaseAuthMethods>().user.uid)
        .collection("predictions")
        .doc(widget.fixture.toString())
        .set({
      "home".tr(): firstTeamScore,
      "away".tr(): secondTeamScore,
    }, SetOptions(merge: true));

    var fbFixture = FirebaseFirestore.instance
        .collection('fixtures')
        .doc(widget.fixture.toString())
        .collection('predictions')
        .doc(FirebaseAuth.instance.currentUser!.uid);

    if (firstTeamScore == secondTeamScore) {
      fbFixture.set(
        {
          'votingFor'.tr(): "DRAW".tr(),
          "home".tr(): firstTeamScore,
          "away".tr(): secondTeamScore,
        },
        SetOptions(merge: true),
      );
    } else if (firstTeamScore > secondTeamScore) {
      fbFixture.set(
        {
          'votingFor'.tr(): "HOME".tr(),
          "home".tr(): firstTeamScore,
          "away".tr(): secondTeamScore,
        },
        SetOptions(merge: true),
      );
    } else if (firstTeamScore < secondTeamScore) {
      fbFixture.set(
        {
          'votingFor'.tr(): "AWAY".tr(),
          "home".tr(): firstTeamScore,
          "away".tr(): secondTeamScore,
        },
        SetOptions(merge: true),
      );
    }
  }
}
