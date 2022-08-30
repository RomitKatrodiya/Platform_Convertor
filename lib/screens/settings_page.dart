import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../global.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var textStyle = TextStyle(
    fontSize: 20,
    color: Global.appColor,
    fontWeight: FontWeight.w600,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Global.selectedDate == null) {
      Global.month = Global.currantDate.month.toString();
      String monthInWord = findMonth();
      Global.selectedDate =
          "${Global.currantDate.day}, $monthInWord ${Global.currantDate.year}";
    }

    if (Global.selectedTime == null) {
      Global.currantTime =
          "${(Global.time.hour == 00) ? 12 : (Global.time.hour >= 12) ? Global.time.hour - 12 : Global.time.hour}:${(Global.time.minute <= 9) ? "0${Global.time.minute}" : Global.time.minute}  ${Global.time.period.name}";
    }
  }

  MaterialColor myGreen = const MaterialColor(0xff54759E, {
    50: Color(0xff54759E),
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: (Global.isIos)
          ? const EdgeInsets.only(right: 20, left: 20, top: 100)
          : const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            children: [
              Text("Date", style: textStyle),
              const Spacer(),
              Text(Global.selectedDate.toString(), style: textStyle),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 55,
            width: double.infinity,
            child: (Global.isIos)
                ? CupertinoButton.filled(
                    onPressed: () {
                      DateTime? res;

                      showCupertinoModalPopup(
                        context: context,
                        builder: (context) => CupertinoActionSheet(
                          actions: [
                            SizedBox(
                              height: 250,
                              child: CupertinoDatePicker(
                                initialDateTime: Global.currantDate,
                                minimumDate: DateTime(2000),
                                maximumDate: DateTime(2050),
                                mode: CupertinoDatePickerMode.date,
                                onDateTimeChanged: (DateTime dateTime) {
                                  res = dateTime;
                                  setState(() {
                                    Global.currantDate = res!;

                                    Global.month = res?.month.toString();
                                    String monthInWord = findMonth();
                                    Global.selectedDate =
                                        "${res?.day}, $monthInWord ${res?.year}";
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    child: const Text("Change Date"),
                  )
                : ElevatedButton(
                    onPressed: () async {
                      DateTime? res = await showDatePicker(
                        context: context,
                        initialDate: Global.currantDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2050),
                      );

                      setState(() {
                        Global.currantDate = res!;
                        Global.month = res.month.toString();
                        String monthInWord = findMonth();
                        Global.selectedDate =
                            "${res.day}, $monthInWord ${res.year}";
                      });
                    },
                    style: Global.elevatedButtonStyle,
                    child: const Text("Change Date"),
                  ),
          ),
          const SizedBox(height: 40),
          Row(
            children: [
              Text("Time", style: textStyle),
              const Spacer(),
              Text(
                  (Global.selectedTime != null)
                      ? Global.selectedTime.toString()
                      : Global.currantTime.toString(),
                  style: textStyle),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 55,
            width: double.infinity,
            child: (Global.isIos)
                ? CupertinoButton.filled(
                    onPressed: () {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (context) => CupertinoActionSheet(
                          actions: [
                            SizedBox(
                              height: 250,
                              child: CupertinoDatePicker(
                                initialDateTime: Global.currantDate,
                                mode: CupertinoDatePickerMode.time,
                                onDateTimeChanged: (DateTime dateTime) {
                                  setState(() {
                                    Global.selectedTime =
                                        "${(dateTime.hour == 00) ? 12 : (dateTime.hour >= 12) ? (dateTime.hour == 12) ? 12 : dateTime.hour - 12 : dateTime.hour}:${(dateTime.minute <= 9) ? "0${dateTime.minute}" : dateTime.minute}  ${(dateTime.hour >= 12) ? "pm" : "am"}";
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    child: const Text("Change Time"),
                  )
                : ElevatedButton(
                    onPressed: () async {
                      TimeOfDay? res = await showTimePicker(
                        context: context,
                        initialTime: Global.time,
                      );

                      if (res != null) {
                        setState(() {
                          Global.time = res;
                          Global.selectedTime =
                              "${(res.hour == 00) ? 12 : (res.hour >= 12) ? (res.hour == 12) ? 12 : res.hour - 12 : res.hour}:${(res.minute <= 9) ? "0${res.minute}" : res.minute} ${res.period.name}";
                        });
                      }
                    },
                    style: Global.elevatedButtonStyle,
                    child: const Text("Change Time"),
                  ),
          ),
        ],
      ),
    );
  }

  String findMonth() {
    String monthInWords = "";

    if (Global.month == "1") {
      monthInWords = "Jan";
    } else if (Global.month == "2") {
      monthInWords = "Feb";
    } else if (Global.month == "3") {
      monthInWords = "Mar";
    } else if (Global.month == "4") {
      monthInWords = "Apr";
    } else if (Global.month == "5") {
      monthInWords = "May";
    } else if (Global.month == "6") {
      monthInWords = "Jun";
    } else if (Global.month == "7") {
      monthInWords = "Jul";
    } else if (Global.month == "8") {
      monthInWords = "Aug";
    } else if (Global.month == "9") {
      monthInWords = "Sep";
    } else if (Global.month == "10") {
      monthInWords = "Oct";
    } else if (Global.month == "11") {
      monthInWords = "Nov";
    } else if (Global.month == "12") {
      monthInWords = "Dec";
    }
    return monthInWords;
  }
}
