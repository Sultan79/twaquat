import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twaquat/screens/creat_group.dart';
import 'package:twaquat/screens/group_room_screen.dart';
import 'package:twaquat/services/user_details.dart';
import 'package:twaquat/widgets/groub_widget.dart';
import 'package:twaquat/widgets/groupProfile.dart';

class GroupsPage extends StatefulWidget {
  static String routeName = '/groupsPage';
  GroupsPage({Key? key}) : super(key: key);

  @override
  State<GroupsPage> createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  final List _posts = ['profile 1', 'profile 2', 'profile 3', 'profile 4'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            "Groups".tr(),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 25.0),
          child: SafeArea(
            bottom: false,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 170,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text('Companies joing'.tr()),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 170,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pushNamed(
                            context, CreateGroupScreen.routeName),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.black),
                          side: MaterialStateProperty.all(
                              BorderSide(color: Colors.grey.shade300)),
                        ),
                        child: Text('Create a group'.tr()),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    future: FirebaseFirestore.instance
                        .collection('group')
                        .where('users',
                            arrayContains: context.read<UserDetails>().id)
                        .get(),
                    builder: (context, snapshot) {
                      return Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data!.size,
                            itemExtent: 120,
                            itemBuilder: (context, index) {
                              Map<String, dynamic> doc =
                                  snapshot.data!.docs[index].data();
                              String id = snapshot.data!.docs[index].id;
                              return GroupWidget(
                                onClick: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => GroupRoomScreen(
                                            id: id,
                                            doc: doc,
                                          )),
                                ),
                                GroupName: doc['groupName'],
                                GroupDescription: doc['descirption'],
                                url: doc['url'],
                                NumberOfMembers: doc['users'].length.toString(),
                                isPublic: doc['isPlublic'],
                              );
                            }),
                      );
                    })
              ],
            ),
          ),
        ));
  }
}
