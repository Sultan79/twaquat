import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirebaseDynamicLinkService {
  static Future<String> createDynamicLink(String groubID) async {
    final dynamicLinkParams = DynamicLinkParameters(
      uriPrefix: "https://twaquat.page.link",
      link: Uri.parse("https://twaquat.page.link/groub?id=$groubID"),
      androidParameters:
          const AndroidParameters(packageName: "sandaqa.tech.twaquat"),
      iosParameters: const IOSParameters(
        bundleId: "sandaqa.tech.twaquat",
        appStoreId: "6443883588",
      ),
    );
    final dynamicLink =
        await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);

    Uri url;
    url = dynamicLink.shortUrl;
    print(url.toString());
    return url.toString();
  }

  static Future<String> createDynamicCompanyLink(
      String groubID, String sectionID) async {
    final dynamicLinkParams = DynamicLinkParameters(
      uriPrefix: "https://twaquat.page.link",
      link: Uri.parse(
          "https://twaquat.page.link/groub?id=$groubID&section=$sectionID"),
      androidParameters:
          const AndroidParameters(packageName: "sandaqa.tech.twaquat"),
      iosParameters: const IOSParameters(
        bundleId: "sandaqa.tech.twaquat",
        appStoreId: "6443883588",
      ),
    );
    final dynamicLink =
        await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);

    Uri url;
    url = dynamicLink.shortUrl;
    print(url.toString());
    return url.toString();
  }

  static Future<String> createDynamicShareLink() async {
    final dynamicLinkParams = DynamicLinkParameters(
      uriPrefix: "https://twaquat.page.link",
      link: Uri.parse("https://twaquat.page.link/"),
      androidParameters:
          const AndroidParameters(packageName: "sandaqa.tech.twaquat"),
      iosParameters: const IOSParameters(
        bundleId: "sandaqa.tech.twaquat",
        appStoreId: "6443883588",
      ),
    );
    final dynamicLink =
        await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);

    Uri url;
    url = dynamicLink.shortUrl;
    print(url.toString());
    return url.toString();
  }

  static Future<void> initDynamicLink(BuildContext context) async {
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) async {
      final Uri deepLink = dynamicLinkData.link;

      print(deepLink.fragment);
      print(deepLink.data);

      String userId = FirebaseAuth.instance.currentUser!.uid;
      var groupDoc = await FirebaseFirestore.instance
          .collection('group')
          .doc(deepLink.queryParameters['id'])
          .get();

      if (deepLink.queryParameters['id'] == null) {
        return;
      }

      if (deepLink.queryParameters['section'] == null) {
        List groupUsers = groupDoc.data()!['users'];
        print(groupUsers);
        if (groupUsers.contains(userId)) {
          return;
        }
        groupUsers.add(userId);
        FirebaseFirestore.instance
            .collection('group')
            .doc(deepLink.queryParameters['id'])
            .update({'users': groupUsers});
      } else {
        List groupUsers = groupDoc.data()!['users'];
        Map groupUserss = groupDoc.data()!['userss'];

        if (groupUsers.contains(userId)) {
          return;
        }
        groupUsers.add(userId);
        groupUserss[userId] = deepLink.queryParameters['section'];

        FirebaseFirestore.instance
            .collection('group')
            .doc(deepLink.queryParameters['id'])
            .update({
          'users': groupUsers,
          'userss': groupUserss,
        });
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text("you successfully join the group".tr()),
        ),
      );
    }).onError((error) {
      // Handle errors
      print(error);
    });
  }
}
