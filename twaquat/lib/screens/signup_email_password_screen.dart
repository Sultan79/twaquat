// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:twaquat/services/firebase_auth_methods.dart';
import 'package:twaquat/widgets/custom_textfield.dart';
import 'package:twaquat/services/fireStorage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EmailPasswordSignup extends StatefulWidget {
  static String routeName = '/signup-email-password';
  const EmailPasswordSignup({Key? key}) : super(key: key);
  @override
  _EmailPasswordSignupState createState() => _EmailPasswordSignupState();
}

class _EmailPasswordSignupState extends State<EmailPasswordSignup> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameControllar = TextEditingController();
  File? _image;

  final FirebaseAuth auth = FirebaseAuth.instance;

  String inputData() {
    final User? user = auth.currentUser;
    final uid = user!.uid;
    // here you write the codes to input the data into firestore
    return uid;
  }

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  void signUpUser() async {
    print('object');
    String? uid_plus;
    String? url_plus;
    final Storage storage = Storage();

    await context
        .read<FirebaseAuthMethods>()
        .signUpWithEmail(
          email: emailController.text,
          password: passwordController.text,
          context: context,
        )
        .then((value) => uid_plus = inputData())
        .then((value) async => url_plus = await uploadImage(context, storage));
    print("_________________________________________________________");
    FirebaseFirestore.instance.collection('users').doc(uid_plus).set({
          'userName': usernameControllar.text,
          'userEmail': emailController.text,
          'id': uid_plus!,
          'url': url_plus!,
        })
        .then((value) => print("::::::::::::::::::::::::::::::::::::::::"))
        .catchError((error) => print("Failed to add user: $error"));
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Sign Up",
            style: TextStyle(fontSize: 30),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size.fromHeight(56),
              primary: Colors.blue,
              onPrimary: Colors.black,
              textStyle: TextStyle(fontSize: 20),
            ),
            child: Row(
              children: [
                Icon(Icons.browse_gallery_rounded, size: 28),
                const SizedBox(width: 16),
                Text('Pick Gallery'),
              ],
            ),
            onPressed: () {
              pickImage();
            },
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                _image != null
                    ? Image.file(
                        _image!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      )
                    : FlutterLogo(
                        size: 100,
                      )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextField(
              controller: usernameControllar,
              hintText: 'Enter your Username',
            ),
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextField(
              controller: emailController,
              hintText: 'Enter your email',
            ),
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextField(
              controller: passwordController,
              hintText: 'Enter your password',
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: signUpUser,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
              textStyle: MaterialStateProperty.all(
                const TextStyle(color: Colors.white),
              ),
              minimumSize: MaterialStateProperty.all(
                Size(MediaQuery.of(context).size.width / 1.5, 40),
              ),
            ),
            child: const Text(
              "Sign Up",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Login'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
              textStyle: MaterialStateProperty.all(
                const TextStyle(color: Colors.white),
              ),
              minimumSize: MaterialStateProperty.all(
                Size(MediaQuery.of(context).size.width / 1.5, 40),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<String> uploadImage(BuildContext context, Storage storage) async {
    final results = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg'],
    );
    if (results == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No file has been selected'),
        ),
      );
    }
    final path = results!.files.single.path!;
    final fileName = results.files.single.name;
    return storage.uploadFile(path, fileName);
  }
}
