import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GiftWidget extends StatelessWidget {
  GiftWidget({
    Key? key,
    this.imageNumber = 0,
  }) : super(key: key);
  final int imageNumber;
  final List<String> giftsImagePath = [
    "1F94A_BoxingGlove_MOD_01_01 1.png",
    "blue medical gloves.png",
    "coffee spilling out of mug.png",
    "cupcake with cherry.png",
    "easter egg.png",
    "front view of black eyeglasses.png",
    "front view of red scooter.png",
    "image 27.png",
    "snow globe with house and trees.png",
    "soccer ball.png",
    "tool box.png",
    "t-shirt mockup.png",
    "White skin hands with a phone.png",
    "white sneakers.png",
    "Wrapped gift.png",
  ];
  final List<int> giftsPrices = [
    26,
    25,
    21,
    22,
    25,
    24,
    22,
    22,
    21,
    21,
    20,
    21,
    21,
    22,
    29,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Material(
          color: Colors.white,
          child: InkWell(
            onTap: () {
              print(giftsPrices[imageNumber]);
            },
            child: Container(
              height: 220,
              width: 160,
              decoration: BoxDecoration(
                // color: Colors.white,

                color: Colors.transparent,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 135,
                    width: 130,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: Colors.grey.shade400),
                    ),
                    child: Image.asset(
                      'assets/images/${giftsImagePath[imageNumber]}',
                      // fit: BoxFit.scaleDown,
                      cacheHeight: 80,
                    ),
                  ),
                  Text(
                    'money',
                    style: Theme.of(context).textTheme.bodyMedium,
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
                          Text('${giftsPrices[imageNumber]}'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
