import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:twaquat/services/fixtures.dart';
import 'package:twaquat/widgets/custom_tab_widget.dart';
import 'package:twaquat/widgets/match_result_card.dart';
import 'package:twaquat/widgets/voting_match_card.dart';

class MatchesScreen extends StatefulWidget {
  const MatchesScreen({super.key});
  static String routeName = '/matches';

  @override
  State<MatchesScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Matches".tr(),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: Column(
        children: [
          // Expanded(
          //   child: Container(
          //     height: 60,
          //     width: 250,
          //     child: Text('data'),
          //   ),
          // ),
          Expanded(
            flex: 10,
            child: CustomTabWidget(
              tabss: [
                Tab(
                  text: 'Upcoming'.tr(),
                ),
                Tab(
                  text: "Past".tr(),
                )
              ],
              children: [
                // ListView.builder(
                //   itemCount: 10,
                //   itemBuilder: (context, index) {
                //     print('object');
                //     return Container(
                //       padding: EdgeInsets.symmetric(vertical: 10),
                //       child: Center(
                //         child: VotingMatchCard(),
                //       ),
                //     );
                //   },
                // ),
                FutureBuilder(
                  future: getUpcomingFixtures(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Text('Loading....');
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
                            return ListView.builder(
                              itemCount: response.length,
                              itemBuilder: (context, index) {
                                String date =
                                    response[index]['fixture']['date'];
                                return Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                    children: [
                                      VotingMatchCard(
                                        firstTeam: response[index]['teams']
                                            ['home']['name'],
                                        secondTeam: response[index]['teams']
                                            ['away']['name'],
                                        date: date.split('T').first,
                                        time: DateFormat.jm()
                                            .format(DateTime.parse(date)),
                                        fixture: response[index]['fixture']
                                            ['id'],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          }
                        }
                    }
                  },
                ),
                FutureBuilder(
                  future: getPastFixtures(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Text('Loading....');
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
                            return ListView.builder(
                              itemCount: response.length,
                              itemBuilder: (context, index) {
                                String date =
                                    response[index]['fixture']['date'];
                                return Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                    children: [
                                      MatchResultCard(
                                        firstTeam: response[index]['teams']
                                            ['home']['name'],
                                        secondTeam: response[index]['teams']
                                            ['away']['name'],
                                        firstTeamScore: response[index]['goals']
                                            ['home'],
                                        secondTeamScore: response[index]
                                            ['goals']['away'],
                                        // firstTeamAnticipationScore: ,
                                        // secondTeamAnticipationScore: ,
                                        date: date.split('T').first,
                                        time: DateFormat.jm()
                                            .format(DateTime.parse(date)),
                                        fixture: response[index]['fixture']
                                            ['id'],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          }
                        }
                    }
                  },
                ),
                // ListView.builder(
                //   itemCount: 10,
                //   itemBuilder: (context, index) => Container(
                //     padding: EdgeInsets.symmetric(vertical: 10),
                //     child: Center(
                //       child: MatchResultCard(),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
