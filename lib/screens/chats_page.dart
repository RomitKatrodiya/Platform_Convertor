import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_convertor/global.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({Key? key}) : super(key: key);

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView.builder(
        itemCount: Global.allContacts.length,
        itemBuilder: (context, i) {
          return (Global.isIos)
              ? GestureDetector(
                  onTap: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (context) => CupertinoActionSheet(
                        actions: [
                          Container(
                            padding: const EdgeInsets.all(30),
                            child: Column(
                              children: [
                                bottomSheetAction(i),
                              ],
                            ),
                          ),
                          CupertinoActionSheetAction(
                            onPressed: () async {
                              Uri url = Uri.parse(
                                  "sms:+91${Global.allContacts[i]["number"]}");
                              if (await canLaunchUrl(url)) {
                                await launchUrl(url);
                              }
                            },
                            child: const Text("Send Message"),
                          ),
                        ],
                        cancelButton: CupertinoActionSheetAction(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          isDestructiveAction: true,
                          child: const Text("Cancel"),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    color: CupertinoColors.white,
                    height: 70,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 17),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Global.appColor,
                          backgroundImage: (i < 9)
                              ? NetworkImage(
                                  "${Global.allContacts[i]["image"]}")
                              : FileImage(
                                      File("${Global.allContacts[i]["image"]}"))
                                  as ImageProvider,
                        ),
                        const SizedBox(width: 17),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${Global.allContacts[i]["name"]}",
                              style: const TextStyle(
                                fontSize: 17,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "${Global.allContacts[i]["description"]}",
                              style: const TextStyle(
                                fontSize: 13,
                                color: CupertinoColors.systemGrey,
                              ),
                            )
                          ],
                        ),
                        const Spacer(),
                        Text(
                          "${Global.allContacts[i]["time"]}",
                          style: const TextStyle(
                            fontSize: 13,
                            color: CupertinoColors.systemGrey,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : ListTile(
                  onTap: () {
                    showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30),
                        ),
                      ),
                      context: context,
                      builder: (context) => Container(
                        padding: const EdgeInsets.all(30),
                        child: Column(
                          children: [
                            bottomSheetAction(i),
                            const Spacer(),
                            SizedBox(
                              height: 50,
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () async {
                                  Uri url = Uri.parse(
                                      "sms:+91${Global.allContacts[i]["number"]}");
                                  if (await canLaunchUrl(url)) {
                                    await launchUrl(url);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Can't Message..."),
                                        backgroundColor: Colors.red,
                                        behavior: SnackBarBehavior.floating,
                                      ),
                                    );
                                  }
                                },
                                style: Global.elevatedButtonStyle,
                                child: const Text("Send Message"),
                              ),
                            ),
                            const Spacer(),
                            SizedBox(
                              height: 50,
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                style: Global.elevatedButtonStyle,
                                child: const Text("Cancel"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  leading: CircleAvatar(
                    backgroundColor: Global.appColor,
                    backgroundImage: (i < 9)
                        ? NetworkImage("${Global.allContacts[i]["image"]}")
                        : FileImage(File("${Global.allContacts[i]["image"]}"))
                            as ImageProvider,
                  ),
                  title: Text("${Global.allContacts[i]["name"]}"),
                  subtitle: Text("${Global.allContacts[i]["description"]}"),
                  trailing: Text("${Global.allContacts[i]["time"]}"),
                );
        },
      ),
    );
  }

  bottomSheetAction(i) {
    return SizedBox(
      height: 190,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Global.appColor,
            radius: 60,
            backgroundImage: (i < 9)
                ? NetworkImage("${Global.allContacts[i]["image"]}")
                : FileImage(File("${Global.allContacts[i]["image"]}"))
                    as ImageProvider,
          ),
          const Spacer(),
          Text(
            "${Global.allContacts[i]["name"]}",
            style: TextStyle(
              fontSize: 22,
              color: Global.appColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            "+91 ${Global.allContacts[i]["number"]}",
            style: TextStyle(
              fontSize: 18,
              color: Global.appColor.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}
