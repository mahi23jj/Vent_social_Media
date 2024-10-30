import 'dart:async';

import 'package:flutter/material.dart';

class AppData {
  AppData._();

  static final List<String> outerStyleImages = [
    'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/new-arrival-discount-offer-on-shoes-poster-ad-design-template-20e8be063593e460ec1eadf156df2a71_screen.jpg?ts=1607504280',
    'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/shoes-craze-sale-facebook-ad-design-template-b1d1738fd5e9e0f6e3152ec502a1c2e1_screen.jpg?ts=1567579016',
    'https://codecanyon.img.customer.envatousercontent.com/files/352931146/Preview.jpg?auto=compress%2Cformat&q=80&fit=crop&crop=top&max-h=8000&max-w=590&s=29e647d179d8704189dced38088fac34',
    'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/shoes-craze-sale-facebook-ad-design-template-b1d1738fd5e9e0f6e3152ec502a1c2e1_screen.jpg?ts=1567579016',
    'https://codecanyon.img.customer.envatousercontent.com/files/352468295/Preview.jpg?auto=compress%2Cformat&q=80&fit=crop&crop=top&max-h=8000&max-w=590&s=cea2b1e7878f5ef6b903f9b3625460fe',
    'https://rstatic.shoecarnival.com/domain/5265_508_20231225_Winter_Season_Store_Locator_Banner2_(1).jpg',
    // 'https://graphicsfamily.com/wp-content/uploads/2020/07/Shoes-Advertising-Banner-Design-Template-scaled.jpg',
  ];
}

class ImageSlider extends StatefulWidget {
  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  final List<String> images = [
    
    'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/shoes-craze-sale-facebook-ad-design-template-b1d1738fd5e9e0f6e3152ec502a1c2e1_screen.jpg?ts=1567579016',
    'https://th.bing.com/th/id/OIP.hESosf8DcwIiRrfx-f14vAHaHa?rs=1&pid=ImgDetMain'
    
    //'https://i.pinimg.com/736x/6d/b1/e1/6db1e1071f41d2d858947bfff7157a1d--product-advertising-nike-air-max-s.jpg'
    'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/new-arrival-discount-offer-on-shoes-poster-ad-design-template-20e8be063593e460ec1eadf156df2a71_screen.jpg?ts=1607504280',
    'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/shoes-craze-sale-facebook-ad-design-template-b1d1738fd5e9e0f6e3152ec502a1c2e1_screen.jpg?ts=1567579016',
     'https://th.bing.com/th/id/OIP.hESosf8DcwIiRrfx-f14vAHaHa?rs=1&pid=ImgDetMain'
  ];
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < images.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        controller: _pageController,
        itemCount: images.length,
        onPageChanged: (int page) {
          setState(() {
            _currentPage = page;
          });
        },
        itemBuilder: (context, index) {
          return Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
              height: 120, // Set your desired fixed height here
              child: Image.network(
                images[index],
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      
    );
  }
}

