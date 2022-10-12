import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:twaquat/screens/settings-screen-2.dart';
import 'package:twaquat/services/firebase_auth_methods.dart';
import 'package:twaquat/services/user_details.dart';
import 'package:twaquat/widgets/account_card.dart';
import 'description-of-the-application-screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);
  static String routeName = '/setting-screen';

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Setting",
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
                        rating: context.read<UserDetails>().rating!.toDouble(),
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
                      Text('Description of the application'),
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
                      Text('Settings'),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, Settings.routeName);
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
                      Text('Rate us'),
                    ],
                  ),
                ),
                onTap: () {
                  // Navigator.pushNamed(
                  //     context, Description_Of_The_Application.routeName);
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
                      Text('Share the app'),
                    ],
                  ),
                ),
                onTap: () {
                  // Navigator.pushNamed(
                  //     context, Description_Of_The_Application.routeName);
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
                      Text('Technical support'),
                    ],
                  ),
                ),
                onTap: () {
                  // Navigator.pushNamed(
                  //     context, Description_Of_The_Application.routeName);
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  context.read<FirebaseAuthMethods>().signOut(context);
                },
                child: Text('Sign Out'),
              ),
              SizedBox(height: 35.w),
            ],
          ),
        ),
      ),
    );
  }
}
