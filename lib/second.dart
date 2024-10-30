import 'package:flutter/material.dart';
import 'package:login/Explor/item.dart';
import 'package:login/pages/sample.dart';



class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Flutter Custom TabBar',
            style: TextStyle(fontSize: 16),
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(60)),
              child: Container(
                height: 30,
              //  width: 100,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                child: const TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  indicator: BoxDecoration(
                    color: Color.fromARGB(255, 73, 177, 237),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black54,
                  tabs: [
                    TabItem(title: 'Academic', count: 6),
                    TabItem(title: 'Relationship', count: 3),
                    TabItem(title: 'Psychological', count: 1),
                    TabItem(title: 'Addiction', count: 1),
                    TabItem(title: 'Frash man', count: 1),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: const TabBarView(
          children: [
                AcademicPage(typeId: '1',),
                     AcademicPage(typeId: '2'),
                        AcademicPage(typeId: '3'),
                       AcademicPage(typeId: '4'),
                        AcademicPage(typeId: '5')
                     
          ],
        ),
      ),
    );
  }
}