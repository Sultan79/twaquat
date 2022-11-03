import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twaquat/screens/company_group_room_screen.dart';
import 'package:twaquat/screens/creat_group.dart';
import 'package:twaquat/screens/group_room_screen.dart';
import 'package:twaquat/services/send_email.dart';
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
                                  'Send Request To Join'.tr(),
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: <Widget>[
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 250,
                                            height: 70,
                                            child: Text(
                                                'this will open your email service to send to us your request'
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
                                          'Continue'.tr(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(color: Colors.white),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          SendEmailToJoinCompany();
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Text('Companies joining'.tr()),
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
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return Expanded(
                            child: ListView.separated(
                              itemCount: 6,
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 10),
                              padding: EdgeInsets.only(top: 10),
                              itemBuilder: (context, index) => Column(
                                children: [
                                  FadeShimmer(
                                    height: 100,
                                    width: 350,
                                    radius: 15,
                                    highlightColor:
                                        Color.fromARGB(255, 231, 231, 231),
                                    baseColor: Color(0xffE6E8EB),
                                  ),
                                ],
                              ),
                            ),
                          );

                        default:
                          return Expanded(
                            child: RefreshIndicator(
                              onRefresh: () async {
                                setState(() {});
                              },
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
                                        doc['isCompany']
                                            ? MaterialPageRoute(
                                                builder: (context) =>
                                                    CompanyGroupRoomScreen(
                                                      id: id,
                                                      doc: doc,
                                                    ))
                                            : MaterialPageRoute(
                                                builder: (context) =>
                                                    GroupRoomScreen(
                                                      id: id,
                                                      doc: doc,
                                                    )),
                                      ),
                                      id: id,
                                      GroupName: doc['groupName'],
                                      GroupDescription: doc['descirption'],
                                      url: doc['url'],
                                      NumberOfMembers:
                                          doc['users'].length.toString(),
                                      isPublic: doc['isPlublic'],
                                      isCompany: doc['isCompany'],
                                    );
                                  }),
                            ),
                          );
                      }
                    })
              ],
            ),
          ),
        ));
  }
}
