import 'package:flutter/material.dart';
import 'package:login/psycho/constants.dart';


import 'reusable_icons.dart';

class ReusablePsychatrist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          height: 220,
          child: Stack(
            children: [
              Container(
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  color: Colors.blue,
                ),
              ),
              Container(
                height: 100,
                width: 100,
                color: Colors.transparent,
              ),
              Transform.translate(
                offset: Offset(0, 50),
                child: Align(
                  alignment: Alignment(0, -1.3),
                  child: CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage('Images/psychologist.png'),
                  ),
                ),
              ),
              Positioned(
                top: 125,
                left: 30,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Refella Mendes',
                      style: mediumTextStyle,
                    ),
                    Text(
                      'Psychiatrist',
                      style: smallTextStyle,
                    ),
                    ReusableStar(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
