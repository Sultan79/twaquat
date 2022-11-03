import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:twaquat/screens/description-of-the-application-screen.dart';
import 'package:twaquat/screens/quiz_screen.dart';
import 'package:twaquat/services/firebase_auth_methods.dart';
import 'package:twaquat/services/firebase_dynamic_link.dart';
import 'package:twaquat/services/fixtures.dart';
import 'package:twaquat/services/gift.dart';
import 'package:twaquat/services/user_details.dart';
import 'package:twaquat/widgets/account_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twaquat/widgets/voting_match_card.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static String routeName = '/homePage';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Map<String, dynamic>? userData;
  // Response? firstNextGame;
  // Response? twoLastGame;

  Gifts gifts = Gifts();
  String? adImage;
  String? adLink;

  Future<void> setUp() async {
    FirebaseDynamicLinkService.initDynamicLink(context);
    showRolesScreen();
    getUserData();
    showAlerts();
    getUserRank();
    getAD();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setUp();
  }

  Future<void> showRolesScreen() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.get('showRoles') == null
        ? prefs.setBool('showRoles', true)
        : prefs.setBool('showRoles', false);
    prefs.get('showRoles') == true
        ? Navigator.pushNamed(context, Description_Of_The_Application.routeName)
        : null;
  }

  getUserRank() async {
    int rank = 0;
    var allUsers = await FirebaseFirestore.instance
        .collection('users')
        .orderBy(
          "points",
          descending: true,
        )
        .get();
    allUsers.docs.forEach((element) {
      rank++;
      if (FirebaseAuth.instance.currentUser!.uid == element.id) {
        context.read<UserDetails>().setUserRank(rank);
      }
    });
  }

  getAD() async {
    var adCollection = await FirebaseFirestore.instance
        .collection("ad")
        .orderBy('adNumber', descending: true)
        .limit(1)
        .get();
    adImage = await adCollection.docs.first.data()['url'];
    adLink = await adCollection.docs.first.data()['link'];
  }

  showAlerts() async {
    QuerySnapshot<Map<String, dynamic>> userAlerts = await FirebaseFirestore
        .instance
        .collection("users")
        .doc(context.read<FirebaseAuthMethods>().user.uid)
        .collection("alerts")
        .where('opend', isEqualTo: false)
        .get();

    if (userAlerts.docs.isEmpty) {
      return;
    }

    for (var alert in userAlerts.docs) {
      String giftImage = '';
      for (var i = 0; i < gifts.giftsName.length; i++) {
        if (gifts.giftsName[i] == alert.data()['gift']) {
          giftImage = gifts.giftsImagePath[i];
        }
      }
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            titlePadding: EdgeInsets.only(top: 40),
            actionsPadding: EdgeInsets.only(bottom: 10, right: 20, left: 20),
            contentPadding: EdgeInsets.only(top: 10),
            content: SizedBox(
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    margin: EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: Colors.grey.shade400),
                    ),
                    child: Image.asset(
                      'assets/giftsImages/${giftImage}',
                      // fit: BoxFit.scaleDown,
                      cacheHeight: 100,
                    ),
                  ),
                  Text(
                    'the User :' + alert.data()['fromUserName'],
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    "send " + alert.data()['gift'] + " to you",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    "from groub:  " + alert.data()['groupName'],
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(context.read<UserDetails>().id)
                          .collection('alerts')
                          .doc(alert.id)
                          .update({'opend': true});
                      Navigator.pop(context);
                    },
                    child: Text('Received'),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  Future<void> getUserData() async {
    DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore
        .instance
        .collection("users")
        .doc(context.read<FirebaseAuthMethods>().user.uid)
        .get();
    Map<String, dynamic> userData = userDoc.data()!;
    print(userDoc.data()!["quizzes"]);
    context.read<UserDetails>().setUserData(
          id: userData["id"],
          name: userData['userName'],
          email: userData["userEmail"],
          image: userData["url"],
          firstCountry: userData["myCuntry"],
          secondCountry: userData["firstWinner"],
          thirdCountry: userData["secondWinner"],
          points: userDoc.data()!["points"],
          rating: userDoc.data()!["rating"],
          correctGuess: userDoc.data()!["correctGuess"],
          wrongGuess: userDoc.data()!["wrongGuess"],
          quizzes: userDoc.data()!["quizzes"],
          isAdmin: userDoc.data()!["isAdmin"],
        );
    print(context.read<UserDetails>().quizzes!.values);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double VoringSizedBoxheight = 205 * 3;
    return Scaffold(
      extendBody: true,
      body: RefreshIndicator(
        onRefresh: () => setUp(),
        color: Colors.amber,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SafeArea(
            bottom: false,
            child: Center(
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 40,
                runSpacing: 15,
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  HomeAccountCard(),
                  QuizButton(),
                  InkWell(
                    onTap: () async {
                      if (adImage != null) {
                        if (adLink != null) {
                          await launchUrlString(adLink!);
                        }
                      }
                    },
                    child: Container(
                      height: 15.h,
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: adImage == null
                          ? FadeShimmer(
                              height: 15.h,
                              width: double.infinity,
                              radius: 15,
                              highlightColor:
                                  Color.fromARGB(255, 231, 231, 231),
                              baseColor: Color(0xffE6E8EB),
                            )
                          : Image.network(adImage!, fit: BoxFit.cover),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 5,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Upcoming matches for Today'.tr()),
                    ),
                  ),
                  // SizedBox(
                  //   height: VoringSizedBoxheight,
                  //   child: ListView.builder(
                  //     physics: NeverScrollableScrollPhysics(),
                  //     itemCount: 3,
                  //     itemBuilder: (context, index) {
                  //       return Container(
                  //         margin: EdgeInsets.symmetric(vertical: 10),
                  //         child: Column(
                  //           children: [
                  //             VotingMatchCard(),
                  //           ],
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),

                  FutureBuilder(
                    future: getTodayFixture(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return SizedBox(
                            height: 210 * 2,
                            child: ListView.separated(
                              itemCount: 2,
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 10),
                              padding: EdgeInsets.only(top: 10),
                              itemBuilder: (context, index) => Column(
                                children: [
                                  FadeShimmer(
                                    height: 185,
                                    width: 350,
                                    radius: 15,
                                    highlightColor:
                                        Color.fromARGB(255, 231, 231, 231),
                                    baseColor: Color(0xffE6E8EB),
                                  ),
                                ],
                              ),
                            ),
                          );
                          
                        default:
                          if (snapshot.hasError)
                            return Text('Error: ${snapshot.error}');
                          else {
                            Response? data = snapshot.data! as Response?;
                            if (data!.data['errors'].toString().isEmpty) {
                              return Text(
                                'Error: ${data.data['errors']['requests']}',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodySmall,
                              );
                            } else {
                              var response = data.data['response'];
                              return response.length == 0
                                  ? SizedBox(
                                      height: 150,
                                      child: Center(
                                        child: Text(
                                          'There are no matches for today'.tr(),
                                          style: TextStyle(
                                              color: Colors.redAccent),
                                        ),
                                      ),
                                    )
                                  : SizedBox(
                                      height: 210 *
                                          double.parse(
                                              response.length.toString()),
                                      child: ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: response.length,
                                        itemBuilder: (context, index) {
                                          String date = response[index]
                                              ['fixture']['date'];
                                          DateTime dateTime = DateTime.parse(
                                              response[index]['fixture']
                                                  ['date']);
                                          print(dateTime
                                                  .difference(DateTime.now())
                                                  .inMinutes <
                                              15);
                                          print(DateTime.now());
                                          return Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Column(
                                              children: [
                                                VotingMatchCard(
                                                  firstTeam: response[index]
                                                      ['teams']['home']['name'],
                                                  secondTeam: response[index]
                                                      ['teams']['away']['name'],
                                                  date: date.split('T').first,
                                                  time: DateFormat.jm().format(
                                                      DateTime.parse(date)),
                                                  fixture: response[index]
                                                      ['fixture']['id'],
                                                  close: dateTime
                                                          .difference(
                                                              DateTime.now())
                                                          .inMinutes >
                                                      15,
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    );
                            }
                          }
                      }
                    },
                  ),
                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HomeAccountCard extends StatelessWidget {
  const HomeAccountCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Provider.of<UserDetails>(context).name != null
          ? AccountCard(
              name: context.read<UserDetails>().name!,
              image: context.read<UserDetails>().image!,
              userCountry: context.read<UserDetails>().myCuntry!,
              firstCountry: context.read<UserDetails>().firstWinner!,
              secondCountry: context.read<UserDetails>().secondWinner!,
              points: context.read<UserDetails>().points!.toString(),
              correctGuess:
                  context.read<UserDetails>().correctGuess!.toString(),
              wrongGuess: context.read<UserDetails>().wrongGuess!.toString(),
              quizzes: context.read<UserDetails>().quizzes!,
              rank: context.read<UserDetails>().rank!.toString(),
            )
          : FadeShimmer(
              height: 150,
              width: 350,
              radius: 15,
              highlightColor: Color.fromARGB(255, 231, 231, 231),
              baseColor: Color(0xffE6E8EB),
            ),
    );
  }
}

class QuizButton extends StatelessWidget {
  const QuizButton({
    super.key,
  });
  void showPopupMessage(BuildContext context) {
    showDialog<void>(
      context: context,
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
            'Are you an expert in World Cups?'.tr(),
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
                          'Every day 10 different questions about the previous World Cups You have 5 seconds for each question If you pass the test, you will get a golden star You only have one try'
                              .tr(),
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
                    'Test Now'.tr(),
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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 350,
      child: ElevatedButton(
        onPressed: () => showPopupMessage(context),
        child: Text(
          "Are you an expert in World Cups?".tr(),
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
