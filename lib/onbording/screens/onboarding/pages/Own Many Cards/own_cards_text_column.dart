import 'package:flutter/material.dart';

import '../../widgets/text_column.dart';

class OwnCardText extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const OwnCardText();

  @override
  Widget build(BuildContext context) {
    return const TextColumn(
      title: 'Expert Support',
      text:
          'Our product offers a connection with volunteers dedicated to addressing a myriad of mental health concerns.',
    );
  }
}
