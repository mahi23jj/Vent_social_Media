import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login/bottom.dart';
import 'package:login/psycho/first.dart';

import 'components/resuable_Textfiled.dart';
import 'components/reusable_Daycard.dart';
import 'components/reusable_Timecard.dart';
import 'constants.dart';


class elemsd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BookingPage(),
    );
  }
}

String? month;
Set<String> selectedDays = {};
String? selectedCategory; 
class BookingPage extends StatefulWidget {
  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  String? activeTime;
  List<String> daysOfWeek = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'];
 List<String> times = [
    '09:00am',
    '10:00am',
    '12:00pm',
    '01:00pm',
    '03:00pm',
    '04:00pm',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(128, 128, 128, 0.1)),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                      ),
                      iconSize: 30,
                    ),
                  ),
                ),
                Text(
                  'Booking',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  width: 70,
                ),
              ],
            ),
            SizedBox(height: 20),
            ReusableTextField(
              name: 'User name',
              hint: 'User name',
            ),
            SizedBox(height: 20),
            ReusableTextField(
              name: 'Category',
              hint: selectedCategory ?? 'Select category',
              categories: categories,
              onCategorySelected: (String selectedItem) {
                setState(() {
                  selectedCategory = selectedItem;
                });
              },
            ),
            SizedBox(height: 20),
            ReusableTextField(
              name: 'Description',
              hint:
                  'Psychology is the study of the mind and behavior. It explores how people think, feel, and act, and seeks to understand both normal and abnormal behavior.',
              lineNumber: 5,
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  'Choose time',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                color: Color(0xFF8F92A1),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      'Date',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child: Row(
                    children: [
                      Text(
                        month ?? 'Select Month',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      PopupMenuButton(
                        icon: Icon(Icons.keyboard_arrow_down),
                        itemBuilder: (BuildContext context) {
                          return months.map((String item) {
                            return PopupMenuItem(
                              value: item,
                              child: Text(item),
                            );
                          }).toList();
                        },
                        onSelected: (String selectedItem) {
                          setState(() {
                            month = selectedItem;
                            _updateDaysOfWeek(selectedItem);
                            selectedDays.clear();
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 23),
                child: Row(
                  children: _buildDayCards(),
                ),
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          'Time',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Row(children: [
                        Text(
                          activeTime ?? 'Select Time',
                          style: TextStyle(fontSize: 20),
                        ),
                        PopupMenuButton(
                          icon: Icon(Icons.keyboard_arrow_down),
                          itemBuilder: (BuildContext context) {
                            return times.map((String item) {
                              return PopupMenuItem(
                                value: item,
                                child: Text(item),
                              );
                            }).toList();
                          },
                          onSelected: (String selectedItem) {
                            setState(() {
                              activeTime = selectedItem;
                            });
                          },
                        )
                      ])
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            ReusableTimeCard(
              text: activeTime ?? 'Time',
              isSelected: activeTime != null,
            ),
            SizedBox(height: 50),
            Container(
              height: 55,
              width: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Color(0xFF50A9E2),
              ),
              child: TextButton(
                onPressed: () {
                  _showSuccessDialog(context);
                },
                child: Text(
                  'Book Now',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  int? selectedDayIndex;

  List<Widget> _buildDayCards() {
    if (month == null) {
      return ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
          .asMap()
          .entries
          .map((entry) {
        final index = entry.key;
        final day = entry.value;
        return Container(
          margin: EdgeInsets.only(right: 10),
          child: ReusableDayCard(
            days: day,
            dateNumber: '18',
            cardColor: selectedDayIndex == index
                ? activeDateCardColor
                : inactiveCardColor,
            onTap: () {
              setState(() {
                selectedDayIndex = index;
              });
            },
          ),
        );
      }).toList();
    }

    var now = DateTime.now();
    var selectedMonth = months.indexOf(month!) + 1;
    var daysInMonth = DateTime(now.year, selectedMonth + 1, 0).day;

    return List.generate(daysInMonth, (index) {
      var date = DateTime(now.year, selectedMonth, index + 1);
      var dayOfWeek = DateFormat('E').format(date);
      var isSelected = selectedDayIndex == index;

      return Container(
        margin: EdgeInsets.only(right: 15),
        child: ReusableDayCard(
          days: dayOfWeek,
          dateNumber: (index + 1).toString(),
          cardColor: isSelected ? activeDateCardColor : inactiveCardColor,
          onTap: () {
            setState(() {
              selectedDayIndex = index;
            });
          },
        ),
      );
    });
  }

  void _updateDaysOfWeek(String selectedMonth) {
    var now = DateTime.now();
    var monthIndex = months.indexOf(selectedMonth) + 1;
    var daysInMonth = DateTime(now.year, monthIndex + 1, 0).day;
    var firstDayOfMonth = DateTime(now.year, monthIndex, 1).weekday;

    daysOfWeek = [];
    for (var i = 1; i <= daysInMonth; i++) {
      var dayOfWeekIndex = (firstDayOfMonth + i - 2) % 7;
      daysOfWeek.add(DateFormat('E').format(DateTime(now.year, monthIndex, i)));
    }
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                  alignment: Alignment.center,
                  child: Text(
                      "Your booking has been successfully completed!\n The Psychiatrist will reach you out soon!")),
              SizedBox(height: 16.0),
              Row(
                children: [],
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Explores()),
                );
              },
            ),
          ],
        );
      },
    );
  }
}