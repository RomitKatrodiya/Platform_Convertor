import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../global.dart';

class CallsPage extends StatefulWidget {
  const CallsPage({Key? key}) : super(key: key);

  @override
  State<CallsPage> createState() => _CallsPageState();
}

class _CallsPageState extends State<CallsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView.builder(
        itemCount: Global.allContacts.length,
        itemBuilder: (context, i) {
          return (Global.isIos)
              ? Container(
                  height: 70,
                  padding: const EdgeInsets.symmetric(horizontal: 17),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: Global.appColor,
                        backgroundImage: (i < 9)
                            ? NetworkImage("${Global.allContacts[i]["image"]}")
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
                            "${Global.allContacts[i]["time"]}",
                            style: const TextStyle(
                              fontSize: 13,
                              color: CupertinoColors.systemGrey,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () async {
                          Uri url = Uri.parse(
                              "tel:+91${Global.allContacts[i]["number"]}");
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url);
                          }
                        },
                        child: const Icon(
                          CupertinoIcons.phone_fill,
                          color: CupertinoColors.activeGreen,
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                )
              : ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Global.appColor,
                    backgroundImage: (i < 9)
                        ? NetworkImage("${Global.allContacts[i]["image"]}")
                        : FileImage(File("${Global.allContacts[i]["image"]}"))
                            as ImageProvider,
                  ),
                  title: Text("${Global.allContacts[i]["name"]}"),
                  subtitle: Text("${Global.allContacts[i]["time"]}"),
                  trailing: IconButton(
                    onPressed: () async {
                      Uri url = Uri.parse(
                          "tel:+91${Global.allContacts[i]["number"]}");
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Can't call..."),
                            backgroundColor: Colors.red,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                    },
                    icon: const Icon(
                      Icons.phone,
                      color: Colors.green,
                    ),
                  ),
                );
        },
      ),
    );
  }
}
