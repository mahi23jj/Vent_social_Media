import 'dart:html';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class MyImage extends StatelessWidget {
  final String imageUrl;
   MyImage(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    //String imageUrl = "https://firebasestorage.googleapis.com/v0/b/login-4471f.appspot.com/o/images%2F2024-03-17%2015%3A40%3A36.312.png?alt=media&token=135c193d-7575-41f3-ad26-661efa480d28";
    // https://github.com/flutter/flutter/issues/41563
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      imageUrl,
      (int _) => ImageElement()..src = imageUrl,
    );
    return HtmlElementView(
      viewType: imageUrl,
    );
  }
}