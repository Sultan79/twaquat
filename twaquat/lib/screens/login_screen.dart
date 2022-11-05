import 'package:easy_localization/easy_localization.dart';
import 'package:twaquat/services/firebase_auth_methods.dart';
import 'package:twaquat/widgets/custom_filedText.dart';
import 'package:twaquat/widgets/custom_textfield.dart';
import 'package:twaquat/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = '/login-email-password';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameControllar = TextEditingController();
  void loginUser() {
    context.read<FirebaseAuthMethods>().loginWithEmail(
          username: usernameControllar.text,
          email: emailController.text,
          password: passwordController.text,
          context: context,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Wrap(
          alignment: WrapAlignment.center,
          runSpacing: 25,
          spacing: 1000,
          children: [
            // Text(
            //   "Login".tr(),
            //   style: TextStyle(fontSize: 30),
            // ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.08),
            CustomFiledText(
              controller: emailController,
              title: 'Email'.tr(),
              hintText: 'Enter your email here'.tr(),
            ),
            CustomFiledText(
              controller: passwordController,
              title: 'Password'.tr(),
              hintText: 'Enter your password here'.tr(),
              obscureText: true,
            ),
            const SizedBox(height: 40),
            Column(
              children: [
                SizedBox(
                  height: 50,
                  width: 350,
                  child: ElevatedButton(
                    onPressed: loginUser,
                    child: Text(
                      "Login".tr(),
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Signup_Screen()),
                    );
                  },
                  child: Text(
                    'Sign Up'.tr(),
                    // style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
