import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({ super.key });
   static String routeName = '/settings';
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'.tr()),
        backgroundColor: Color.fromARGB(255, 40, 49, 96),
      ),
    );
  }
}