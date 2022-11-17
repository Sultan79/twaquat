import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Description_Of_The_Application extends StatefulWidget {
  const Description_Of_The_Application({super.key});
  static String routeName = '/description-of-the-application';
  @override
  State<Description_Of_The_Application> createState() =>
      _Description_Of_The_ApplicationState();
}

class _Description_Of_The_ApplicationState
    extends State<Description_Of_The_Application> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "How to play and the Rules".tr(),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Wrap(
            alignment: WrapAlignment.center,
            runSpacing: 20,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Wrap(
                  runSpacing: 20,
                  children: [
                    Text('how to play'.tr()),
                    Text(
                      "Simply look at each match and attempt to predict the final scoreline. To enter your predict, click on the + and - arrows next to each team.".tr() +
                          " " +
                          "Each user has until 15 minutes before each match 'kicks off' to update their predicted final score, giving you time to assess the results of previous games. users can make predictions and then change them at anytime, as often as they like until 15 minutes before each game."
                              .tr() +
                          " " +
                          "If the user doesn't enter a score for any game, no points will be awarded."
                              .tr(),
                      style: TextStyle(height: 1.5),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Wrap(
                  runSpacing: 20,
                  children: [
                    Text('POINTS ARE AWARDED AS FOLLOWS:'.tr()),
                    Text(
                      'If you predict the correct score you will be awarded 30 points. (e.g. your prediction Saudi Arabia 3-1 Argentina, actual score Saudi Arabia 3-1 Argentina, therefore 30 points).'.tr() +
                          " " +
                          "If, however, you have predicted the correct result but not the correct final result you will be awarded 10 points. (e.g. your prediction Saudi Arabia 3-1 Argentina, actual score Saudi Arabia 1-0 Argentina,, therefore 10 point)."
                              .tr() +
                          " " +
                          "From the 'Second Round' onwards, predictions will be assessed against the final score including extra playing time ."
                              .tr() +
                          " " +
                          "If a match ends in a penalty shootout, users who correctly predict the winning team will receive 10 points. Players predicting a draw will either receive 10 points for a correct result after extra time, or 30 points for a correct score after extra time."
                              .tr() +
                          " " +
                          "The table will be updated after each game.".tr() +
                          " " +
                          "Users with the most points at the end of the competition will win the league. If two or more players are tied on points, the player with the most correct predict will be ranked higher than those who have predicted the correct result."
                              .tr(),
                      style: TextStyle(height: 1.5),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Wrap(
                  runSpacing: 20,
                  children: [
                    Text('Balance:'.tr()),
                    Text(
                      'Each correct prediction will give you the same amount of credit'.tr() +
                          " " +
                          "This will enable you to buy virtual gifts and send them to your friends in the same group"
                              .tr() +
                          " " +
                          "e.g if you get 30 points from a correct prediction, you will get 30 credits that you can exchange for special virtual gifts in each group"
                              .tr(),
                      style: TextStyle(height: 1.5),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Wrap(
                  runSpacing: 20,
                  children: [
                    Text('PENALTY SHOOTOUTS'.tr()),
                    Text(
                      'When a penalty shootout occurs, the penalties scored will count for the result, but not for the final score. Therefore, if a prediction is made that Team A will win the match, then 10 points will be awarded if Team A wins on penalties.'
                              .tr() +
                          " " +
                          "However, if a draw was predicted and the match is drawn after extra time, the user will receive either 10 points for predicting a draw but the wrong score, or 30 points for predicting a draw and the right score, irrespective of whichever team proceeds to win on penalties."
                              .tr(),
                      style: TextStyle(height: 1.5),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Wrap(
                  runSpacing: 20,
                  children: [
                    Text('COMPETITION RULES'.tr()),
                    Text(
                      'All Users will be deemed to have accepted the rules of the game. To avoid disappointment, users should ensure their predictions are entered and updated comfortably before the 15 minute deadline to avoid any internet access issue that is outside the administrators control.'.tr() +
                          " " +
                          "It is the users' responsibility to update their predictions page after entering predictions or making any amendments to a previous prediction. Failing to do so will result in prediction or alteration, failing to be registered."
                              .tr() +
                          " " +
                          "In the event of any fixture being changed by Qatar 2022 authorities for whatever reason, or any other issue resulting in changes to the schedule of games in Qatar 2022, every effort will be made to update the predictor chart accordingly."
                              .tr() +
                          " " +
                          "However, in the unlikely event of any issue relating to results of games, the final scores and points awarded, the administrators' decision will be final and no correspondence will be entered into."
                              .tr() +
                          " " +
                          "Final score predictions will include extra playing time where applicable."
                              .tr(),
                      style: TextStyle(height: 1.5),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Wrap(
                  runSpacing: 20,
                  children: [
                    Text(
                      'The application disclaims responsibility for any actions that occur outside the realm of sportsmanship, from incitement to intolerance and prejudice that occur between the participants in the groups.'.tr() +
                          " " +
                          "All virtual giveaways and contests are created for entertainment purposes only."
                              .tr() +
                          " " +
                          "And whoever feels that the application is getting on his nerves can delete the account and not participate"
                              .tr() +
                          " " +
                          "The application does not ask you for any money, and no cash will be dealt with at all"
                              .tr() +
                          " " +
                          "This app was created to make watching the almundial more fun"
                              .tr(),
                      style: TextStyle(height: 1.5),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
