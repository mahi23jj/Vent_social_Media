import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login/module/provide.dart';
import 'package:login/pages/images.dart';



class PostPage extends StatefulWidget {
  String users;
  //required this.users
  PostPage({super.key,required this.users});

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  bool isPrivate = true;
  TextEditingController post = TextEditingController();

    
   
  List<String> _selectedItems = [];
    List<Item> items = [
  Item(id: '1', name: 'Acadamic'),
  Item(id: '2', name: 'Relationship'),
  Item(id: '3', name: 'Psychological'),
  Item(id: '4', name: 'Addiction'),
  Item(id: '5', name: 'Frashman'),
  // Add more items as needed
];
      bool x=true;
      String downloadUrl ='';
  Uint8List? _imageBytes; 

 




Future<void> addUser(bool anonymes,String ident ,) async {
  String downloadUrl = '';

  try {
    if (_imageBytes != null) {
      final storageRef = FirebaseStorage.instance.ref().child('images/${DateTime.now()}.png');
      final uploadTask = storageRef.putData(_imageBytes!);

      final TaskSnapshot taskSnapshot = await uploadTask;
      downloadUrl = await taskSnapshot.ref.getDownloadURL();
    }
    String userId = FirebaseAuth.instance.currentUser!.uid;
    //DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore.instance.collection('cap').doc(userId).get();
   // String profileImageUrl = userDoc.data()?['profile_image_url'] ?? '';
    await FirebaseFirestore.instance.collection('Hackthon').add({
      'id':userId,
      'image': downloadUrl,
      'name': post.text.trim(),
      'likesCount': 0,
      'isposted': anonymes,
      'user': ident,
      'created_at': Timestamp.now(),
      'type':_selectedItems,
      //'images': profileImageUrl,
      'likes':[]
    });

    print("User added successfully!");
    ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text('User added successfully!'),
    duration: Duration(seconds: 3),
  ),
);
  } catch (e) {
    print("Error adding user: $e");
    
  }
}




  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      final imageBytes = await pickedImage.readAsBytes();
      setState(() {
        _imageBytes = Uint8List.fromList(imageBytes);
      });
    }
  }

void privacy (){
  setState(() {
    x = !x;
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
  
        title: Text('Write Post',style: GoogleFonts.roboto(),),
      ),
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                // Remove focus from text field when tapped outside
                FocusScope.of(context).unfocus();
              },
              child: Container(
                margin: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: post,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Write your post here...',
                              contentPadding: EdgeInsets.all(16.0),
                            ),
                          ),
                        ),
                         GestureDetector(
                          onTap: () {
                            // Handle image attachment logic
                             pickImage();
                            print('Image attachment clicked');
                          },
                          child: Container(
                            margin: EdgeInsets.all(8.0),
                            height: 100.0,
                            color: Colors.grey.withOpacity(0.3),
                            alignment: Alignment.center,
                            child: Text(
                              'Insert the image here',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ), 
                      ],
                    ),

                    Positioned(
                      bottom: 8.0,
                      right: 8.0,
                      child: GestureDetector(
                        onTap: () {
                          pickImage();
                        },
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Icon(Icons.attach_file),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                   privacy();
                },
                child: 
                x?Container(
                  margin: EdgeInsets.only(left: 8.0, bottom: 16.0),
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: isPrivate ? Colors.grey : Colors.blue,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.public, size: 16.0),
                      SizedBox(width: 4.0),
                      Text(
                        'Public',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ):Container(
                  margin: EdgeInsets.only(left: 16.0, bottom: 16.0),
                  padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: isPrivate ? Colors.red : Colors.grey,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.lock, size: 16.0),
                      SizedBox(width: 4.0),
                      Text(
                        'Private',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                )
              ),
              Spacer(),
               Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
  width: 300,
  height: 65,
  child: Center(
    child: DropdownButtonFormField<String>(
      value: _selectedItems.isNotEmpty ? _selectedItems[0] : null,
      decoration: const InputDecoration(
        labelText: 'catagory',
        border: OutlineInputBorder(),
      ),
      hint: Text('Select items'),
      onChanged: (value) {
        setState(() {
          if (_selectedItems.contains(value)) {
            _selectedItems.remove(value);
          } else {
            _selectedItems.add(value!);
          }
        });
      },
      items: items
          .map((item) => DropdownMenuItem<String>(
                value: item.id,
                child: Text(item.name),
              ))
          .toList(),
    ),
  ),
),
            ],
          ),



          
          GestureDetector(
            onTap: () {
              // widget.users
             addUser(x,widget.users );
            },
            child: Container(
              margin: EdgeInsets.all(43.0),
              padding: EdgeInsets.symmetric(horizontal: 150.0, vertical: 8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(56.0),
                color: Colors.blue,
              ),
              child: const Text(
                'Post',
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
