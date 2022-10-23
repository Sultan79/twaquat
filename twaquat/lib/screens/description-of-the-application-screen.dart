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
          "All you need to know".tr(),
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
                        "Simply look at each game and attempt to predict the final scoreline. To enter your scores, click on the up and down arrows next to each team."
                        "Each player has until 15 minutes before each game 'kicks off' to update their predicted final score, giving you time to assess the results of previous games. Players can make predictions and then change them at anytime, as often as they like until 15 minutes before each game."
                        "If players fail to enter a score for any game, no points will be awarded.".tr()),
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
                        'If you predict the correct score you will be awarded 3 points. (e.g. your prediction England 3-2 Germany, actual score England 3-2 Germany, therefore 3 points).'
                        "If, however, you have predicted the correct result but not the correct score you will be awarded 1 point. (e.g. your prediction England 3-2 Germany, actual score England 1-0 Germany, therefore 1 point)."
                        "From the 'Second Round' onwards, predictions will be assessed against the final score including extra time play where applicable."
                        "If a game ends in a penalty shootout, players correctly predicting the winning team will receive 1 point. Players predicting a draw will either receive 1 point for a correct result after extra time, or 3 points for a correct score after extra time."
                        "The table will be updated after each game."
                        "Players with the most points at the end of the competition will win the league. If two or more players are tied on points, the player with most correct scores will be ranked higher than those who have just predicted the correct result.".tr()),
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
                        'All players will be deemed to have accepted the rules of the game. To avoid disappointment players should ensure their predictions are entered and updated comfortably before the 15 minute deadline to account for any internet access issue that is outside of the administrators control.'
                        "It is the players' responsibility to update their predictions page after entering predictions or making any amends to a previous prediction. Failing to do so will result in the prediction or alteration failing to be registered."
                        "In the event of any fixture being changed by Qatar 2022 authorities for whatever reason, or any other issue resulting in changes to the schedule of games in Qatar 2022, every effort will be made to update the predictor chart accordingly. However, in the unlikely event of any issue relating to results of games, the final scores and points awarded, the administrators' decision will be final and no correspondence will be entered into."
                        "Final score predictions will include extra time play where applicable.").tr(),
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
                        'When a penalty shootout occurs, the penalties scored will count for the result, but not for the final score. Therefore, if a prediction was made that Team A will win the match, then 1 point will be awarded if Team A wins on penalties.'
                        "However, if a draw was predicted and the match is drawn after extra time, the player will receive either 1 point for predicting a draw but the wrong score, or 3 points for predicting a draw and the right score, irrespective of whichever team proceeds to win on penalties."
                        "Winners will be notified within 24 hours of the end of the competition and their names will be published on this website (that has restricted access).".tr()),
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
