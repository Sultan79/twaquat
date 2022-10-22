import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
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
            child: Wrap(
              runSpacing: 20,
              children: [
                SizedBox(
                  height: 60,
                  width: 350,
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            titlePadding: EdgeInsets.only(top: 40),
                            actionsPadding: EdgeInsets.only(
                                bottom: 10, right: 20, left: 20),
                            contentPadding: EdgeInsets.only(top: 10),
                            title: Text(
                              'Quiz'.tr(),
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 250,
                                        height: 70,
                                        child: Text(
                                            'Make sure to upload ".json" file with the correct formate'
                                                .tr(),
                                            textAlign: TextAlign.center,
                                            // textWidthBasis: TextWidthBasis.parent,
                                            overflow: TextOverflow.fade,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.normal)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              Center(
                                child: SizedBox(
                                  height: 65,
                                  width: 300,
                                  child: ElevatedButton(
                                    child: Text(
                                      'Upload Quiz'.tr(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(color: Colors.white),
                                    ),
                                    onPressed: () {
                                      uploadQuiz(context);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text('Upload new Quiz'.tr()),
                  ),
                ),
                // ElevatedButton(
                //   onPressed: () async {
                //     // var userDoc = FirebaseFirestore.instance
                //     //     .collection('users')
                //     //     .doc(FirebaseAuth.instance.currentUser!.uid);
                //     // var userFilds = await userDoc.get();
                //     // List userQuizzes = userFilds.data()!['quizzes'];
                //     // print(userFilds.data()!['quizzes']);
                //     // userQuizzes.add(false);
                //     // userDoc.update({'quizzes': userQuizzes});

                //     var fbFixture = FirebaseFirestore.instance
                //         .collection('fixtures')
                //         .doc('1');
                //     var fixtureDco = await fbFixture.get();
                //     print(fixtureDco.data());
                //     print(fixtureDco.data()!['home']);
                //   },
                //   child: Text('test'),
                // ),
                SizedBox(
                  height: 60,
                  width: 350,
                  child: ElevatedButton(
                    onPressed: () async {
                      Navigator.pushNamed(
                          context, CreateCompnyGroupScreen.routeName);
                    },
                    child: Text('Create Compony Group'.tr()),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> uploadQuiz(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    final File fileFor = File(result!.files.first.path!);
    var ref = await FirebaseStorage.instance
        .ref('quizzes')
        .child('${result.files.first.name}');
    ref.putFile(fileFor);
    String url = (await ref.getDownloadURL()).toString();
    CollectionReference<Map<String, dynamic>> fireStore =
        FirebaseFirestore.instance.collection('quizzes');
    QuerySnapshot<Map<String, dynamic>> collection = await fireStore.get();
    fireStore.add({
      'number': collection.docs.length,
      'url': url,
    }).whenComplete(() => {
          showSnackBar(context, 'File uploaded successfully'.tr()),
          Navigator.of(context).pop()
        });
  }
}
