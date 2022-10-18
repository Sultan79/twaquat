import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class OnboardingContents {
  final String title;
  final String image;
  final String desc;

  OnboardingContents(
      {required this.title, required this.image, required this.desc});
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: "Register".tr(),
    image: "assets/images/White skin hands with a phone.png",
    desc:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse at ultricies felis. Duis vitae magna.".tr(),
  ),
  OnboardingContents(
    title: "Challenge".tr(),
    image: "assets/images/1F94A_BoxingGlove_MOD_01_01 1.png",
    desc:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse at ultricies felis. Duis vitae magna.".tr(),
  ),
  OnboardingContents(
    title: "Win".tr(),
    image: "assets/images/Group 54421.png",
    desc:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse at ultricies felis. Duis vitae magna.".tr(),
  ),
];
