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
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twaquat/screens/creat_company_group.dart';
import 'package:twaquat/services/firebase_dynamic_link.dart';
import 'package:twaquat/utils/showSnackbar.dart';
import 'package:twaquat/services/fireStorage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:twaquat/widgets/custom_filedText.dart';
import 'package:twaquat/widgets/custom_textfield.dart';

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
                                            'Make sure to upload a .json file with the correct format'
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
                SizedBox(
                  height: 60,
                  width: 350,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, CreateCompnyGroupScreen.routeName);
                    },
                    child: Text('Create Company Group'.tr()),
                  ),
                ),
                SizedBox(
                  height: 60,
                  width: 350,
                  child: ElevatedButton(
                    onPressed: () async {
                      uploadImage();
                    },
                    child: Text('Upload AD Image'.tr()),
                  ),
                ),
                SizedBox(
                  height: 60,
                  width: 350,
                  child: ElevatedButton(
                    onPressed: () async {
                      uploadImageLink();
                    },
                    child: Text('Upload AD Link'.tr()),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  uploadQuiz(BuildContext context) async {
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

  uploadImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageFile = File(image.path);
    final fileName = imageFile.hashCode.toString();
    String? url;
    var fireStore = FirebaseFirestore.instance.collection('ad');
    var collection = await fireStore.get();
    try {
      print('Group Image has been saved');
      await firebase_storage.FirebaseStorage.instance
          .ref('ad/$fileName')
          .putFile(imageFile)
          .then((p0) async => url = await p0.ref.getDownloadURL());

      await FirebaseFirestore.instance.collection('ad').doc().set({
        'adNumber': collection.docs.length,
        'url': url,
      });
      showSnackBar(context, 'the image is set'.tr());
    } on firebase_core.FirebaseException catch (e) {
      print('e.message');
      print(e.message);
    }
  }

  uploadImageLink() async {
    TextEditingController controller = TextEditingController();
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
          actionsPadding: EdgeInsets.only(bottom: 10, right: 20, left: 20),
          contentPadding: EdgeInsets.only(top: 10),
          title: Text(
            'AD Click link'.tr(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 250,
                      height: 40,
                      child: Text(
                        'this link will be set for the AD image for user to click on'
                            .tr(),
                        textAlign: TextAlign.center,
                        // textWidthBasis: TextWidthBasis.parent,
                        overflow: TextOverflow.fade,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.normal),
                      ),
                    ),
                    SizedBox(
                      height: 110,
                      width: 250,
                      child: CustomFiledText(
                        controller: controller,
                        hintText: 'Link',
                        title: '',
                      ),
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
                    'Set Link'.tr(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.white),
                  ),
                  onPressed: () async {
                    var fireStore = FirebaseFirestore.instance
                        .collection('ad')
                        .orderBy('adNumber', descending: true)
                        .limit(1);
                    var collection = await fireStore.get();
                    controller.text.trim().isNotEmpty
                        ? {
                            Navigator.pop(context),
                            await FirebaseFirestore.instance
                                .collection('ad')
                                .doc(collection.docs.first.id)
                                .update({
                              'link': controller.text.trim(),
                            }),
                            showSnackBar(context, 'the link is set'.tr())
                          }
                        : showSnackBar(context, 'the link is empty'.tr());
                    ;
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
