import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twaquat/screens/creat_company_group.dart';
import 'package:twaquat/screens/description-of-the-application-screen.dart';
import 'package:twaquat/screens/groups_page.dart';
import 'package:twaquat/screens/home_screen.dart';
import 'package:twaquat/screens/login_screen.dart';
import 'package:twaquat/screens/matches_screen.dart';
import 'package:twaquat/screens/quiz_screen.dart';
import 'package:twaquat/screens/rank_screen.dart';
import 'package:twaquat/screens/profileScreen.dart';
import 'package:twaquat/screens/signup_screen.dart';
import 'package:twaquat/services/dropDown_flags.dart';
import 'package:twaquat/services/droupDown_user.dart';
import 'package:twaquat/services/firebase_auth_methods.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twaquat/screens/creat_group.dart';
import 'package:twaquat/screens/routing_screen.dart';
import 'package:twaquat/screens/settings_screen.dart';
import 'package:twaquat/services/gift.dart';
import 'package:twaquat/services/user_details.dart';
import 'package:twaquat/static.dart';
import 'package:sizer/sizer.dart';
import 'package:twaquat/widgets/onboarding/onboarding_screen.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  print('User granted permission: ${settings.authorizationStatus}');
  FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onMessage.listen((message) {});
  FirebaseMessaging.onMessageOpenedApp.listen((message) {});

  // Get any initial links
  final PendingDynamicLinkData? initialLink =
      await FirebaseDynamicLinks.instance.getInitialLink();

      
  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool("showHome") ?? false;
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
      DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => EasyLocalization(
            supportedLocales: [Locale('en'), Locale('ar')],
            path:
                'assets/translations', 
            fallbackLocale: Locale('en'),
            child: MyApp(
              showHome: showHome,
            )), 
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.showHome}) : super(key: key);
  final bool showHome;
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
        Provider<DropDownUsers>(
          create: (_) => DropDownUsers(),
        ),
        Provider<Gifts>(
          create: (_) => Gifts(),
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
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            useInheritedMediaQuery: true,
            // locale: DevicePreview.locale(context),
            builder: DevicePreview.appBuilder,
            theme: twaquatThemeData,
            debugShowCheckedModeBanner: false,
            // home: AuthWrapper(),
            initialRoute: showHome ? '/' : OnboardingScreen.routeName,
            routes: {
              '/': (context) => AuthWrapper(),
              OnboardingScreen.routeName: (context) => const OnboardingScreen(),
              Signup_Screen.routeName: (context) => const Signup_Screen(),
              Signup_Screen.routeName: (context) => const Signup_Screen(),
              LoginScreen.routeName: (context) => const LoginScreen(),
              GroupsPage.routeName: (context) => GroupsPage(),
              HomeScreen.routeName: (context) => const HomeScreen(),
              CreateGroupScreen.routeName: (context) =>
                  const CreateGroupScreen(),
              ProfileScreen.routeName: (context) => const ProfileScreen(),
              Description_Of_The_Application.routeName: (context) =>
                  const Description_Of_The_Application(),
              SettingScreen.routeName: (context) => const SettingScreen(),
              QuizScreen.routeName: (context) => const QuizScreen(),
              MatchesScreen.routeName: (context) => const MatchesScreen(),
              RankScreen.routeName: (context) => const RankScreen(),
              CreateCompnyGroupScreen.routeName: (context) =>
                  const CreateCompnyGroupScreen(),
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
  }
}
