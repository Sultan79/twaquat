import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:twaquat/services/user_details.dart';
import 'package:twaquat/widgets/custom_filedText.dart';
import 'package:twaquat/widgets/custom_textfield.dart';
import '../services/fireStorage.dart';
import '../services/firebase_auth_methods.dart';
import 'package:twaquat/screens/groups_page.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({Key? key}) : super(key: key);
  static String routeName = '/CreateGroupScreen';
  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final TextEditingController groupnameControllar = TextEditingController();
  final TextEditingController descriptionControllar = TextEditingController();
  File? _image;

  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageTemporary = File(image.path);
    setState(() => _image = imageTemporary);
  }

  void createGroup() async {
    print('object');
    String? uid_plus;
    String? url_plus;
    final Storage storage = Storage();
    url_plus = await uploadImage(context, storage);

    FirebaseFirestore.instance
        .collection('group')
        .doc()
        .set({
          'groupName': groupnameControllar.text.trim(),
          'descirption': descriptionControllar.text.trim(),
          'url': url_plus,
          "users": [context.read<UserDetails>().id],
          "isPlublic": _selectedGroupType[0],
          "createdBy": FirebaseAuth.instance.currentUser!.uid,
        })
        .then((value) => print("::::::::::::::::::::::::::::::::::::::::"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<String> uploadImage(BuildContext context, Storage storage) async {
    final path = _image!.path;
    final fileName = _image!.hashCode.toString();
    return storage.uploadFileGroup(path, fileName);
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.red;
  }

  bool? check2 = true;
  final List<bool> _selectedGroupType = <bool>[false, true];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Create a group",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            InkWell(
              onTap: () => pickImage(),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(1000),
                child: Container(
                  height: 150,
                  width: 150,
                  // padding: const EdgeInsets.all(34),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).colorScheme.primary),
                    shape: BoxShape.circle,
                  ),
                  child: _image != null
                      ? Image.file(
                          _image!,
                          fit: BoxFit.cover,
                        )
                      : const FlutterLogo(size: 200),
                ),
              ),
            ),
            const SizedBox(height: 20),
            CustomFiledText(
              controller: groupnameControllar,
              title: "Name",
              hintText: "Enter your group name",
            ),
            const SizedBox(height: 30),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Description'),
                  SizedBox(
                    height: 13,
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Colors.grey.shade300,
                      ),
                    ),
                    width: 350,
                    height: 160,
                    child: TextField(
                      controller: descriptionControllar,
                      textAlignVertical: TextAlignVertical.top,
                      minLines: 1,
                      maxLines: 7,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        hintText:
                            'Enter teh description related to your groub here',
                        hintStyle: Theme.of(context).textTheme.labelLarge,
                        fillColor: Colors.red,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Row(
                children: [
                  Text(
                    "Groub Type",
                  ),
                ],
              ),
            ),
            ToggleButtons(
              direction: Axis.horizontal,
              onPressed: (int index) {
                setState(() {
                  // The button that is tapped is set to true, and the others to false.
                  for (int i = 0; i < _selectedGroupType.length; i++) {
                    _selectedGroupType[i] = i == index;
                  }
                });
              },
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              selectedBorderColor: Theme.of(context).colorScheme.primary,
              selectedColor: Colors.white,
              fillColor: Theme.of(context).colorScheme.primary,
              color: Theme.of(context).colorScheme.primary,
              constraints: const BoxConstraints(
                minHeight: 50.0,
                minWidth: 175.0,
              ),
              children: <Widget>[Text('Public Groub'), Text('Private Group')],
              isSelected: _selectedGroupType,
            ),
            SizedBox(
              height: 35,
            ),
            SizedBox(
              height: 60,
              width: 350,
              child: ElevatedButton(
                onPressed: () {
                  createGroup();
                },
                child: Text(
                  'Supmit Group',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 35,
            ),
          ],
        ),
      ),
    );
  }
}
