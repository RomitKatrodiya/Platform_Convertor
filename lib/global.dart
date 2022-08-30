import 'package:flutter/material.dart';

class Global {
  static var appColor = const Color(0xff54759E);

  static bool isIos = false;
  static var elevatedButtonStyle = ElevatedButton.styleFrom(
    textStyle: const TextStyle(fontSize: 18),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  );
  static var elevatedButtonStyle2 = ElevatedButton.styleFrom(
    textStyle: const TextStyle(fontSize: 13),
  );
  static var outLineButtonStyle = OutlinedButton.styleFrom(
    textStyle: const TextStyle(fontSize: 13),
  );

  static DateTime currantDate = DateTime.now();
  static String? selectedDate;
  static String? month;

  static TimeOfDay time = TimeOfDay.now();

  static String? currantTime;
  static String? selectedTime;

  static List<Map> allContacts = [
    {
      "id": 1,
      "name": "Steve Rogers",
      "description": "Captain America",
      "time": "10:04 PM",
      "number": "2153121546",
      "image":
          "https://img.mensxp.com/media/content/2020/May/Actors-Who-Also-Auditioned-For-Captain-America1200_5ec3bb1be7b82.jpeg",
    },
    {
      "id": 2,
      "name": "Natasha Romanoff",
      "description": "Black Widow",
      "time": "11:00 PM",
      "number": "2198247362",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS_lyEP3Cb-1uhxMOUGeUWeZhIZUCKPQ_eZGA&usqp=CAU"
    },
    {
      "id": 3,
      "name": "Bruce Banner",
      "description": "Hulk",
      "time": "12:00 PM",
      "number": "2198565981",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR4l9HSIz6bWGVmoprsPYJlaaMj3qsu6d-MVA&usqp=CAU",
    },
    {
      "id": 4,
      "name": "Tony Stark",
      "description": "Iron Man",
      "time": "01:00 AM",
      "number": "8798532214",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTcqnRnHqdkUTq0kgdJzAIJHAeE0flhwJJCxw&usqp=CAU",
    },
    {
      "id": 5,
      "name": "Peter Parker",
      "description": "Spider-Man",
      "time": "04:00 AM",
      "number": "9551284625",
      "image":
          "https://images.unsplash.com/photo-1635805737707-575885ab0820?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80",
    },
    {
      "id": 6,
      "name": "Steven Strange",
      "description": "Doctor Strange",
      "time": "06:00 AM",
      "number": "6837524210",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSbm5aLHJ1dEHnPudXnaxEZcNDEUm5VPz1rKg&usqp=CAU",
    },
    {
      "id": 7,
      "name": "Hank Pym",
      "description": "Ant-Man",
      "time": "yesterday",
      "number": "0120305957",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcToSli9DrwcfOBOh64s_uV2FEv2kw8ViMkSQA&usqp=CAU",
    },
    {
      "id": 8,
      "name": "Thor Odinson",
      "description": "Thor ",
      "time": "yesterday",
      "number": "8762034290",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0IzZSjz700HTrAm9KH7IxHPmxZTmxxA8TLA&usqp=CAU",
    },
    {
      "id": 9,
      "name": "T’Challa",
      "description": "Black Panther",
      "time": "yesterday",
      "number": "0180409876",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS7vSpIct28LMMWPBpqCsizs9Wlu4m6kyDz5w&usqp=CAU",
    },
  ];
}
