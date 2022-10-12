import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:twaquat/screens/description-of-the-application-screen.dart';
import 'package:twaquat/screens/group_room_screen.dart';
import 'package:twaquat/screens/groups_page.dart';
import 'package:twaquat/screens/home_screen.dart';
import 'package:twaquat/screens/login_screen.dart';
import 'package:twaquat/screens/matches_screen.dart';
import 'package:twaquat/screens/quiz_screen.dart';
import 'package:twaquat/screens/rank_screen.dart';
import 'package:twaquat/screens/settingsScreen.dart';
import 'package:twaquat/screens/signup_screen.dart';
import 'package:twaquat/services/dropDown_flags.dart';
import 'package:twaquat/services/firebase_auth_methods.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twaquat/screens/creat_group.dart';
import 'package:twaquat/screens/routing_screen.dart';
import 'package:twaquat/screens/settings-screen-2.dart';
import 'package:twaquat/services/user_details.dart';
import 'package:twaquat/static.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MyApp(), // Wrap your app
    ),
  );
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
        Provider<DropDownFlags>(
          create: (_) => DropDownFlags(flag1: '', flag2: '', flag3: ''),
        ),
        ListenableProvider<UserDetails>(
          create: (_) => UserDetails(),
        ),
        StreamProvider(
          create: (context) => context.read<FirebaseAuthMethods>().authState,
          initialData: null,
        ),
      ],
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return MaterialApp(
            useInheritedMediaQuery: true,
            locale: DevicePreview.locale(context),
            builder: DevicePreview.appBuilder,
            theme: twaquatThemeData,
            debugShowCheckedModeBanner: false,
            // home: AuthWrapper(),
            initialRoute: '/',
            routes: {
              '/': (context) => const AuthWrapper(),
              Signup_Screen.routeName: (context) => const Signup_Screen(),
              LoginScreen.routeName: (context) => const LoginScreen(),
              GroupsPage.routeName: (context) => GroupsPage(),
              HomeScreen.routeName: (context) => const HomeScreen(),
              CreateGroupScreen.routeName: (context) =>
                  const CreateGroupScreen(),
              SettingScreen.routeName: (context) => const SettingScreen(),
              Description_Of_The_Application.routeName: (context) =>
                  const Description_Of_The_Application(),
              Settings.routeName: (context) => const Settings(),
              QuizScreen.routeName: (context) => const QuizScreen(),
              MatchesScreen.routeName: (context) => const MatchesScreen(),
              RankScreen.routeName: (context) => const RankScreen(),
            },
          );
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
      return RoutingScreen();
    }
    return LoginScreen();

    // return const Delete();
  }
}
