import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:twaquat/services/user_details.dart';
import 'package:twaquat/utils/showSnackbar.dart';
import 'package:sizer/sizer.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});
  static String routeName = '/quizPage';

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int totalQuestions = 1;
  int questionNumber = 0;
  int questionTime = 10;
  int questionTimeRemained = 10;
  String question = '';
  String rightAnswer = '';
  List options = [
    {"option": ""},
    {"option": ""},
    {"option": ""},
    {"option": ""}
  ];
  double totalPoins = 0;
  String? userPick;
  bool? success;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer();
  }

  Future<void> timer() async {
    final userDoc = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    var userFilds = await userDoc.get();
    final quizDocs = await FirebaseFirestore.instance
        .collection("quizzes")
        .orderBy("number", descending: true)
        .get();
    Map userQuizzes = userFilds['quizzes'];
    final keys = userQuizzes.keys;
    if (keys.contains(quizDocs.docs.first.data()['number'].toString())) {
      showPopupMessage2(context);
    } else {
      var dio = Dio();
      final response = await dio.get(quizDocs.docs.first.data()['url']);

      if (response.statusCode == 200) {
        Map jsonResult = response.data;
        var langVersion;
        if (context.locale.toString() == "en") {
          langVersion = jsonResult.values.first;
        } else {
          langVersion = jsonResult.values.last;
        }
        totalQuestions = langVersion.length;
        for (var questionInfo = 0;
            questionInfo < langVersion.length;
            questionInfo++) {
          questionNumber++;
          question = langVersion[questionInfo]["question"];
          questionTime = langVersion[questionInfo]["duration"];
          rightAnswer = langVersion[questionInfo]["answer"];
          options = langVersion[questionInfo]["options"];

          for (var questionTimer = 0;
              questionTimer <= questionTime;
              questionTimer++) {
            if (userPick != null) {
              if (userPick == rightAnswer) {
                totalPoins++;
              }
              userPick = null;
              break;
            } else {
              await Future.delayed(const Duration(seconds: 1), () {
                questionTimeRemained = questionTime - questionTimer;
                print(questionTime);
              });
            }
            setState(() {});
          }
        }
        showPopupMessage(context);
        userQuizzes[quizDocs.docs.first.data()['number'].toString()] =
            totalPoins > (questionNumber / 2);
        userDoc.update({'quizzes': userQuizzes});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                // ElevatedButton(
                //   onPressed: timer,
                //   child: Text('Reset'),
                // ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: 30,
                    width: 200,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/svg/Clock.svg'),
                        Text(
                          "The Remaining Time : ${(questionTimeRemained)}s",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    )),
                SizedBox(
                  height: 50,
                  width: 350,
                  child: StepProgressIndicator(
                    totalSteps: totalQuestions,
                    currentStep: questionNumber,
                    roundedEdges: Radius.circular(10),
                    size: 10,
                    selectedColor: Theme.of(context).colorScheme.primary,
                    unselectedColor: Colors.grey.shade300,
                  ),
                ),
                SizedBox(
                    // height: 50,
                    ),
                Container(
                  width: 350,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Question :".tr()),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 20.h,
                        child: Text(
                          question,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                SizedBox(
                  height: 350,
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: options.length,
                    itemBuilder: (context, index) {
                      return Center(
                        child: Container(
                          height: 60,
                          width: 350,
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: ElevatedButton(
                            onPressed: () =>
                                userPick = options[index]['option'],
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                Colors.white,
                              ),
                              side: MaterialStateProperty.all(
                                BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              overlayColor: MaterialStateProperty.all(
                                Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.2),
                              ),
                            ),
                            child: Container(
                              width: 300,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                options[index]['option'],
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showPopupMessage(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          titlePadding: EdgeInsets.only(top: 40),
          actionsPadding: EdgeInsets.only(bottom: 10, right: 20, left: 20),
          contentPadding: EdgeInsets.only(top: 10),
          title: Column(
            children: [
              Image.asset(
                totalPoins > (questionNumber / 2)
                    ? "assets/images/Group 54421-3.png"
                    : "assets/images/Group 54421-2.png",
                height: 250,
              ),
              Text(
                totalPoins > (questionNumber / 2)
                    ? 'Congratulation'.tr()
                    : 'Unfortunately'.tr(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 250,
                      height: 100,
                      child: Center(
                        child: Text('Your Score ${totalPoins.round()}/10',
                            textAlign: TextAlign.center,
                            // textWidthBasis: TextWidthBasis.parent,
                            overflow: TextOverflow.fade,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.normal)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Center(
              child: SizedBox(
                height: 65,
                width: 300,
                child: ElevatedButton(
                  child: Text(
                    'Return To Home'.tr(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void showPopupMessage2(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          titlePadding: EdgeInsets.only(top: 40),
          actionsPadding: EdgeInsets.only(bottom: 10, right: 20, left: 20),
          contentPadding: EdgeInsets.only(top: 10),
          title: Column(
            children: [
              Text(
                'You Aready take this Quiz'.tr(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 250,
                      height: 100,
                      // child: Center(
                      //   child: Text('Your Score ${totalPoins.round()}/10',
                      //       textAlign: TextAlign.center,
                      //       // textWidthBasis: TextWidthBasis.parent,
                      //       overflow: TextOverflow.fade,
                      //       style: Theme.of(context)
                      //           .textTheme
                      //           .bodyMedium!
                      //           .copyWith(fontWeight: FontWeight.normal)),
                      // ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Center(
              child: SizedBox(
                height: 65,
                width: 300,
                child: ElevatedButton(
                  child: Text(
                    'Return To Home'.tr(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
