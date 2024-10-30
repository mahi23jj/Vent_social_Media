import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:login/new.dart';
import 'package:login/psycho/Psychologist_page.dart';
import 'package:login/psycho/constants.dart';

class Explores extends StatefulWidget {
  const Explores({Key? key}) : super(key: key);

  @override
  _PsychologyExploreState createState() => _PsychologyExploreState();
}

class _PsychologyExploreState extends State<Explores> {
 // int _selectedIndex = 0;
  Stream<QuerySnapshot>? _userStream;
  TextEditingController  searchResults = TextEditingController();
 
 


@override
  void initState() {
    super.initState();
    _userStream = FirebaseFirestore.instance.collection('mental').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  'Psychologist',
                  style: largeTextStyle,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  'Meet your freedom',
                  style: smallTextStyle,
                ),
              ),
            
              SizedBox(height: 20),
           StreamBuilder<QuerySnapshot<Object?>>(
                stream: _userStream,
                builder: (context, snapshot) {
    if (snapshot.hasError) {
      return Text('Something went wrong');
    }

    if (snapshot.connectionState == ConnectionState.waiting) {
      return Container(height: 0,width: 0,);
    }

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 700),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        padding: EdgeInsets.all(10),
        children: snapshot.data!.docs.map((ds) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return PsychologistPage(
                  elems: ds['title'],
                  abouts: ds['about'],
                  emails: ds['email'],
                  images: ds['image'],
                );
              }));
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Stack(
                children: [
                  Container(
                    height: 80,
                    width: double.infinity,
                    decoration: const BoxDecoration(
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
                      child:  ClipOval( child:Container(
          height:90 ,
          width: 90,
          child: MyImage(ds['image'])))
                    ),
                  ),
                  Positioned(
                    top: 125,
                    left: 70,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          ds['title'],
                          style: mediumTextStyle,
                        ),
                        const Text(
                          'Psychiatrist',
                          style: smallTextStyle,
                        ),
                       
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  },
)

            ],
          ),
        ),
      ),
    );
  }
}

