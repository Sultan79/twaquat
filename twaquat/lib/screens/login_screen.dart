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
            const Text(
              "Login",
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.08),
            CustomFiledText(
              controller: emailController,
              title: 'Email',
              hintText: 'Enter your email here',
            ),
            CustomFiledText(
              controller: passwordController,
              title: 'Password',
              hintText: 'Enter your password here',
            ),
            const SizedBox(height: 40),
            Column(
              children: [
                SizedBox(
                  height: 50,
                  width: 350,
                  child: ElevatedButton(
                    onPressed: loginUser,
                    child: const Text(
                      "Login",
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
                  child: const Text(
                    'Sign Up',
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
