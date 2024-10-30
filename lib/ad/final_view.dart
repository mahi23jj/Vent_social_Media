// import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:login/ad/data.dart';
import 'package:login/ad/image_viewer.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';



class FinalView extends StatefulWidget {
  const FinalView({Key? key}) : super(key: key);

  @override
  State<FinalView> createState() => _FinalViewState();
}

class _FinalViewState extends State<FinalView>
    with SingleTickerProviderStateMixin {
  MotionTabBarController? _motionTabBarController;
    // late CarouselController outerCarouselController;
    PageController outerPageController = PageController();
  int outerCurrentPage = 0;

  @override
  void initState() {
    super.initState();
    _motionTabBarController = MotionTabBarController(
      initialIndex: 1,
      length: 4,
      vsync: this,
    );
  }

  @override
  void dispose() {
       outerPageController.dispose();
    _motionTabBarController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return Scaffold(
      body: _outerBannerSlider(),
    );
  }

  Widget _outerBannerSlider() {
    return Column(
      children: [
       Expanded(
        child: PageView.builder(
          controller: outerPageController,
          onPageChanged: (index) {
            setState(() {
              outerCurrentPage = index;
            });
          },
          itemCount: AppData.outerStyleImages.length,
          itemBuilder: (context, index) {
            return CustomImageViewer.show(
              context: context,
              url: AppData.outerStyleImages[index],
              fit: BoxFit.fill,
              radius: 0,
            );
          },
        ),
      ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            AppData.outerStyleImages.length,
            (index) {
              bool isSelected = outerCurrentPage == index;
              return GestureDetector(
                onTap: () {
                  outerPageController.animateToPage(
                  index,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
                },
                child: AnimatedContainer(
                  width: isSelected ? 30 : 10,
                  height: 10,
                  margin: EdgeInsets.symmetric(horizontal: isSelected ? 6 : 3),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.deepPurpleAccent
                        : Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
