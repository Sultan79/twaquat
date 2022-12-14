import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
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
    this.fixture = 2,
    this.firstTeamScore = 2,
    this.secondTeamScore = 3,
  }) : super(key: key);

  final int firstTeamScore;

  final int secondTeamScore;
  final String firstTeam;
  final String secondTeam;
  final String time;
  final String date;
  final int fixture;

  @override
  State<MatchResultCard> createState() => _MatchResultCardState();
}

class _MatchResultCardState extends State<MatchResultCard> {
  int? firstTeamAnticipationScore = 0;
  int? secondTeamAnticipationScore = 0;
  int? totalWrongsPredictions = 0;
  int? totalCorrectPredictions = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstTeamAnticipationScore = widget.firstTeamScore;
    secondTeamAnticipationScore = widget.firstTeamScore;
    getPrediction();
    getAllPredictions();
  }

  void getPrediction() async {
    final lastSavePredictoin = await FirebaseFirestore.instance
        .collection('users')
        .doc(context.read<FirebaseAuthMethods>().user.uid)
        .collection("predictions")
        .doc(widget.fixture.toString())
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
  }

  void getAllPredictions() async {
    final allSavePredictoin = await FirebaseFirestore.instance
        .collection('fixtures')
        .doc(widget.fixture.toString())
        .get();
    if (allSavePredictoin.exists) {
      totalCorrectPredictions =
          await allSavePredictoin.data()!['totalCorrectPredictions'] != null
              ? allSavePredictoin.data()!['totalCorrectPredictions']
              : 10;
      totalWrongsPredictions =
          await allSavePredictoin.data()!['totalWrongsPredictions'] != null
              ? allSavePredictoin.data()!['totalWrongsPredictions']
              : 12;
      setState(() {});
    } else {
      totalCorrectPredictions = 0;
      totalWrongsPredictions = 0;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final total = totalCorrectPredictions! + totalWrongsPredictions!;
    return Container(
      height: 225 + 10,
      width: 350,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 185,
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
                            // borderRadius: BorderRadius.only(
                            //   bottomLeft: Radius.circular(15),
                            // ),
                          ),
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
                            Text('Anticipation'.tr()),
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
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge,
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                                'You Do not Have Predict'.tr()),
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
                            Text('Result'.tr()),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
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
                      SvgPicture.asset(
                        'assets/svg/Document.svg',
                        height: 17,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 80,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                'All Predictions'.tr(),
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ),
                          ),
                          Text(
                            '${total}',
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
                      SvgPicture.asset(
                        'assets/svg/HandsClapping.svg',
                        height: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Correct'.tr(),
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          Text(
                            total == 0
                                ? '% 0'
                                : '% ${(totalCorrectPredictions! / total * 100).round()}',
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
                      SvgPicture.asset(
                        'assets/svg/HandFist.svg',
                        height: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Wrong'.tr(),
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          Text(
                            total == 0
                                ? '% 0'
                                : '% ${(totalWrongsPredictions! / total * 100).round()}',
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
}
