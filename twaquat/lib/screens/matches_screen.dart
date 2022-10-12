import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
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
          "Matches",
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
                  text: 'Upcoming',
                ),
                Tab(
                  text: "Past",
                )
              ],
              children: [
                ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    print('object');
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Center(
                        child: VotingMatchCard(),
                      ),
                    );
                  },
                ),
                ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) => Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                      child: MatchResultCard(),
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
}
