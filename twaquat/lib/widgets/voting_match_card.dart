// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
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
    this.fexture = 1,
  }) : super(key: key);

  final String firstTeam;
  final String secondTeam;
  final String time;
  final String date;
  final int fexture;

  @override
  State<VotingMatchCard> createState() => _VotingMatchCardState();
}

class _VotingMatchCardState extends State<VotingMatchCard> {
  int firstTeamScore = 0;
  int secondTeamScore = 0;

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
        .doc(widget.fexture.toString())
        .get();
    if (lastSavePredictoin != null) {
      firstTeamScore = lastSavePredictoin.data()!['home'];
      secondTeamScore = lastSavePredictoin.data()!['away'];
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 350,
      padding: EdgeInsets.symmetric(vertical: 10),
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    VotingButton(
                      ontapFunction: () {
                        firstTeamScore++;
                        print(firstTeamScore);
                        savePrediction(context);
                        setState(() {});
                      },
                    ),
                    VotingButton(
                        ontapFunction: () {
                          firstTeamScore--;
                          print(firstTeamScore);

                          savePrediction(context);
                          setState(() {});
                        },
                        upArraw: true),
                  ],
                ),
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    VotingButton(
                      ontapFunction: () {
                        secondTeamScore++;
                        print(secondTeamScore);

                        savePrediction(context);
                        setState(() {});
                      },
                    ),
                    VotingButton(
                        ontapFunction: () {
                          secondTeamScore--;
                          print(secondTeamScore);

                          savePrediction(context);
                          setState(() {});
                        },
                        upArraw: true),
                  ],
                ),
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
                            widget.firstTeam,
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
                            widget.secondTeam,
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
        ],
      ),
    );
  }

  Future<void> savePrediction(BuildContext context) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(context.read<FirebaseAuthMethods>().user.uid)
        .collection("predictions")
        .doc(widget.fexture.toString())
        .set({
      "home": firstTeamScore,
      "away": secondTeamScore,
    }, SetOptions(merge: true));
  }
}
