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
    this.image,
    this.firestTeam = 'USA',
    this.seacondTeam = 'USA',
    this.thirdTeam = 'USA',
    this.rating = 3.5,
  }) : super(key: key);

  final String name;
  final String points;
  final String correctGuess;
  final String? image;
  final String firestTeam;
  final String seacondTeam;
  final String thirdTeam;
  final double rating;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
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
                RatingBarIndicator(
                  rating: rating,
                  unratedColor: Colors.white,
                  itemCount: 5,
                  itemSize: 15.0,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, _) => Icon(
                    Icons.star_rounded,
                    color: Colors.amber,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
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
                ),
                Divider(
                  color: Colors.grey.shade300,
                  thickness: 1,
                  endIndent: 10,
                  indent: 10,
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'the level:',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Image.asset(
                          "assets/images/Group54421-5.png",
                          scale: 7,
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Correct Guess: ',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          correctGuess,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Selected teams:',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleAvatar(
                            radius: 10,
                            backgroundImage:
                                AssetImage("assets/flags/${firestTeam}.png"),
                          ),
                          CircleAvatar(
                            radius: 10,
                            backgroundImage:
                                AssetImage("assets/flags/${seacondTeam}.png"),
                          ),
                          CircleAvatar(
                            radius: 10,
                            backgroundImage:
                                AssetImage("assets/flags/${thirdTeam}.png"),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
