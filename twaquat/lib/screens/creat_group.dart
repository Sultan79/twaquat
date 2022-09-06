import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
          "users":[],
          "isPlublic":check2,
          "createdBy":FirebaseAuth.instance.currentUser!.uid,
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
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Title(color: Colors.black, child: const Text('Creat Group Page')),
          Container(
            padding: const EdgeInsets.all(34),
            child: Column(
              children: [
                _image != null
                    ? Image.file(
                        _image!,
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      )
                    : const FlutterLogo(size: 200)
              ],
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
              primary: Colors.blue,
              onPrimary: Colors.black,
              textStyle: const TextStyle(fontSize: 20),
            ),
            child: Row(
              children: const [
                Icon(Icons.browse_gallery_rounded, size: 28),
                SizedBox(width: 10),
                Text('Pick Gallery'),
              ],
            ),
            onPressed: () {
              pickImage();
            },
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextField(
              controller: groupnameControllar,
              hintText: 'Enter Group Name',
            ),
          ),
          const SizedBox(height: 30),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextField(
              controller: descriptionControllar,
              hintText: 'Write Description Here',
            ),
          ),
          
       CheckboxListTile( 
               value: check2,
               onChanged: (bool? value) {  
           setState(() {
                 check2 = value;
            });
          },
          title: Text("Click to make the group private"),
         ),
       ElevatedButton(onPressed: () {createGroup();}, child: const Text('Supmit Group'),),
        
        ElevatedButton(onPressed: (){ Navigator.pop(context); }, child: const Text('Groups Page')),
        ],
      ),
    );
  }
}
