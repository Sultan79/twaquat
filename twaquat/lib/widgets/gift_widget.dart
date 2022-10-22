import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:twaquat/services/droupDown_user.dart';
import 'package:twaquat/services/user_details.dart';
import 'package:twaquat/services/gift.dart';
import 'package:twaquat/utils/showSnackbar.dart';
import 'package:twaquat/widgets/usersDropDown.dart';

class GiftWidget extends StatelessWidget {
  GiftWidget({
    Key? key,
    this.imageNumber = 0,
    required this.users,
    required this.groupId,
    required this.groupName,
  }) : super(key: key);
  final String groupId;
  final String groupName;
  final int imageNumber;
  final List users;
  final Gifts gifts = Gifts();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Material(
          color: Colors.white,
          child: InkWell(
            onTap: () {
              print(users);
              showPopupMessage(context);
            },
            child: Container(
              height: 220,
              width: 160,
              decoration: BoxDecoration(
                // color: Colors.white,

                color: Colors.transparent,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 135,
                    width: 130,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: Colors.grey.shade400),
                    ),
                    child: Image.asset(
                      'assets/images/${gifts.giftsImagePath[imageNumber]}',
                      // fit: BoxFit.scaleDown,
                      cacheHeight: 80,
                    ),
                  ),
                  Text(
                    gifts.giftsName[imageNumber],
                    // style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Container(
                    height: 30,
                    width: 70,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/svg/Coins.svg'),
                          SizedBox(width: 5),
                          Text('${gifts.giftsPrices[imageNumber]}'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
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
        TextEditingController controller = TextEditingController();
        var items;
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
            'Gift for a friend',
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
                      height: 10,
                    ),
                    Container(
                      height: 135,
                      width: 130,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.background,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: Colors.grey.shade400),
                      ),
                      child: Image.asset(
                        'assets/images/${gifts.giftsImagePath[imageNumber]}',
                        // fit: BoxFit.scaleDown,
                        cacheHeight: 80,
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      gifts.giftsName[imageNumber],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    UsersDropDown(
                      hint: 'Pick user to send gift to'.tr(),
                      title: 'Name'.tr(),
                      users: users,
                      width: 250,
                    ),
                    // SizedBox(
                    //   height: 65,
                    //   width: 250,
                    //   child: FittedBox(
                    //     fit: BoxFit.scaleDown,
                    //     child: CustomFiledText(
                    //       controller: controller,
                    //       title: 'Name',
                    //       hintText: 'hintText',
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      height: 25,
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Center(
              child: SizedBox(
                child: ElevatedButton(
                  child: Text(
                    'Submit'.tr(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (context.read<DropDownUsers>().userPicked != null) {
                      num newPoints = context.read<UserDetails>().points! -
                          gifts.giftsPrices[imageNumber];

                      if (newPoints >= 0) {
                        print("context.read<DropDownUsers>().userPicked");
                        context.read<UserDetails>().points = newPoints;

                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(context.read<UserDetails>().id)
                            .update({"points": newPoints});
                        //what to do
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(context.read<DropDownUsers>().userPicked['id'])
                            .collection('alerts')
                            .add({
                          "fromUser": context.read<UserDetails>().id,
                          "fromUserName": context.read<UserDetails>().name,
                          "toUser":
                              context.read<DropDownUsers>().userPicked['id'],
                          "toUserName": context
                              .read<DropDownUsers>()
                              .userPicked['userName'],
                          "gift": gifts.giftsName[imageNumber],
                          "groupId": groupId,
                          "groupName": groupName,
                          "opend": false,
                          "time": DateTime.now(),
                        });
                        await FirebaseFirestore.instance
                            .collection('group')
                            .doc(groupId)
                            .collection('alerts')
                            .add({
                          "fromUser": context.read<UserDetails>().id,
                          "fromUserName": context.read<UserDetails>().name,
                          "toUser":
                              context.read<DropDownUsers>().userPicked['id'],
                          "toUserName": context
                              .read<DropDownUsers>()
                              .userPicked['userName'],
                          "gift": gifts.giftsName[imageNumber],
                          "groupId": groupId,
                          "groupName": groupName,
                          "opend": false,
                          "time": DateTime.now(),
                        });
                      } else {
                        showSnackBar(context, 'You Don\'t have Enough points');
                      }
                      context.read<DropDownUsers>().userPicked = null;
                    }

                    Navigator.of(context).pop();
                    // Navigator.pushNamed(context, QuizScreen.routeName);
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
