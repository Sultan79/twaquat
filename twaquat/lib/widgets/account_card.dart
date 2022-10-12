// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AccountCard extends StatelessWidget {
  const AccountCard({
    Key? key,
    this.name = 'Ahmed Al-Aklouk asdfasdf',
    this.points = '2500',
    this.correctGuess = '25',
    this.wrongGuess = '25',
    this.image,
    this.firestTeam = 'USA',
    this.seacondTeam = 'USA',
    this.thirdTeam = 'USA',
    this.rating = 3.5,
  }) : super(key: key);

  final String name;
  final String points;
  final String correctGuess;
  final String wrongGuess;
  final String? image;
  final String firestTeam;
  final String seacondTeam;
  final String thirdTeam;
  final double rating;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 350,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 100,
                      width: 90,
                      // padding: EdgeInsets.all(2.5),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.background,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: image == null
                          ? Image.asset('assets/images/avatar.png')
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(11),
                              child: Image.network(
                                image!,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                    Positioned(
                      bottom: 5,
                      right: 5,
                      child: Container(
                        padding: EdgeInsets.all(1.5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: CircleAvatar(
                          radius: 10,
                          backgroundImage:
                              AssetImage("assets/flags/${firestTeam}.png"),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.amberAccent,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(1.5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: CircleAvatar(
                          radius: 10,
                          backgroundImage:
                              AssetImage("assets/flags/${seacondTeam}.png"),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(1.5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: CircleAvatar(
                          radius: 10,
                          backgroundImage:
                              AssetImage("assets/flags/${thirdTeam}.png"),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 140,
                        child: Text(
                          name,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      Container(
                        height: 30,
                        width: 70,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Row(
                            children: [
                              SvgPicture.asset('assets/svg/Coins.svg'),
                              SizedBox(width: 5),
                              Text(points),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.grey.shade300,
                    thickness: 1,
                    endIndent: 10,
                    indent: 10,
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 30,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(5),
                              // border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                // SvgPicture.asset(
                                //   'assets/svg/Coins.svg',
                                //   color: Colors.white,
                                // ),
                                Icon(Icons.check,
                                    size: 15, color: Colors.white),
                                SizedBox(width: 5),
                                SizedBox(
                                  width: 40,
                                  child: Text(
                                    correctGuess,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 30,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(5),
                          // border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // SvgPicture.asset(
                            //   'assets/svg/Coins.svg',
                            //
                            // ),
                            Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 15,
                            ),
                            SizedBox(width: 5),
                            SizedBox(
                              width: 40,
                              child: Text(
                                wrongGuess,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Container(
                      //   height: 30,
                      //   width: 60,
                      //   decoration: BoxDecoration(
                      //     color: Theme.of(context).colorScheme.background,
                      //     borderRadius: BorderRadius.circular(5),
                      //     // border: Border.all(color: Colors.grey.shade300),
                      //   ),
                      //   child: FittedBox(
                      //     fit: BoxFit.scaleDown,
                      //     child: Row(
                      //       children: [
                      //         // SvgPicture.asset(
                      //         //   'assets/svg/Coins.svg',
                      //         //   // color: Colors.white,
                      //         // ),
                      //         Icon(
                      //           Icons.military_tech,
                      //           size: 15,
                      //         ),
                      //         SizedBox(width: 5),
                      //         Text(
                      //           points,
                      //           style: Theme.of(context)
                      //               .textTheme
                      //               .bodyMedium!
                      //               .copyWith(
                      //                 // color: Colors.white,
                      //                 fontWeight: FontWeight.normal,
                      //               ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Quizs: ',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      // Text(
                      //   correctGuess,
                      //   style: Theme.of(context).textTheme.bodySmall,
                      // ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      RatingBarIndicator(
                        rating: rating,
                        itemPadding: EdgeInsets.symmetric(horizontal: 1),
                        unratedColor: Colors.white,
                        itemCount: 10,
                        itemSize: 18.0,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, _) => Icon(
                          Icons.star_rounded,
                          color: Colors.amber,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
