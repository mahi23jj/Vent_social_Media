import 'package:flutter/material.dart';

class ReusableTimeCard extends StatelessWidget {
  final String text;
  final bool isSelected;

  ReusableTimeCard({required this.text, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 66,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color:Color(0xFF50A9E2),
        ),
        color: isSelected ?  Color(0xFFC2E6FB) : Colors.white,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}