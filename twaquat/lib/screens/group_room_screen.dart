import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:twaquat/services/gift.dart';
import 'package:twaquat/widgets/custom_tab_widget.dart';
import 'package:twaquat/widgets/gift_widget.dart';
import 'package:twaquat/widgets/groub_widget.dart';

class GroupRoomScreen extends StatefulWidget {
  const GroupRoomScreen({super.key, required this.id, required this.doc});
  final String id;
  final Map<String, dynamic> doc;

  static String routeName = '/groupsRoom';

  @override
  State<GroupRoomScreen> createState() => GroupRoomScreenState();
}

class GroupRoomScreenState extends State<GroupRoomScreen> {
  QuerySnapshot<Map<String, dynamic>>? allUsers;
  DocumentSnapshot<Map<String, dynamic>>? groupUsers;
  QuerySnapshot<Map<String, dynamic>>? groupAlerts;
  List allGroupUsersDocs = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllGroupUsers();
  }

  void getAllGroupUsers() async {
    allUsers = await FirebaseFirestore.instance
        .collection('users')
        .orderBy(
          "points",
          descending: true,
        )
        .get();

    groupUsers = await FirebaseFirestore.instance
        .collection('group')
        .doc(widget.id)
        .get();
    groupAlerts = await FirebaseFirestore.instance
        .collection('group')
        .doc(widget.id)
        .collection('alerts')
        .orderBy(
          "time",
          descending: true,
        )
        .get();
    print(groupAlerts!.docs);
    List allGroupUsersIDs = groupUsers!['users'];
    for (var doc in allUsers!.docs) {
      if (allGroupUsersIDs.contains(doc.id)) {
        allGroupUsersDocs.add(doc.data());
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print(widget.id);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        // title: Text(
        //   "Dedications",
        //   style: Theme.of(context).textTheme.bodyLarge,
        // ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.center,
              runSpacing: 20,
              children: [
                GroupWidget(
                  onClick: () {},
                  id: widget.id,
                  GroupName: widget.doc['groupName'],
                  GroupDescription: widget.doc['descirption'],
                  url: widget.doc['url'],
                  NumberOfMembers: widget.doc['users'].length.toString(),
                  isPublic: widget.doc['isPlublic'],
                ),
                SizedBox(
                  height: 70.h,
                  child: CustomTabWidget(
                    tabss: [
                      Tab(text: 'Ranking'),
                      Tab(text: 'Alerts'),
                      Tab(text: 'Gifts'),
                    ],
                    children: [
                      GroupRank(allUsers: allGroupUsersDocs),
                      Center(
                        child: groupAlerts!.docs.isEmpty
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset('assets/svg/Alert.svg'),
                                  Text('There is no Alert'),
                                  SizedBox(
                                    height: 100,
                                  ),
                                ],
                              )
                            : ListView.separated(
                                separatorBuilder: (context, index) => SizedBox(
                                  height: 10,
                                ),
                                itemCount: groupAlerts!.docs.length,
                                itemBuilder: (context, index) {
                                  // var userFromName;
                                  // var userToName;
                                  // for (var element in collection) {
                                  //   groupAlerts!.docs[index].data()['fromUser'];
                                  // }
                                  return AlertWidget(
                                    sender: groupAlerts!.docs[index]
                                        .data()['fromUserName'],
                                    receiver: groupAlerts!.docs[index]
                                        .data()['toUserName'],
                                    giftname:
                                        groupAlerts!.docs[index].data()['gift'],
                                  );
                                },
                              ),
                      ),
                      Center(
                          child: SizedBox(
                        width: 350,
                        child: AlignedGridView.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 15,
                          itemCount: 38,
                          itemBuilder: (context, index) {
                            return GiftWidget(
                              imageNumber: index,
                              users: allGroupUsersDocs,
                              groupId: widget.id,
                              groupName: widget.doc['groupName'],
                            );
                          },
                        ),
                      )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AlertWidget extends StatelessWidget {
  AlertWidget({
    super.key,
    this.url = 'https://shortest.link/5pLk',
    this.sender = 'sender',
    this.receiver = 'receiver',
    this.giftname = 'giftname',
  });

  final String url;
  final String sender;
  final String receiver;
  final String giftname;
  final Gifts gifts = Gifts();

  @override
  Widget build(BuildContext context) {
    String giftImage = '';
    for (var i = 0; i < gifts.giftsName.length; i++) {
      if (gifts.giftsName[i] == giftname) {
        giftImage = gifts.giftsImagePath[i];
      }
    }
    return Column(
      children: [
        Container(
          width: 350,
          height: 70,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey.shade300),
            color: Colors.white,
          ),
          child: Row(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: Colors.grey.shade400),
                ),
                child: Image.asset(
                  'assets/giftsImages/${giftImage}',
                  // fit: BoxFit.scaleDown,
                  cacheHeight: 30,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                height: 30,
                width: 265,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("${sender} send ${giftname} to ${receiver}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      // textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            fontSize: 11,
                            letterSpacing: 0,
                          )),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class GroupRank extends StatelessWidget {
  const GroupRank({
    super.key,
    required this.allUsers,
  });

  final List allUsers;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            height: 35.h,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.symmetric(
                horizontal: BorderSide(
                  color: Colors.grey.shade200,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                allUsers.length >= 3
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 82,
                                width: 82,
                                margin: EdgeInsets.only(bottom: 15),
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          width: 2,
                                        ),
                                        image: DecorationImage(
                                          image:
                                              NetworkImage(allUsers[2]["url"]),
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                ),
                              ),
                              Positioned.fill(
                                bottom: -5,
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Image.asset(
                                    'assets/images/ThirdPlace.png',
                                    height: 5.h,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                              height: 15,
                              width: 100,
                              child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(allUsers[2]["userName"]))),
                          Row(
                            children: [
                              SizedBox(
                                height: 15,
                                width: 35,
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    "${allUsers[2]["points"]}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontWeight: FontWeight.normal,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                  ),
                                ),
                              ),
                              Text(
                                'points',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                              ),
                            ],
                          )
                        ],
                      )
                    : SizedBox(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 108,
                          width: 108,
                          margin: EdgeInsets.only(bottom: 25),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                              color: Colors.grey.shade300,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    width: 2,
                                  ),
                                  image: DecorationImage(
                                    image: NetworkImage(allUsers[0]["url"]),
                                    fit: BoxFit.cover,
                                  )),
                            ),
                          ),
                        ),
                        Positioned.fill(
                          bottom: -10,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Image.asset(
                              'assets/images/FirstPlace.png',
                              height: 8.h,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                        height: 20,
                        width: 100,
                        child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(allUsers[0]["userName"]))),
                    Row(
                      children: [
                        SizedBox(
                          height: 15,
                          width: 35,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              "${allUsers[0]["points"]}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.normal,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                            ),
                          ),
                        ),
                        Text(
                          'points',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ],
                    )
                  ],
                ),
                allUsers.length >= 2
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 82,
                                width: 82,
                                margin: EdgeInsets.only(bottom: 15),
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          width: 2,
                                        ),
                                        image: DecorationImage(
                                          image:
                                              NetworkImage(allUsers[1]["url"]),
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                ),
                              ),
                              Positioned.fill(
                                bottom: -5,
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Image.asset(
                                    'assets/images/SecondPlace.png',
                                    height: 5.h,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                              height: 15,
                              width: 100,
                              child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(allUsers[1]["userName"]))),
                          Row(
                            children: [
                              SizedBox(
                                height: 15,
                                width: 35,
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    "${allUsers[1]["points"]}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontWeight: FontWeight.normal,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                  ),
                                ),
                              ),
                              Text(
                                'points',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                              ),
                            ],
                          )
                        ],
                      )
                    : SizedBox(),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
          flex: 2,
          child: allUsers.length >= 4
              ? ListView.builder(
                  itemCount: allUsers.length - 3,
                  itemExtent: 80,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          height: 70,
                          width: 350,
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            allUsers[index + 3]["url"]),
                                        fit: BoxFit.cover,
                                      )),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          allUsers[index + 3]["userName"],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "${allUsers[index + 3]["points"]}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                  ),
                                            ),
                                            Text(
                                              " points",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Correct predictions: ",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.normal),
                                            ),
                                            Text(
                                              "${allUsers[index + 3]["correctGuess"]}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primary),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                )
              : SizedBox(),
        ),
      ],
    );
  }
}
