import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platform_convertor/global.dart';
import 'package:platform_convertor/main.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  var drawerItemStyle = const TextStyle(fontSize: 15);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: expanded1(),
          ),
          Expanded(
            flex: 5,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  ListTile(
                    onTap: () {},
                    leading: const Icon(Icons.people_alt_outlined),
                    title: Text(
                      "New Group",
                      style: drawerItemStyle,
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: const Icon(Icons.person_outline),
                    title: Text(
                      "New Contact",
                      style: drawerItemStyle,
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: const Icon(Icons.bookmark_border),
                    title: Text(
                      "Save Massages",
                      style: drawerItemStyle,
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: const Icon(Icons.settings),
                    title: Text(
                      "Settings",
                      style: drawerItemStyle,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

expanded1() {
  return Container(
    width: double.infinity,
    color: Global.appColor,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        CircleAvatar(
          radius: 45,
          backgroundColor: Colors.white30,
          backgroundImage: NetworkImage(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRPJX9du0pNznjg7_cM2FZle1CbL0mYrmraTg&usqp=CAU"),
        ),
        SizedBox(height: 10),
        Text(
          "  John Doe",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        SizedBox(height: 2),
        Text(
          "  +91 21548 79865",
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
      ],
    ),
  );
}

class CupertinoDrawer extends StatefulWidget {
  const CupertinoDrawer({Key? key}) : super(key: key);

  @override
  State<CupertinoDrawer> createState() => _CupertinoDrawerState();
}

class _CupertinoDrawerState extends State<CupertinoDrawer> {
  final GlobalKey<FormState> addContact = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String? selectedImagePath;

  var dialogTextStyle = TextStyle(
    color: Global.appColor,
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  var cupertinoTextFieldDecoRation = BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    border: Border.all(),
  );

  bool isImageNull = false;

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            color: CupertinoColors.white,
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: expanded1(),
                ),
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      customListTile(CupertinoIcons.person_2, "New Group"),
                      GestureDetector(
                        onTap: () {
                          cupertinoDialogBox(context);
                        },
                        child: customListTile(
                            CupertinoIcons.person, "New Contact"),
                      ),
                      customListTile(CupertinoIcons.bookmark, "Save Message"),
                      customListTile(CupertinoIcons.settings, "Settings"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              color: CupertinoColors.white.withOpacity(0.1),
            ),
          ),
        ),
      ],
    );
  }

  cupertinoDialogBox(context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(
          'Add Contact Details',
          style: TextStyle(
            color: Global.appColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Form(
            key: addContact,
            child: Column(
              children: [
                const SizedBox(height: 15),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 70,
                      backgroundImage: (selectedImagePath != null)
                          ? FileImage(File(selectedImagePath!))
                          : null,
                      backgroundColor: Global.appColor.withOpacity(0.3),
                      child: (selectedImagePath != null)
                          ? const Text("")
                          : Text(
                              textAlign: TextAlign.center,
                              "ADD",
                              style: TextStyle(
                                fontSize: 20,
                                color: Global.appColor,
                              ),
                            ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        showCupertinoModalPopup(
                            context: context,
                            builder: (context) {
                              return CupertinoAlertDialog(
                                title: Text(
                                  "When You go to pick Image ?",
                                  style: TextStyle(
                                    color: Global.appColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                actions: [
                                  CupertinoButton(
                                    onPressed: () async {
                                      Navigator.of(context).pop();
                                      XFile? pickerFile =
                                          await _picker.pickImage(
                                              source: ImageSource.gallery);
                                      setState(() {
                                        isImageNull = false;
                                        selectedImagePath = pickerFile!.path;
                                      });
                                    },
                                    child: const Text("gallery"),
                                  ),
                                  CupertinoButton(
                                    onPressed: () async {
                                      Navigator.of(context).pop();
                                      XFile? pickerFile =
                                          await _picker.pickImage(
                                              source: ImageSource.camera);
                                      setState(() {
                                        isImageNull = false;
                                        selectedImagePath = pickerFile!.path;
                                      });
                                    },
                                    child: const Text("Camera"),
                                  ),
                                ],
                              );
                            });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Global.appColor,
                        shape: const CircleBorder(),
                      ),
                      child: const Icon(CupertinoIcons.add),
                    ),
                  ],
                ),
                (isImageNull)
                    ? const Text(
                        "ADD Image First",
                        style: TextStyle(
                          color: CupertinoColors.systemRed,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : Container(),
                const SizedBox(height: 25),
                Text("Name", style: dialogTextStyle),
                const SizedBox(height: 5),
                CupertinoTextFormFieldRow(
                  placeholder: "Enter Name",
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  controller: nameController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Enter Name...";
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: cupertinoTextFieldDecoRation,
                ),
                const SizedBox(height: 15),
                Text("Description", style: dialogTextStyle),
                const SizedBox(height: 5),
                CupertinoTextFormFieldRow(
                  placeholder: "Enter Description",
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  controller: descriptionController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Enter Description...";
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: cupertinoTextFieldDecoRation,
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              if (selectedImagePath != null) {
                if (addContact.currentState!.validate()) {
                  TimeOfDay res = TimeOfDay.now();
                  String? time;
                  time =
                      "${(res.hour == 00) ? 12 : (res.hour >= 12) ? res.hour - 12 : res.hour}:${(res.minute <= 9) ? "0${res.minute}" : res.minute} ${res.period.name}";
                  Map m = {
                    "name": nameController.text,
                    "description": descriptionController.text,
                    "time": time,
                    "image": selectedImagePath,
                    "number": "2154652312"
                  };

                  setState(() {
                    Global.allContacts.add(m);
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const MyApp(),
                    ));
                    setState(() {});
                  });

                  selectedImagePath = null;
                  nameController.clear();
                  descriptionController.clear();
                }
              } else {
                if (isImageNull == false) {
                  setState(() {
                    isImageNull = true;
                  });
                  Navigator.of(context).pop();
                  cupertinoDialogBox(context);
                }
              }
            },
            child: const Text("Add Contact"),
          )
        ],
      ),
    );
  }

  customListTile(icon, text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 55,
      width: double.infinity,
      child: Row(
        children: [
          Icon(icon, color: CupertinoColors.black.withOpacity(0.7)),
          const SizedBox(width: 20),
          Text(
            text,
            style: TextStyle(
              color: CupertinoColors.black.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}
