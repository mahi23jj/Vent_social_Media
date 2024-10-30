import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:login/pages/sample.dart';





class explore extends StatelessWidget {
  String uid;
  String users;
   explore({Key? key,required this.users,required this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData.dark().copyWith(
      //   scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      // ),
      home: Scaffold(
        body: Body(uid: uid,),
      ),
    );
  }
}

class Body extends StatefulWidget {
  String uid;
   Body({super.key,required this.uid});

  
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int _selectedTabIndex = 0;
  PageController _pageController = PageController(initialPage: 0);
  
 void _onTabTapped(int index) {
   if (index >= 0 && _selectedTabIndex != index) {
    setState(() {
      _selectedTabIndex = index;
      //_pageController.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.ease);
      _pageController.jumpToPage(index);
    });
   }
  }
  

  

  @override
  Widget build(BuildContext context) {
 double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: 
             SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 360,
                    color: Colors.white,
                    padding: const EdgeInsets.fromLTRB(15, 24, 15, 8),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Explore',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Your Freedom our concern',
                          style: TextStyle(
                            color: Color(0xFF767680),
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 47,
                    width: double.infinity,
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          buildTabButton(0, 'Academic'),
                          const SizedBox(width: 24),
                          buildTabButton(1, 'Relationship'),
                          const SizedBox(width: 24),
                          buildTabButton(2, 'Psychological'),
                          const SizedBox(width: 24),
                          buildTabButton(3, 'Addiction'),
                          const SizedBox(width: 24),
                          buildTabButton(4, 'Frash man'),
                        ],
                      ),
                    ),
                  ),
                 Container(
                height: height*0.85,
                   child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      _onTabTapped(index);
                    },
                    children: [
                     AcademicPage(typeId: '1',),
                     AcademicPage(typeId: '2'),
                        AcademicPage(typeId: '3'),
                       AcademicPage(typeId: '4'),
                        AcademicPage(typeId: '5')
                     
                    ],
                             ),
                 ),
                 
                ],
              ),
            ),
          
     
    );
  }

  Widget buildTabButton(int index, String text) {
    return GestureDetector(
      onTap: () => _onTabTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: TextStyle(
              color: _selectedTabIndex == index
                  ? const Color(0xFF06164B)
                  : const Color(0xFF5A5D72),
              fontSize: 16,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
              height: 1.2,
              letterSpacing: 0.15,
            ),
          ),
          if (_selectedTabIndex == index)
            Container(
              width: 16,
              height: 3,
              decoration: BoxDecoration(
                color: const Color(0xFF3398DB),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
        ],
      ),
    );
  }
}


 
