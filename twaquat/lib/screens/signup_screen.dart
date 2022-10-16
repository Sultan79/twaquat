// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twaquat/services/dropDown_flags.dart';
import 'package:twaquat/services/firebase_auth_methods.dart';
import 'package:twaquat/utils/showSnackbar.dart';
import 'package:twaquat/widgets/flags_dropdown.dart';
import 'package:twaquat/widgets/custom_filedText.dart';
import 'package:twaquat/widgets/custom_textfield.dart';
import 'package:twaquat/services/fireStorage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Signup_Screen extends StatefulWidget {
  static String routeName = '/signup-email-password';
  const Signup_Screen({Key? key}) : super(key: key);
  @override
  _Signup_ScreenState createState() => _Signup_ScreenState();
}

class _Signup_ScreenState extends State<Signup_Screen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameControllar = TextEditingController();
  File? _image;

  final FirebaseAuth auth = FirebaseAuth.instance;

  // String inputData() {
  //   final User? user = auth.currentUser;
  //   final uid = user!.uid;
  //   // here you write the codes to input the data into firestore
  //   return uid;
  // }

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  void signUpUser() async {
    String? uid_plus;
    String? url_plus;
    final snackBar = SnackBar(
      content: Text('Yay! A SnackBar!'.tr()),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );
    final Storage storage = Storage();
    final flags = context.read<DropDownFlags>().toMap();
    if (_image == null) {
      showSnackBar(context, 'Pick image first'.tr());
    } else {
      await context
          .read<FirebaseAuthMethods>()
          .signUpWithEmail(
            email: emailController.text,
            password: passwordController.text,
            context: context,
          )
          .then(
        (value) async {
          url_plus = await storage.uploadFile(
              _image!.path, _image!.path.split('/').last);
          FirebaseFirestore.instance
              .collection('users')
              .doc(auth.currentUser!.uid)
              .set(
            {
              'userName': usernameControllar.text,
              'userEmail': emailController.text,
              'myCuntry': flags['flag1'],
              'firstWinner': flags['flag2'],
              'secondWinner': flags['flag3'],
              'id': auth.currentUser!.uid,
              'url': url_plus!,
              'correctGuess': 0,
              'wrongGuess': 0,
              'rating': 0,
              'points': 0,
            },
          ).then((value) => Navigator.pushReplacementNamed(context, '/'));
        },
      );
    }
  }

  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageTemporary = File(image.path);
    setState(() => _image = imageTemporary);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Create an account".tr(),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Align(
              alignment: Alignment.topCenter,
              child: Wrap(
                alignment: WrapAlignment.center,
                runSpacing: 25,
                spacing: 1000,
                children: [
                  InkWell(
                    onTap: () => pickImage(),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(150),
                          child: Container(
                            height: 150,
                            width: 150,
                            color: Colors.white,
                            child: _image != null
                                ? Image.file(
                                    _image!,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    "assets/images/avatar2.png",
                                  ),
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: Container(
                            // padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: SvgPicture.asset('assets/svg/Exclude.svg'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomFiledText(
                    controller: usernameControllar,
                    title: 'Name'.tr(),
                    hintText: 'Enter your name here'.tr(),
                  ),
                  CustomFiledText(
                    controller: emailController,
                    title: 'Email'.tr(),
                    hintText: 'Enter your email here'.tr(),
                  ),
                  CustomFiledText(
                    controller: passwordController,
                    title: 'Password'.tr(),
                    hintText: 'Enter your password here'.tr(),
                  ),
                  FlagsDropDown(
                    data: 1,
                    hint: "Pick one".tr(),
                    title: 'Pick your Country'.tr(),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      'Pick your predictions for World Cup winner'.tr(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FlagsDropDown(
                          data: 2,
                          width: 100,
                          hint: "Pick".tr(),
                          title: 'First'.tr(),
                        ),
                        SizedBox(
                          width: 100,
                        ),
                        FlagsDropDown(
                          data: 3,
                          width: 100,
                          hint: "Pick".tr(),
                          title: 'Second'.tr(),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      TextButton(
                        onPressed: () =>
                            Navigator.pushReplacementNamed(context, '/'),
                        child: Text('Login'.tr()),
                      ),
                      SizedBox(
                        height: 60,
                        width: 350,
                        child: ElevatedButton(
                          onPressed: signUpUser,
                          child: Text(
                            "Sign Up".tr(),
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
