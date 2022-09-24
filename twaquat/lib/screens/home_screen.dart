import 'dart:convert';
import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:twaquat/screens/creat_group.dart';
import 'package:dio/dio.dart';
import 'package:twaquat/screens/quiz_screen.dart';
import 'package:twaquat/services/firebase_auth_methods.dart';
import 'package:twaquat/services/user_details.dart';
import 'package:twaquat/widgets/account_card.dart';
import 'package:twaquat/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:twaquat/widgets/groupProfile.dart';
import 'package:twaquat/screens/groups_page.dart';
import 'package:twaquat/widgets/match_result_card.dart';
import 'package:twaquat/widgets/voting_match_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static String routeName = '/homePage';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic>? userData;
  Response? firstNextGame;
  Response? twoLastGame;
  Future<Response<dynamic>?> getUpcomingFixture() async {
    var dio = Dio();
    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers['x-rapidapi-key'] = '96e6716660c4e9cbeb2ace74e71c2af5';
    return firstNextGame = await dio.get(
      'https://v3.football.api-sports.io/fixtures',
      queryParameters: {
        'league': 1,
        'season': 2022,
        'timezone': 'Asia/Riyadh',
        'next': 1
      },
    );
  }

  Future<Response<dynamic>?> getLastTwoFixture() async {
    var dio = Dio();
    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers['x-rapidapi-key'] = '96e6716660c4e9cbeb2ace74e71c2af5';
    return twoLastGame = await dio.get(
      'https://v3.football.api-sports.io/fixtures',
      queryParameters: {
        'league': 1,
        'season': 2018,
        'timezone': 'Asia/Riyadh',
        'last': 2
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore
        .instance
        .collection("users")
        .doc(context.read<FirebaseAuthMethods>().user.uid)
        .get();
    Map<String, dynamic> userData = userDoc.data()!;
    context.read<UserDetails>().setUserData(
          id: userData["id"],
          name: userData['userName'],
          email: userData["userEmail"],
          image: userData["url"],
          firstCountry: userData["firstCountry"],
          secondCountry: userData["secondCountry"],
          thirdCountry: userData["thirdCountry"],
          points: userDoc.data()!["points"],
          rating: userDoc.data()!["rating"],
          correctGuess: userDoc.data()!["correctGuess"],
          wrongGuess: userDoc.data()!["wrongGuess"],
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Center(
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 40,
              runSpacing: 15,
              children: [
                SizedBox(
                  height: 25,
                ),
                Center(
                  child: Provider.of<UserDetails>(context).name != null
                      ? AccountCard(
                          name: context.read<UserDetails>().name!,
                          image: context.read<UserDetails>().image!,
                          firestTeam: context.read<UserDetails>().firstCountry!,
                          seacondTeam:
                              context.read<UserDetails>().secondCountry!,
                          thirdTeam: context.read<UserDetails>().thirdCountry!,
                          points:
                              context.read<UserDetails>().points!.toString(),
                          correctGuess: context
                              .read<UserDetails>()
                              .correctGuess!
                              .toString(),
                          rating:
                              context.read<UserDetails>().rating!.toDouble(),
                        )
                      : AccountCard(),
                ),
                Container(
                  height: 60,
                  width: 350,
                  child: ElevatedButton(
                    onPressed: () {
                      showPopupMessage(context);
                    },
                    child: Text(
                      "Test your knowledge and get points",
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Image.asset('assets/images/football.png'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Upcoming matches'),
                      ),
                    ],
                  ),
                ),
                // SizedBox(
                //   height: 150,
                //   child: FutureBuilder(
                //     future: getUpcomingFixture(),
                //     builder: (context, snapshot) {
                //       switch (snapshot.connectionState) {
                //         case ConnectionState.waiting:
                //           return Text('Loading....');
                //         default:
                //           if (snapshot.hasError)
                //             return Text('Error: ${snapshot.error}');
                //           else {
                //             Response data = snapshot.data! as Response;
                //             if (data.data['errors'].toString().isEmpty) {
                //               return Text(
                //                 'Error: ${data.data['errors']['requests']}',
                //                 textAlign: TextAlign.center,
                //                 style: Theme.of(context).textTheme.bodySmall,
                //               );
                //             } else {
                //               String date =
                //                   data.data['response'][0]['fixture']['date'];
                //               return Column(
                //                 children: [
                //                   VotingMatchCard(
                //                     firstTeam: data.data['response'][0]['teams']
                //                         ['home']['name'],
                //                     secondTeam: data.data['response'][0]
                //                         ['teams']['away']['name'],
                //                     date: date.split('T').first,
                //                     time: DateFormat.jm()
                //                         .format(DateTime.parse(date)),
                //                     fexture: data.data['response'][0]['fixture']
                //                         ['id'],
                //                   ),
                //                 ],
                //               );
                //             }
                //           }
                //       }
                //     },
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Last Two Matches'),
                      ),
                    ],
                  ),
                ),
                // SizedBox(
                //   height: 185 * 2.5,
                //   child: FutureBuilder(
                //     future: getLastTwoFixture(),
                //     builder: (context, snapshot) {
                //       switch (snapshot.connectionState) {
                //         case ConnectionState.waiting:
                //           return Text('Loading....');
                //         default:
                //           if (snapshot.hasError)
                //             return Text('Error: ${snapshot.error}');
                //           else {
                //             Response? data = snapshot.data! as Response?;
                //             if (data!.data['errors'].toString().isEmpty) {
                //               return Text(
                //                 'Error: ${data.data['errors']['requests']}',
                //                 textAlign: TextAlign.center,
                //                 style: Theme.of(context).textTheme.bodySmall,
                //               );
                //             } else {
                //               return ListView.builder(
                //                 physics: NeverScrollableScrollPhysics(),
                //                 itemCount: 2,
                //                 itemBuilder: (context, index) {
                //                   String date = twoLastGame!.data['response']
                //                       [index]['fixture']['date'];
                //                   return Container(
                //                     margin: EdgeInsets.symmetric(vertical: 10),
                //                     child: Column(
                //                       children: [
                //                         MatchResultCard(
                //                           firstTeam: twoLastGame!
                //                                   .data['response'][index]
                //                               ['teams']['home']['name'],
                //                           secondTeam: twoLastGame!
                //                                   .data['response'][index]
                //                               ['teams']['away']['name'],
                //                           date: date.split('T').first,
                //                           time: DateFormat.jm()
                //                               .format(DateTime.parse(date)),
                //                           fexture: data.data['response'][index]
                //                               ['fixture']['id'],
                //                           firstTeamScore: data.data['response']
                //                               [index]['goals']['home'],
                //                           secondTeamScore: data.data['response']
                //                               [index]['goals']['away'],
                //                         ),
                //                       ],
                //                     ),
                //                   );
                //                 },
                //               );
                //             }
                //           }
                //       }
                //     },
                //   ),
                // ),
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
          title: Text(
            'Test your knowledge !',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
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
                      child: Text(
                          'It is a test consisting of 15 questions. Questions related to football in general. You have only 15 minutes to solve all the questions and finish the test',
                          textAlign: TextAlign.center,
                          // textWidthBasis: TextWidthBasis.parent,
                          overflow: TextOverflow.fade,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.normal)),
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
                    'Test Now',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.pushNamed(context, QuizScreen.routeName);
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
