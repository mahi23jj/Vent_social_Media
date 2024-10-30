import 'package:flutter/material.dart';
class ReusableDayCard extends StatelessWidget {
  final days;
  final dateNumber;
  void Function()? onTap;
  Color? cardColor;
  ReusableDayCard(
      {required this.days,
      required this.dateNumber,
      required this.onTap,
      required this.cardColor});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 90,
        width: 66,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Color(0xFF50A9E2),
            width: 1.5,
          ),
          color: cardColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              days,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            Text(
              dateNumber,
              style: TextStyle(
                fontSize: 18,
              ),
            )
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}