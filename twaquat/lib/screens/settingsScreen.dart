import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twaquat/screens/settings-screen-2.dart';
import 'package:twaquat/services/firebase_auth_methods.dart';
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
        backgroundColor: Colors.deepPurple[300],
        elevation: 0,
        title: Text('Profile'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.backspace_rounded),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 188, 186, 186),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30),
            InkWell(
              child: Container(
                child: Text('Profile'),
                width: 390,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white70,
                ),
              ),
              onTap: () {},
            ),
            SizedBox(height: 20),
            InkWell(
              child: Container(
                child: Text('Description of the application'),
                width: 360,
                height: 75,
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
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
                child: Text('Settings'),
                width: 360,
                height: 75,
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, Settings.routeName);
              },
            ),
            SizedBox(height: 20),
            Container(
              child: Text('Rate us'),
              width: 360,
              height: 75,
              decoration: BoxDecoration(
                color: Colors.white70,
              ),
            ),
            SizedBox(height: 20),
            Container(
              child: Text('Shere the app'),
              width: 360,
              height: 75,
              decoration: BoxDecoration(
                color: Colors.white70,
              ),
            ),
            SizedBox(height: 20),
            Container(
              child: Text('Technical support'),
              width: 360,
              height: 75,
              decoration: BoxDecoration(
                color: Colors.white70,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.read<FirebaseAuthMethods>().signOut(context);
              },
              child: Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}
