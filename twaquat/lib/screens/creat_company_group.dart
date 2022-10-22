import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:twaquat/services/user_details.dart';
import 'package:twaquat/widgets/custom_filedText.dart';
import 'package:twaquat/widgets/custom_textfield.dart';
import '../services/fireStorage.dart';
import '../services/firebase_auth_methods.dart';
import 'package:twaquat/screens/groups_page.dart';

class CreateCompnyGroupScreen extends StatefulWidget {
  const CreateCompnyGroupScreen({Key? key}) : super(key: key);
  static String routeName = '/CreateCompanyGroupScreen';
  @override
  State<CreateCompnyGroupScreen> createState() =>
      _CreateCompnyGroupScreenState();
}

class _CreateCompnyGroupScreenState extends State<CreateCompnyGroupScreen> {
  final TextEditingController groupnameControllar = TextEditingController();
  final TextEditingController descriptionControllar = TextEditingController();
  File? _image;
  bool? check2 = true;
  final List<bool> _selectedGroupType = <bool>[false, true];
  int itemCount2 = 1;
  List<TextEditingController> departmentsNameController = [
    TextEditingController()
  ];

  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageTemporary = File(image.path);
    setState(() => _image = imageTemporary);
  }

  void createGroup() async {
    List<String> allDepartmentNames = [];
    for (var element in departmentsNameController) {
      allDepartmentNames.add(element.text);
    }
    print(allDepartmentNames);
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
          "isPlublic": false,
          "isCompany": true,
          "department": allDepartmentNames,
          "createdBy": FirebaseAuth.instance.currentUser!.uid,
        })
        .then((value) => Navigator.pop(context))
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
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
                Wrap(
                  direction: Axis.horizontal,
                  spacing: 20,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          itemCount2++;
                          departmentsNameController
                              .add(TextEditingController());
                          print("items = $itemCount2");
                          print("deper  = ${departmentsNameController.length}");
                          setState(() {});
                        },
                        child: Text("Add list")),
                    ElevatedButton(
                        onPressed: () {
                          if (itemCount2 == 1) {
                            return;
                          }
                          itemCount2--;
                          departmentsNameController.removeLast();
                          print("items = $itemCount2");
                          print("deper  = ${departmentsNameController.length}");
                          setState(() {});
                        },
                        child: Text("Remove list")),
                  ],
                ),
                SizedBox(
                  height: 13.h * itemCount2,
                  width: 350,
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemCount: itemCount2,
                    separatorBuilder: (context, index) => SizedBox(height: 20),
                    itemBuilder: (context, index) {
                      return CustomFiledText(
                        controller: departmentsNameController[index],
                        title: 'Department Name ',
                        hintText: 'Enter department name',
                      );
                    },
                  ),
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
          ],
        ),
      ),
    );
  }
}
