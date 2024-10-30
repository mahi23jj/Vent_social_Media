import 'package:flutter/material.dart';

class ReusableStar extends StatelessWidget {
  const ReusableStar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.star,
          color: Color(0xFFFFAB00),
        ),
        Icon(
          Icons.star,
          color: Color(0xFFFFAB00),
        ),
        Icon(
          Icons.star,
          color: Color(0xFFFFAB00),
        ),
        Icon(
          Icons.star,
          color: Color(0xFFFFAB00),
        ),
        Icon(
          Icons.star,
          color: Color(0xFFFFAB00),
        ),
      ],
    );
  }
}
