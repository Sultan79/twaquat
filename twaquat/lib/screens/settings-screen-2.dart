import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});
  static String routeName = '/settings';
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Setting".tr(),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Wrap(
          children: [
            ListTile(
                leading: Icon(Icons.language_rounded),
                title: Text("Change Language".tr()),
                subtitle: Text('From English to Arabic'.tr()),
                onTap: () {
                  context.locale.toString() == "en"
                      ? context.setLocale(Locale('ar'))
                      : context.setLocale(Locale('en'));
                })
          ],
        ),
      )),
    );
  }
}
