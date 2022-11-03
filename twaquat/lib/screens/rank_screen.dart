import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class RankScreen extends StatefulWidget {
  const RankScreen({super.key});
  static String routeName = '/rank';

  @override
  State<RankScreen> createState() => _RankScreenState();
}

class _RankScreenState extends State<RankScreen> {
  QuerySnapshot<Map<String, dynamic>>? allUsers;
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   getAllUsers();
  // }

  Future<void> getAllUsers() async {
    allUsers = await FirebaseFirestore.instance
        .collection('users')
        .orderBy(
          "points",
          descending: true,
        )
        .get();
    print(allUsers!.docs[0]["points"]);
    // setState(() {});
    // for (var doc in allUsers!.docs) {
    //   print(doc['points']);
    // }
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
          "Overall Rank".tr(),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: FutureBuilder(
          future: getAllUsers(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Column(
                  children: [
                    Container(
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
                          Column(
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
                                    child: FadeShimmer.round(
                                      size: 82,
                                      highlightColor:
                                          Color.fromARGB(255, 227, 227, 227),
                                      baseColor: Color(0xffE6E8EB),
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
                            ],
                          ),
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
                                    child: FadeShimmer.round(
                                      size: 82,
                                      highlightColor:
                                          Color.fromARGB(255, 227, 227, 227),
                                      baseColor: Color(0xffE6E8EB),
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
                            ],
                          ),
                          Column(
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
                                    child: FadeShimmer.round(
                                      size: 82,
                                      highlightColor:
                                          Color.fromARGB(255, 227, 227, 227),
                                      baseColor: Color(0xffE6E8EB),
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
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 250,
                      child: ListView.separated(
                        itemCount: 2,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 10),
                        padding: EdgeInsets.only(top: 10),
                        itemBuilder: (context, index) => Column(
                          children: [
                            FadeShimmer(
                              height: 70,
                              width: 350,
                              radius: 15,
                              highlightColor:
                                  Color.fromARGB(255, 227, 227, 227),
                              baseColor: Color(0xffE6E8EB),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              default:
                return Column(
                  children: [
                    Expanded(
                      flex: 1,
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
                            allUsers!.docs.length >= 3
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
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              border: Border.all(
                                                color: Colors.grey.shade300,
                                              ),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    border: Border.all(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primary,
                                                      width: 2,
                                                    ),
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          allUsers!.docs[2]
                                                              ["url"]),
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
                                              child: Text(allUsers!.docs[2]
                                                  ["userName"]))),
                                      Row(
                                        children: [
                                          SizedBox(
                                            height: 15,
                                            width: 35,
                                            child: FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Text(
                                                "${allUsers!.docs[2]["points"]}",
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
                                            ),
                                          ),
                                          Text(
                                            'points'.tr(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
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
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              border: Border.all(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                width: 2,
                                              ),
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    allUsers!.docs[0]["url"]),
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
                                        child: Text(
                                            allUsers!.docs[0]["userName"]))),
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 15,
                                      width: 35,
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          "${allUsers!.docs[0]["points"]}",
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
                                      'points'.tr(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            allUsers!.docs.length >= 2
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
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              border: Border.all(
                                                color: Colors.grey.shade300,
                                              ),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    border: Border.all(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primary,
                                                      width: 2,
                                                    ),
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          allUsers!.docs[1]
                                                              ["url"]),
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
                                              child: Text(allUsers!.docs[1]
                                                  ["userName"]))),
                                      Row(
                                        children: [
                                          SizedBox(
                                            height: 15,
                                            width: 35,
                                            child: FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Text(
                                                "${allUsers!.docs[1]["points"]}",
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
                                            ),
                                          ),
                                          Text(
                                            'points'.tr(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
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
                      child: allUsers!.docs.length >= 4
                          ? RefreshIndicator(
                              onRefresh: () async => getAllUsers(),
                              child: ListView.builder(
                                itemCount: allUsers!.docs.length - 3,
                                itemExtent: 80,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      Stack(
                                        children: [
                                          Container(
                                            height: 15,
                                            width: 60,
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .background,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.military_tech,
                                                    size: 15,
                                                  ),
                                                  SizedBox(width: 5),
                                                  Text(
                                                    "${index + 3}",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .copyWith(
                                                          // color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 70,
                                            width: 350,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 20),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              border: Border.all(
                                                  color: Colors.grey.shade300),
                                            ),
                                            child: Row(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  child: Container(
                                                    height: 50,
                                                    width: 50,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        border: Border.all(
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .primary,
                                                        ),
                                                        image: DecorationImage(
                                                          image: NetworkImage(
                                                              allUsers!.docs[
                                                                      index + 3]
                                                                  ["url"]),
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
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            allUsers!.docs[
                                                                    index + 3]
                                                                ["userName"],
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text(
                                                                "${allUsers!.docs[index + 3]["points"]}",
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyMedium!
                                                                    .copyWith(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      color: Theme.of(
                                                                              context)
                                                                          .colorScheme
                                                                          .primary,
                                                                    ),
                                                              ),
                                                              Text(
                                                                " " +
                                                                    "points"
                                                                        .tr(),
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyMedium!
                                                                    .copyWith(
                                                                      color: Theme.of(
                                                                              context)
                                                                          .colorScheme
                                                                          .primary,
                                                                    ),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                "Correct predictions"
                                                                        .tr() +
                                                                    ": ",
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyMedium!
                                                                    .copyWith(
                                                                        fontWeight:
                                                                            FontWeight.normal),
                                                              ),
                                                              Text(
                                                                "${allUsers!.docs[index + 3]["correctGuess"]}",
                                                                style: Theme.of(
                                                                        context)
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
                                          Positioned(
                                            top: 0,
                                            width: 350,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Container(
                                                  height: 20,
                                                  width: 60,
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .background,
                                                    border: Border.all(
                                                        color: Colors
                                                            .grey.shade300),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  child: FittedBox(
                                                    fit: BoxFit.scaleDown,
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.military_tech,
                                                          size: 15,
                                                        ),
                                                        SizedBox(width: 5),
                                                        Text(
                                                          "${index + 4}",
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .copyWith(
                                                                    // color: Colors.white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                  ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              ),
                            )
                          : SizedBox(),
                    ),
                  ],
                );
            }
          }),
    );
  }
}
