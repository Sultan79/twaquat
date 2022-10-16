import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:twaquat/screens/creat_company_group.dart';
import 'package:twaquat/utils/showSnackbar.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles();
                    final File fileFor = File(result!.files.first.path!);
                    var ref = await FirebaseStorage.instance
                        .ref('quizzes')
                        .child('${result.files.first.name}');
                    ref.putFile(fileFor);
                    String url = (await ref.getDownloadURL()).toString();
                    CollectionReference<Map<String, dynamic>> fireStore =
                        FirebaseFirestore.instance.collection('quizzes');
                    QuerySnapshot<Map<String, dynamic>> collection =
                        await fireStore.get();
                    fireStore.add({
                      'number': collection.docs.length,
                      'url': url,
                    }).whenComplete(() =>
                        showSnackBar(context, 'File uploaded successfully'));
                  },
                  child: Text('Upload new Quiz'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    // var userDoc = FirebaseFirestore.instance
                    //     .collection('users')
                    //     .doc(FirebaseAuth.instance.currentUser!.uid);
                    // var userFilds = await userDoc.get();
                    // List userQuizzes = userFilds.data()!['quizzes'];
                    // print(userFilds.data()!['quizzes']);
                    // userQuizzes.add(false);
                    // userDoc.update({'quizzes': userQuizzes});

                    var fbFixture = FirebaseFirestore.instance
                        .collection('fixtures')
                        .doc('1');
                    var fixtureDco = await fbFixture.get();
                    print(fixtureDco.data());
                    print(fixtureDco.data()!['home']);
                  },
                  child: Text('test'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    Navigator.pushNamed(
                        context, CreateCompnyGroupScreen.routeName);
                  },
                  child: Text('Create Compony Group'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
