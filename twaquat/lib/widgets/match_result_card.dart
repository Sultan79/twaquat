import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:twaquat/services/firebase_auth_methods.dart';

class MatchResultCard extends StatefulWidget {
  const MatchResultCard({
    Key? key,
    this.firstTeam = 'USA',
    this.secondTeam = 'Saudi Arabia',
    this.time = '07:15',
    this.date = '2022/08/22',
    this.fexture = 2,
    this.firstTeamScore = 2,
    this.secondTeamScore = 3,
    this.firstTeamAnticipationScore = 5,
    this.secondTeamAnticipationScore = 3,
  }) : super(key: key);

  final int firstTeamScore;

  final int firstTeamAnticipationScore;

  final int secondTeamAnticipationScore;

  final int secondTeamScore;
  final String firstTeam;
  final String secondTeam;
  final String time;
  final String date;
  final int fexture;

  @override
  State<MatchResultCard> createState() => _MatchResultCardState();
}

class _MatchResultCardState extends State<MatchResultCard> {
  int? firstTeamAnticipationScore = 0;
  int? secondTeamAnticipationScore = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstTeamAnticipationScore = widget.firstTeamScore;
    secondTeamAnticipationScore = widget.firstTeamScore;
    getPrediction();
  }

  void getPrediction() async {
    final lastSavePredictoin = await FirebaseFirestore.instance
        .collection('users')
        .doc(context.read<FirebaseAuthMethods>().user.uid)
        .collection("predictions")
        .doc(widget.fexture.toString())
        .get();
    if (lastSavePredictoin.exists) {
      firstTeamAnticipationScore = lastSavePredictoin.data()!['home'];
      secondTeamAnticipationScore = lastSavePredictoin.data()!['away'];
      setState(() {});
    } else {
      firstTeamAnticipationScore = null;
      secondTeamAnticipationScore = null;
      setState(() {});
    }
    print(firstTeamAnticipationScore);
    print(widget.firstTeamScore);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 185,
      width: 350,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset(
                        'assets/matchesFlags/${widget.firstTeam}.svg',
                        colorBlendMode: BlendMode.colorBurn,
                        height: 65,
                      ),
                      SvgPicture.asset('assets/svg/vs.svg',
                          color: Colors.green),
                      SvgPicture.asset(
                        'assets/matchesFlags/${widget.secondTeam}.svg',
                        colorBlendMode: BlendMode.colorBurn,
                        height: 65,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 40,
                    width: 175,
                    margin: EdgeInsets.only(top: 5),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(15))),
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
              ],
            ),
          ),
          VerticalDivider(
            color: Colors.grey.shade300,
            width: 1,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Anticipation'),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 40,
                        width: 125,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: firstTeamAnticipationScore != null
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "${firstTeamAnticipationScore.toString()}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                            color: firstTeamAnticipationScore! >
                                                    secondTeamAnticipationScore!
                                                ? Colors.green
                                                : Colors.red),
                                  ),
                                  Text(
                                    ':',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  Text(
                                    "${secondTeamAnticipationScore.toString()}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                            color: secondTeamAnticipationScore! >
                                                    firstTeamAnticipationScore!
                                                ? Colors.green
                                                : Colors.red),
                                  ),
                                ],
                              )
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('You Don\'t Have Predict'),
                                    ],
                                  ),
                                ),
                              ),
                      )
                    ],
                  ),
                ),
                Divider(
                  color: Colors.grey.shade300,
                  height: 1,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Result'),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 40,
                        width: 125,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "${widget.firstTeamScore.toString()}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      color: widget.firstTeamScore >
                                              widget.secondTeamScore
                                          ? Colors.green
                                          : Colors.red),
                            ),
                            Text(
                              ':',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              "${widget.secondTeamScore.toString()}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      color: widget.secondTeamScore >
                                              widget.firstTeamScore
                                          ? Colors.green
                                          : Colors.red),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
