// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CustomFiledText extends StatelessWidget {
  const CustomFiledText({
    Key? key,
    required this.controller,
    required this.title,
    required this.hintText,
  }) : super(key: key);

  final TextEditingController controller;
  final String title;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          SizedBox(
            height: 13,
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Colors.grey.shade300,
              ),
            ),
            width: 350,
            height: 60,
            child: TextField(
              controller: controller,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: Theme.of(context).textTheme.labelLarge,
                fillColor: Colors.red,
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
