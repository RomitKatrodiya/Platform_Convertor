// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platform_convertor/global.dart';
import 'package:platform_convertor/screens/calls_page.dart';
import 'package:platform_convertor/screens/chats_page.dart';
import 'package:platform_convertor/screens/my_drawer.dart';
import 'package:platform_convertor/screens/settings_page.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late TabController tabController;

  List data = [
    const ChatsPage(),
    const CallsPage(),
    const SettingsPage(),
  ];

  int initialStep = 0;
  final GlobalKey<FormState> addContact = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String? selectedImagePath;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    if ((Global.isIos == false)) {
      return MaterialApp(
        navigatorKey: NavigationService.navigatorKey,
        theme: ThemeData.light().copyWith(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: buildMaterialColor(const Color(0xff54759E)),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: homePage(),
      );
    } else {
      return CupertinoApp(
        theme: CupertinoThemeData(
          primaryColor: Global.appColor,
        ),
        debugShowCheckedModeBanner: false,
        home: cupertinoHomePage(),
      );
    }
  }

  homePage() {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        backgroundColor: Global.appColor,
        title: const Text("Platform Convertor"),
        bottom: TabBar(
          controller: tabController,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: "CHATS"),
            Tab(text: "CALLS"),
            Tab(text: "SETTINGS"),
          ],
        ),
        actions: [
          Switch(
            value: Global.isIos,
            onChanged: (val) {
              setState(() {
                Global.isIos = val;
              });
            },
            inactiveThumbImage: const NetworkImage(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSDIiXr7agjs8Pj9ujn2i6--jDsl-kCoCQwHw&usqp=CAU"),
          ),
        ],
      ),
      body: TabBarView(
        controller: tabController,
        children: const [
          ChatsPage(),
          CallsPage(),
          SettingsPage(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Global.appColor,
        onPressed: () {
          initialStep = 0;
          if (tabController.index == 0) {
            dialogBox(NavigationService.navigatorKey.currentContext);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  cupertinoHomePage() {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: Builder(builder: (context) {
          return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CupertinoDrawer()),
                );
              },
              child: const Icon(CupertinoIcons.list_bullet));
        }),
        middle: const Text("Platform Convertor"),
        trailing: CupertinoSwitch(
          value: Global.isIos,
          onChanged: (val) {
            setState(() {
              Global.isIos = val;
            });
          },
        ),
      ),
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          currentIndex: tabController.index,
          onTap: (val) {
            tabController.index = val;
          },
          items: const [
            BottomNavigationBarItem(
              activeIcon: Icon(CupertinoIcons.chat_bubble_2_fill),
              icon: Icon(CupertinoIcons.chat_bubble_2),
              label: "Chats",
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.phone),
              activeIcon: Icon(CupertinoIcons.phone_fill),
              label: "Calls",
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.settings),
              activeIcon: Icon(CupertinoIcons.settings_solid),
              label: "Settings",
            ),
          ],
        ),
        tabBuilder: (context, index) {
          return CupertinoTabView(
            builder: (context) {
              return data[index];
            },
          );
        },
      ),
    );
  }

  dialogBox(context) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
            child: Form(
              autovalidateMode: AutovalidateMode.always,
              key: addContact,
              child: Stepper(
                currentStep: initialStep,
                controlsBuilder: (context, _) {
                  return Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (initialStep < 2) {
                            initialStep++;
                            Navigator.of(context).pop();
                            dialogBox(context);
                          } else {
                            TimeOfDay res = TimeOfDay.now();
                            String? time;
                            if (addContact.currentState!.validate()) {
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
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    "/", (route) => false);
                                initialStep = 0;
                              });
                              setState(() {});

                              nameController.clear();
                              descriptionController.clear();
                              selectedImagePath = null;
                            }
                          }
                        },
                        style: Global.elevatedButtonStyle2,
                        child: (initialStep == 2)
                            ? const Text("ADD")
                            : const Text("CONTINUE"),
                      ),
                      const Spacer(),
                      OutlinedButton(
                        onPressed: () {
                          if (initialStep > 0) {
                            initialStep--;
                            Navigator.of(context).pop();
                            dialogBox(context);
                          } else {
                            Navigator.of(context).pop();
                          }
                        },
                        style: Global.outLineButtonStyle,
                        child: const Text("CANCEL"),
                      )
                    ],
                  );
                },
                steps: [
                  Step(
                    title: const Text("PROFILE PHOTO"),
                    subtitle: const Text("Add Profile Photo"),
                    content: Stack(
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
                          onPressed: () async {
                            await showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    scrollable: true,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(25)),
                                    ),
                                    title: Text(
                                      "When You go to pick Image ?",
                                      style: TextStyle(
                                        color: Global.appColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () async {
                                          Navigator.of(context).pop();
                                          XFile? pickerFile =
                                              await _picker.pickImage(
                                                  source: ImageSource.gallery);

                                          if (pickerFile != null) {
                                            setState(() {
                                              selectedImagePath =
                                                  pickerFile.path;
                                            });
                                          }
                                        },
                                        style: Global.elevatedButtonStyle2,
                                        child: const Text("gallery"),
                                      ),
                                      ElevatedButton(
                                        onPressed: () async {
                                          Navigator.of(context).pop();
                                          XFile? pickerFile =
                                              await _picker.pickImage(
                                                  source: ImageSource.camera);
                                          setState(() {
                                            selectedImagePath =
                                                pickerFile!.path;
                                          });
                                        },
                                        style: Global.elevatedButtonStyle2,
                                        child: const Text("Camera"),
                                      ),
                                    ],
                                  );
                                });
                            if (selectedImagePath != null) {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (context) => const MyApp(),
                                  ),
                                  (route) => false);
                              dialogBox(context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Global.appColor,
                            shape: const CircleBorder(),
                          ),
                          child: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ),
                  Step(
                    title: const Text("Name"),
                    subtitle: const Text("Enter Name"),
                    content: TextFormField(
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter Name...";
                        }
                        return null;
                      },
                      controller: nameController,
                      decoration: const InputDecoration(
                        hintText: "Please Enter Name",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Step(
                    title: const Text("DESCRIPTION"),
                    subtitle: const Text("Enter description"),
                    content: TextFormField(
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter Description...";
                        }
                        return null;
                      },
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        hintText: "Please Enter Description",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

MaterialColor buildMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
