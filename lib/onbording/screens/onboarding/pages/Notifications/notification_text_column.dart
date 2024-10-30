// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

import '../../widgets/text_column.dart';

class NotificationText extends StatelessWidget {
  const NotificationText();

  @override
  Widget build(BuildContext context) {
    return const TextColumn(
      title: 'Privacy Concerned',
      text:
          'Share your concerns with us without the fear of identity exposure; we safeguard your anonymity.',
    );
  }
}
