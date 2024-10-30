import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login/profiles/profile.dart';


//import 'package:flutter/material.dart';


PickImage(ImageSource source) async {
   final ImagePicker _imagePicker = ImagePicker();
   XFile? _file = await _imagePicker.pickImage(source: source);
  if(_file != null){
    return await _file.readAsBytes();
  }
  print('no image selected');
}
class Editpage extends StatefulWidget {
  @override
  _StoreDataState createState() => _StoreDataState();
}

class _StoreDataState extends State<Editpage> {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
   String userId = FirebaseAuth.instance.currentUser!.uid;
   late String _profileImageUrl;
 

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore.instance.collection('cap').doc(userId).get();
    if (userDoc.exists) {
      setState(() {
        _profileImageUrl = userDoc.data()?['profile_image_url'] ?? '';
      });
    }
  }


  Future<String> uploadImageToStorage(String childName, Uint8List file) async {
    Reference ref = _storage.ref().child(childName);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> saveData({
    required String name,
    Uint8List? file,
  }) async {
    String resp = "Some error occurred";
    try {
      if (file != null && name.isNotEmpty) {
        String imageUrl = await uploadImageToStorage('profileimage', file);
        String userId = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection('cap').doc(userId).update({
        'profile_image_url': imageUrl,
      });
      setState(() {
        _profileImageUrl = imageUrl;
      });
        await _firestore.collection('kidu').doc(userId).set({
          'name': name,
          'ImageLink': imageUrl,
        }, SetOptions(merge: true));
        resp = 'Success';
      } else {
        throw 'Name or image cannot be empty';
      }
       
    } catch (error) {
      resp = error.toString();
    }
    return resp;
  }

  Future<String> getProfilePictureUrl() async {
    try {
      // Get the current user's ID from Firebase Authentication
      String userId = FirebaseAuth.instance.currentUser!.uid;
      // Retrieve user data from Firestore using the user's ID
      DocumentSnapshot snapshot =
          await _firestore.collection('kidu').doc(userId).get();
      if (snapshot.exists) {
        Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;
        if (userData.containsKey('ImageLink')) {
          return userData['ImageLink'];
        } else {
          throw 'ImageLink not found';
        }
      } else {
        throw 'User data not found';
      }
    } catch (error) {
      throw error.toString();
    }
  }

  Future<void> uploadImage(Uint8List uint8list) async {
    try {
      // Get the current user's ID from Firebase Authentication
      String userId = FirebaseAuth.instance.currentUser!.uid;
      Reference ref = FirebaseStorage.instance.ref().child('profile_images').child(userId);
      UploadTask uploadTask = ref.putData(uint8list);
      TaskSnapshot snapshot = await uploadTask.whenComplete(() {});
      String imageUrl = await snapshot.ref.getDownloadURL();
      // Save user data in Firestore using the user's ID as the document ID
      await _firestore.collection('kidu').doc(userId).set({
        'ImageLink': imageUrl,
      }, SetOptions(merge: true));
    } catch (error) {
      throw error.toString();
    }
  }
Uint8List? _image;
   final TextEditingController nameController = TextEditingController();
   final TextEditingController bioController =TextEditingController();
   
    // String? get userId => null;
     
 
  void SelectedImage() async {
      Uint8List img = await PickImage(ImageSource.gallery);
      setState(() {
        _image = img;
      });
  
  }
  void saveProfile() async{   //String userId
    String name = nameController.text;
    // ignore: unused_local_variable
   String resp = await saveData(name:name, file: _image!);
  }
    String email = 'eshthjoin3@gmail.com';
  bool _isTapped = false;
  String description = '';
  String _selectedUniversity = 'AASTU';
  List<String> _ethiopianUniversities = [
    'AASTU',
    'Addis Ababa University',
    'Jimma University',
    'Hawassa University',
    // Add more Ethiopian universities here
  ];

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
                  });
                  Navigator.pop(context);
                },
              );
            },
          ),
        );
      },
    );
  }
  Widget myWidget() {
  return FractionallySizedBox(
    widthFactor: 0.7,
    heightFactor: 0.3,
    child: Container(
      color: Colors.green,
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold( appBar: 
      AppBar(
        title: Text('Profile'),
        elevation: 0, // Remove app bar elevation
        backgroundColor: Color.fromARGB(255, 110, 186, 220), 
        leading: IconButton(onPressed: (){
          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfilePage(postText: '',userna: 'ether jhon',)),
                            );
        }, 
        icon: Icon(Icons.arrow_back_ios_new_sharp)),// Make app bar transparent
      ),
       // Extend background behind app bar
      body: SingleChildScrollView(
        child: Container(
          color:Color.fromARGB(255, 110, 186, 220),
          padding: EdgeInsets.all(30.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Easther Jon',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: _showUniversityList,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                      color: Colors.white,
                      width: 2.0,
                    ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _selectedUniversity,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color:Color.fromARGB(255, 110, 186, 220,),
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Icon(
                            Icons.arrow_drop_down,
                            color: Color.fromARGB(255, 110, 186, 220,),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            
          TextFormField(initialValue: email,
                onChanged: (newValue) {
                  setState(() {
                    email = newValue;
                  
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    
                  ),
                ),
                style: TextStyle(
                  fontSize: 20.0,
                  color: Color.fromARGB(255, 110, 186, 220,),
                ),
              ),
           
            SizedBox(height: 16.0),
              Container(
                child: Stack(
                  children: [
                     
                        _image != null ?
                        CircleAvatar(
                            radius: 64,
                            backgroundImage:MemoryImage(_image!),
                        )
                        :
                       const  CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                              'https://th.bing.com/th/id/OIP.mpXg7tyCFEecqgUsoW9eQwHaHk?w=184&h=187&c=7&r=0&o=5&dpr=1.5&pid=1.7'),
                        ),
                        Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 50.0,
                        height: 50.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child:IconButton(
                            onPressed: SelectedImage, 
                            icon: const Icon(Icons.add),
                          ),
                      ),
                    ),
                  ],
                ),
              ),
             SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: (){
              saveProfile();
              Navigator.pop(context);
            }
            
            
            ,
               child:const  Text('save')),
              
            SizedBox(
              height: 20,
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: 16.0), // Adjust the spacing as needed
              child: GestureDetector(
                onTapDown: (TapDownDetails details) {
                  setState(() {
                    _isTapped = true;
                  });
                },
                onTapCancel: () {
                  setState(() {
                    _isTapped = false;
                  });
                },
                child: Container(

                  width: double.infinity,
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(
                      color: _isTapped
                          ? Color.fromARGB(255, 31, 88, 121)
                          : Color.fromARGB(255, 234, 237, 235),
                      width: 4.0,
                    ),
                  ),
                
                    child: Column(
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
                        TextFormField(
                           controller: nameController ,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              
            SizedBox(height: 20.0),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                 /* Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfilePage(postText: '')),
                  );*/
                },
              ),
              IconButton(
                icon: Icon(Icons.add_box),
                onPressed: () {}
                 // Navigator.push(
                 //   context,
                 //   MaterialPageRoute(builder: (context) => PostPage()),
            )]
                
              ),
              IconButton(
                icon: Icon(Icons.person),
                onPressed: () {
                  // Navigate to profile page
                 /* Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(postText: '')),
                  );*/
                },
              ),
              IconButton(
                  icon: Icon(Icons.list),
                  onPressed: () {
                    /*Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductPage()),
                            );*/
                  }),
             ] ),
          ),
      ));
  }
}