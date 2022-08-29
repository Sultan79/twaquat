import 'package:twaquat/services/firebase_auth_methods.dart';
import 'package:twaquat/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:country_list_pick/country_list_pick.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final int _currentIndex = 0;
  final List<Widget> body = const [
    Icon(Icons.home),
    Icon(Icons.menu),
    Icon(Icons.person),
  ];

  @override
  Widget build(BuildContext context) {
    final user = context.read<FirebaseAuthMethods>().user;

    return Scaffold(
      body: Column(
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
        ],
      ),
    );
  }
}
