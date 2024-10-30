import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login/new.dart';
import 'package:login/pages/images.dart';
import 'package:login/profiles/add_profile.dart';

class ProfilePage extends StatefulWidget {
  final String postText;
  final String userna; 
 

  ProfilePage({required this.postText,required this.userna,});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isTapped = false;
  String _selectedUniversity = 'AASTU';
  List<String> _ethiopianUniversities = [
    'AASTU',
    'Addis Ababa University',
    'Jimma University',
    'Hawassa University',
    // Add more Ethiopian universities here
  ];

  bool _isFavorite1 = false;
  bool _isFavorite2 = false;
  bool _isFavorite3 = false;
  bool _isFavorite4 = false;
  bool _isFavorite5 = false;

  void _toggleFavorite1() {
    setState(() {
      _isFavorite1 = !_isFavorite1;
    });
  }

  void _toggleFavorite2() {
    setState(() {
      _isFavorite2 = !_isFavorite2;
    });
  }

  void _toggleFavorite3() {
    setState(() {
      _isFavorite3 = !_isFavorite3;
    });
  }

  void _toggleFavorite4() {
    setState(() {
      _isFavorite4 = !_isFavorite4;
    });
  }

  void _toggleFavorite5() {
    setState(() {
      _isFavorite5 = !_isFavorite5;
    });
  }

  void _showUniversityList() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: ListView.builder(
            itemCount: _ethiopianUniversities.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(_ethiopianUniversities[index]),
                onTap: () {
                  setState(() {
                    _selectedUniversity = _ethiopianUniversities[index];
                    Navigator.pop(context);
                  });
                },
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('cap')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Scaffold(
          body: SingleChildScrollView(
            child: Container(
               color:Color.fromARGB(255, 110, 186, 220),
              padding: EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                       widget.userna,
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(234, 236, 238, 1),
                        ),
                      ),
                      GestureDetector(
                        onTap: _showUniversityList,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.school,
                                color: Colors.blue,
                              ),
                              SizedBox(width: 10.0),
                              Text(
                                _selectedUniversity,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(width: 10.0),
                              Icon(
                                Icons.arrow_drop_down,
                                color: Colors.blue,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    padding: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Text(
                      FirebaseAuth.instance.currentUser!.email ?? '',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Stack(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                             backgroundColor: Colors.black,
                            radius: 75,
                            //backgroundColor: Colors.blue,
                           // backgroundImage: NetworkImage('https://th.bing.com/th/id/R.4f97c711c776fe73a13729021a967311?rik=b4gzYwwaZ5RTww&pid=ImgRaw&r=0'),
                            // You can adjust the radius and other properties as needed
                          ),
                          IconButton.filled(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Editpage(),));
                          }, icon: Icon(Icons.edit))
                        ],
                      ),
                    
                          
                ]),
                     
                    
                  
                  SizedBox(height: 10.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Container(
                          
                          color: Color.fromARGB(137, 241, 241, 241),
                          child: Text(''),
                        )
                      ],
                  )
                  // Existing code...
                
              ]),
            ),
          ),
        );
        }

        var data = snapshot.data!.data() as Map<String, dynamic>;
        return Scaffold(
          appBar: AppBar(
            title: Text('Profile'),
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Container(
               color:Color.fromARGB(255, 110, 186, 220),
              padding: EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                       data['username'],
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(234, 236, 238, 1),
                        ),
                      ),
                      GestureDetector(
                        onTap: _showUniversityList,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.school,
                                color: Colors.blue,
                              ),
                              SizedBox(width: 10.0),
                              Text(
                                _selectedUniversity,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(width: 10.0),
                              Icon(
                                Icons.arrow_drop_down,
                                color: Colors.blue,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    padding: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Text(
                      FirebaseAuth.instance.currentUser!.email ?? '',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Stack(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            child: MyImage(data['profile_image_url']),
                            radius: 75,
                            backgroundColor: Colors.blue,
                            // You can adjust the radius and other properties as needed
                          ),
                          IconButton.filled(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Editpage(),));
                          }, icon: Icon(Icons.edit))
                        ],
                      ),
                    
                          
                ]),
                     
                    
                  
                  SizedBox(height: 10.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Container(
                          
                          color: Color.fromARGB(137, 241, 241, 241),
                          child: Text('my world'),
                        )
                      ],
                  )
                  // Existing code...
                
              ]),
            ),
          ),
        );
      },
    );
  }
}

