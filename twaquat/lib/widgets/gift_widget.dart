import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GiftWidget extends StatelessWidget {
  const GiftWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      width: 160,
      decoration: BoxDecoration(
        color: Colors.white,
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
            child: Image.asset('assets/images/image 27.png'),
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
                  Text('2500'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
