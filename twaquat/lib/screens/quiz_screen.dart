import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:percent_indicator/percent_indicator.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});
  static String routeName = '/quizPage';

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  double progressBar = 0;
  int questionTime = 10;
  String question = '';
  String rightAnswer = '';
  List<String> options = [''];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readJson();
    timer();
  }

  Future<void> timer() async {
    String data =
        await DefaultAssetBundle.of(context).loadString("assets/quiz.json");
    final jsonResult = jsonDecode(data);
    for (var i = 0; i < data.length; i++) {
      question = jsonResult[i]["question"];
      questionTime = jsonResult[i]["duration"];
      options = jsonResult[i]["options"];
      print(question);
      print(questionTime);
      print(options);
      await Future.delayed(const Duration(seconds: 1), () {
        // Here you can write your code
        progressBar = (i + 1) / 3;
        print(progressBar);
        setState(() {
          // Here you can write your code for open new view
        });
      });
    }
    print("::::::::Finish Timer:::::::");
  }

  Future<void> readJson() async {
    String data =
        await DefaultAssetBundle.of(context).loadString("assets/quiz.json");
    final jsonResult = jsonDecode(data);
    print(jsonResult);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                Text(
                    "The remaining time : ${((questionTime - progressBar * 10)).round()}"),
                LinearPercentIndicator(
                  alignment: MainAxisAlignment.center,
                  animation: true,
                  animateFromLastPercent: true,
                  barRadius: Radius.circular(15),
                  lineHeight: 10,
                  width: 350,
                  animationDuration: 1000,
                  percent: (questionTime / 10) - progressBar,
                  backgroundColor: Colors.white,
                  progressColor: Theme.of(context).colorScheme.primary,
                ),
                Text(question),
                SizedBox(
                  height: 100,
                ),
                SizedBox(
                  height: 300,
                  child: ListView.builder(
                    itemCount: options.length,
                    itemBuilder: (context, index) {
                      return Text(options[index]);
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
}
