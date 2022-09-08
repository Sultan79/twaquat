import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:twaquat/firebase_options.dart';
import 'package:twaquat/screens/description-of-the-application-screen.dart';
import 'package:twaquat/screens/groups_page.dart';
import 'package:twaquat/screens/home_screen.dart';
import 'package:twaquat/screens/login_email_password_screen.dart';
import 'package:twaquat/screens/login_screen.dart';
import 'package:twaquat/screens/settingsScreen.dart';
import 'package:twaquat/screens/signup_email_password_screen.dart';
import 'package:twaquat/services/firebase_auth_methods.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twaquat/screens/creat_group.dart';
import 'package:twaquat/screens/routing_screen.dart';
import 'package:twaquat/screens/settings-screen-2.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthMethods>(
          create: (_) => FirebaseAuthMethods(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<FirebaseAuthMethods>().authState,
          initialData: null,
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Firebase Auth Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const AuthWrapper(),
        routes: {
          EmailPasswordSignup.routeName: (context) => const EmailPasswordSignup(),
          EmailPasswordLogin.routeName: (context) => const EmailPasswordLogin(),
          groupsPage.routeName:(context) =>  groupsPage(),
          HomeScreen.routeName:(context) => const HomeScreen(),
          CreateGroupScreen.routeName:(context) => const CreateGroupScreen(),
          SettingScreen.routeName:(context) => const SettingScreen(),
          Description_Of_The_Application.routeName:(context) => const Description_Of_The_Application(),
          Settings.routeName:(context) => const Settings(),
          
        },
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      return const RoutingScreen();
    }
    return const LoginScreen();
  }
}