import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VotingButton extends StatelessWidget {
  const VotingButton({Key? key, this.upArraw = false, this.ontapFunction})
      : super(key: key);

  final bool upArraw;
  final Function()? ontapFunction;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Material(
        color: Theme.of(context).colorScheme.background,
        child: InkWell(
          onTap: ontapFunction,
          child: Container(
            height: 35,
            width: 35,
            padding: EdgeInsets.all(7),
            decoration: BoxDecoration(
              // color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: SvgPicture.asset(
              upArraw ? 'assets/svg/Down.svg' : 'assets/svg/Up.svg',
            ),
          ),
        ),
      ),
    );
  }
}
