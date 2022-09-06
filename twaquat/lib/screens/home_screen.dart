import 'dart:convert';
import 'package:twaquat/screens/creat_group.dart';
import 'package:dio/dio.dart';
import 'package:twaquat/services/firebase_auth_methods.dart';
import 'package:twaquat/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:twaquat/widgets/groupProfile.dart';
import 'package:twaquat/screens/groups_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static String routeName = '/homePage';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  

  Future<void> getDio() async {
    Response response;
    var dio = Dio();
    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers['x-rapidapi-key'] = '96e6716660c4e9cbeb2ace74e71c2af5';
    response = await dio.get('https://v3.football.api-sports.io/fixtures',
        queryParameters: {'league': 1, 'season': 2022});

    print(response.data['response'][0]['teams']);
    print(response.data['response'][1]['teams']);
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<FirebaseAuthMethods>().user;

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!user.emailVerified && !user.isAnonymous)
              CustomButton(
                onTap: () {
                  context
                      .read<FirebaseAuthMethods>()
                      .sendEmailVerification(context);
                },
                text: 'Verify Email',
              ),
            CustomButton(
              onTap: () {
                context.read<FirebaseAuthMethods>().signOut(context);
              },
              text: 'Sign Out',
            ),
            CustomButton(
              onTap: () {
                context.read<FirebaseAuthMethods>().deleteAccount(context);
              },
              text: 'Delete Account',
            ),
            CountryListPick(
              appBar: AppBar(
                backgroundColor: Colors.blue,
                title: Text('Choisier un pays'),
              ),
              theme: CountryTheme(
                isShowFlag: true,
                isShowTitle: true,
                isDownIcon: true,
                isShowCode: true,
                showEnglishName: true,
              ),
              initialSelection: '+62',
              onChanged: (CountryCode? code) {
                print(code!.name);
                print(code.code);
                print(code.dialCode);
                print(code.flagUri);
              },
              useUiOverlay: true,
              useSafeArea: true,
            ),
            ElevatedButton(onPressed: getDio, child: const Text('YoYO')),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CreateGroupScreen()));
                },
                child: const Text('First Page')),
            
          ],
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    throw UnimplementedError();
  }
}

