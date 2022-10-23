import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twaquat/services/dropDown_flags.dart';

class FlagsDropDown extends StatefulWidget {
  const FlagsDropDown(
      {super.key,
      required this.hint,
      required this.title,
      this.width = 350,
      required this.data});

  final String hint;
  final String title;
  final double width;
  final data;
  @override
  State<FlagsDropDown> createState() => _FlagsDropDownState();
}

class _FlagsDropDownState extends State<FlagsDropDown> {
  String? dropdownValue;
  @override
  Widget build(BuildContext context) {
    String title = widget.title;
    String hint = widget.hint;
    var list = <String>[
      'USA',
      'Argentina',
      'Australia',
      'Beligum',
      'Brazil',
      'Cameroon',
      'Canada',
      'Costa Rica',
      'Croatia',
      'Denmark',
      'Ecuador',
      'England',
      'France',
      'Germany',
      'Ghana',
      'Iran',
      'Japan',
      'Mexico',
      'Morocco',
      'Netherlands',
      'Poland',
      'Portugal',
      'Qatar',
      'Saudi Arabia',
      'Senegal',
      'Serbia',
      'South Korea',
      'Spain',
      'Switzerland',
      'Tunisia',
      'Uruguay',
      'Wales',
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        SizedBox(
          height: 13,
        ),
        SizedBox(
          height: 60,
          width: widget.width,
          child: DecoratedBox(
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    width: 1.0,
                    style: BorderStyle.solid,
                    color: Colors.grey.shade300),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 10.0,
              ),
              child: DropdownButton<String>(
                value: dropdownValue,
                isExpanded: true,
                icon: Icon(Icons.keyboard_arrow_down),
                elevation: 16,
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue;
                    if (widget.data == 1) {
                      context.read<DropDownFlags>().flag1 = dropdownValue!;
                    } else if (widget.data == 2) {
                      context.read<DropDownFlags>().flag2 = dropdownValue!;
                    } else {
                      context.read<DropDownFlags>().flag3 = dropdownValue!;
                    }
                  });
                },
                hint: Text(
                  hint,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                underline: SizedBox(),
                items: list.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Container(
                        padding: EdgeInsets.all(5),
                        child: Image.asset("assets/flags/$value.png")),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
