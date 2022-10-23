import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:twaquat/screens/settings_screen.dart';
import 'package:twaquat/services/firebase_auth_methods.dart';
import 'package:twaquat/services/firebase_dynamic_link.dart';
import 'package:twaquat/services/send_email.dart';
import 'package:twaquat/services/user_details.dart';
import 'package:twaquat/utils/showSnackbar.dart';
import 'package:twaquat/widgets/account_card.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'description-of-the-application-screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  static String routeName = '/setting-screen';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Profile".tr(),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Center(
                child: Provider.of<UserDetails>(context).name != null
                    ? AccountCard(
                        name: context.read<UserDetails>().name!,
                        image: context.read<UserDetails>().image!,
                        firestTeam: context.read<UserDetails>().myCuntry!,
                        seacondTeam: context.read<UserDetails>().firstWinner!,
                        thirdTeam: context.read<UserDetails>().secondWinner!,
                        points: context.read<UserDetails>().points!.toString(),
                        correctGuess: context
                            .read<UserDetails>()
                            .correctGuess!
                            .toString(),
                        wrongGuess:
                            context.read<UserDetails>().wrongGuess!.toString(),
                        quizzes: context.read<UserDetails>().quizzes!,
                        rank: context.read<UserDetails>().rank!.toString(),
                      )
                    : AccountCard(),
              ),
              SizedBox(height: 20),
              InkWell(
                child: Container(
                  height: 80,
                  width: 330,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: SvgPicture.asset(
                          'assets/svg/Notebook.svg',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Description of the application'.tr()),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(
                      context, Description_Of_The_Application.routeName);
                },
              ),
              SizedBox(height: 20),
              InkWell(
                child: Container(
                  height: 80,
                  width: 330,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: SvgPicture.asset(
                          'assets/svg/GearSix.svg',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Settings'.tr()),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, SettingScreen.routeName);
                },
              ),
              SizedBox(height: 20),
              InkWell(
                child: Container(
                  height: 80,
                  width: 330,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: SvgPicture.asset(
                          'assets/svg/Star.svg',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Rate us'.tr()),
                    ],
                  ),
                ),
                onTap: () {
                  InAppReview.instance.openStoreListing();
                },
              ),
              SizedBox(height: 20),
              InkWell(
                child: Container(
                  height: 80,
                  width: 330,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: SvgPicture.asset(
                          'assets/svg/Share.svg',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Share the app'.tr()),
                    ],
                  ),
                ),
                onTap: () async {
                  String url =
                      await FirebaseDynamicLinkService.createDynamicShareLink();
                  await Clipboard.setData(ClipboardData(text: url));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.green,
                      content: Text("you have copyed the link"),
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              InkWell(
                child: Container(
                  height: 80,
                  width: 330,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: SvgPicture.asset(
                          'assets/svg/ChatCircleDots.svg',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Technical support'.tr()),
                    ],
                  ),
                ),
                onTap: () {
                  SendEmailToSupport();
                },
              ),
              SizedBox(height: 20),
              InkWell(
                child: Container(
                  height: 80,
                  width: 330,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        // child: SvgPicture.asset(
                        //   'assets/svg/ChatCircleDots.svg',
                        //   fit: BoxFit.scaleDown,
                        // ),
                        child: Icon(Icons.exit_to_app),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Sign Out'.tr()),
                    ],
                  ),
                ),
                onTap: () {
                  context.read<FirebaseAuthMethods>().signOut(context);
                },
              ),
              SizedBox(height: 20),
              InkWell(
                child: Container(
                  height: 80,
                  width: 330,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        // child: SvgPicture.asset(
                        //   'assets/svg/ChatCircleDots.svg',
                        //   fit: BoxFit.scaleDown,
                        // ),
                        child: Icon(Icons.delete_outline),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Delete My Account'.tr()),
                    ],
                  ),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        actionsPadding:
                            EdgeInsets.only(bottom: 10, right: 20, left: 20),
                        contentPadding: EdgeInsets.only(top: 40),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 250,
                                    height: 70,
                                    child: Text(
                                        'by clickign delete your account will be permanently deleted'
                                            .tr(),
                                        textAlign: TextAlign.center,
                                        // textWidthBasis: TextWidthBasis.parent,
                                        overflow: TextOverflow.fade,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                fontWeight: FontWeight.normal)),
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
                                  'Delete My Account'.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: Colors.white),
                                ),
                                onPressed: () async {
                                  context
                                      .read<FirebaseAuthMethods>()
                                      .deleteAccount(context);
                                  //  FirebaseFirestore.instance
                                  //     .collection('users')
                                  //     .doc(context
                                  //         .read<FirebaseAuthMethods>()
                                  //         .user
                                  //         .uid);
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              SizedBox(height: 35.w),
            ],
          ),
        ),
      ),
    );
  }
}
