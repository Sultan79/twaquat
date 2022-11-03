import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:twaquat/services/firebase_dynamic_link.dart';

class GroupWidget extends StatelessWidget {
  const GroupWidget(
      {super.key,
      required this.id,
      this.GroupName = "Groub Name",
      this.GroupDescription = "Groub Description ",
      this.url = 'https://shortest.link/5x7p',
      this.NumberOfMembers = '200',
      this.isPublic = false,
      this.isCompany = false,
      required this.onClick});

  final String id;
  final String GroupName;
  final String GroupDescription;
  final String url;
  final String NumberOfMembers;
  final bool isPublic;
  final bool isCompany;
  final Function() onClick;
  @override
  Widget build(BuildContext context) {
    // print(DateTime.now().compareTo(other));
    return Column(
      children: [
        InkWell(
          onTap: onClick,
          child: Container(
            height: 100,
            width: 350,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    height: 90,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      image: DecorationImage(
                        image: NetworkImage(url),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            GroupName,
                          ),
                          !isCompany
                              ? SizedBox(
                                  height: 20,
                                  width: 25,
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.transparent),
                                          foregroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.grey),
                                          overlayColor:
                                              MaterialStateProperty.all(
                                                  Colors.grey.shade300),
                                          padding: MaterialStateProperty.all(
                                              EdgeInsets.zero)),
                                      onPressed: () async {
                                        String url =
                                            await FirebaseDynamicLinkService
                                                .createDynamicLink(id);
                                        await Clipboard.setData(
                                            ClipboardData(text: url));
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            backgroundColor: Colors.green,
                                            content: Text(
                                                "you have copyed the link"),
                                          ),
                                        );
                                      },
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Icon(
                                          Icons.share,
                                          size: 15,
                                        ),
                                      )),
                                )
                              : SizedBox(),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 210,
                            child: Text(
                              GroupDescription,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.normal),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  NumberOfMembers,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontWeight: FontWeight.normal,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                ),
                                Text(
                                  " " + " members".tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          !isCompany
                              ? isPublic
                                  ? Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary, //Colors.redAccent,
                                        borderRadius: BorderRadius.circular(5),
                                        border: isPublic
                                            ? Border.all(
                                                color: Colors.grey.shade300,
                                              )
                                            : null,
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Public".tr(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.white,
                                                ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: Colors
                                            .redAccent, //Colors.redAccent,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Private".tr(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.white,
                                                ),
                                          ),
                                        ],
                                      ),
                                    )
                              : Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color:
                                        Colors.blueAccent, //Colors.redAccent,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Company".tr(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              fontWeight: FontWeight.normal,
                                              color: Colors.white,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
