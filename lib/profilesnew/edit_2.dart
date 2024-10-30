import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login/new.dart';



import 'clipper.dart';



class ProfileEdit extends StatefulWidget {
  String bio;
  String name;
  
 //required this.user
   ProfileEdit({Key? key,required this.bio,required this.name}) : super(key: key);
 @override
  State<ProfileEdit> createState() => _EditProfileState();
}


class _EditProfileState extends State<ProfileEdit> {
  
  @override
  Widget build(BuildContext context) {
    return 
     Scaffold(
        body: ListView(
          children: [
            Profiles(bio: widget.bio,name:widget.name ,)
            
          ],
        ),
      );
    
  }
}







class Profiles extends StatefulWidget {
  String bio;
  String name;
  
   Profiles({Key? key,required this.bio,required this.name}) : super(key: key);
 @override
  // ignore: library_private_types_in_public_api
 State<Profiles> createState() => ProfileState();
}

class ProfileState extends State<Profiles> {
  final bioController = TextEditingController();
   final currentUser = FirebaseAuth.instance.currentUser;
  bool isChecked = false;

  String profileImageUrl = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRz8cLf8-P2P8GZ0-KiQ-OXpZQ4bebpa3K3Dw&usqp=CAU';

  Future<void> updateUserProfile() async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUser!.uid)
          .update({
        'bio': bioController.text,
        'profileImageUrl': profileImageUrl
      }, );

    } catch (e) {
      debugPrint(e.toString());
    }
  }

 
Uint8List? _imageBytes; 

 Future<void> pickAndUploadImage() async {
  final picker = ImagePicker();
  final pickedImage = await picker.pickImage(source: ImageSource.gallery);

  if (pickedImage != null) {
    final imageBytes = await pickedImage.readAsBytes();
    setState(() {
      _imageBytes = Uint8List.fromList(imageBytes);
    });

    String downloadUrl = '';

    try {
      if (_imageBytes != null) {
        final storageRef = FirebaseStorage.instance.ref().child('images/${DateTime.now()}.png');
        final uploadTask = storageRef.putData(_imageBytes!);

        final TaskSnapshot taskSnapshot = await uploadTask;
        downloadUrl = await taskSnapshot.ref.getDownloadURL();
      }

      setState(() {
        profileImageUrl = downloadUrl;
      });

      print("Image uploaded successfully!");
    } catch (e) {
      print("Error uploading image: $e");
    }
  }
}



  @override
  void initState() {
    //profileImageUrl = widget.name
      //  ;

    //bioController.text =  widget.bio;
 
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 900,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Colors.white),
          child: Stack(
            children: [
              ClipPath(
                clipper: MyCustomClipper(),
                child: Container(
                  width: double.infinity,
                  height: 290,
                  color: const Color(0xFF50A9E2),
                ),
              ),
           ////////////
            Positioned(
                left: 36,
                top: 220,
                child:   _imageBytes != null ?
                        CircleAvatar(
                            radius: 64,
                            backgroundImage:MemoryImage(_imageBytes!),
                        )
                        :  
                      
                      
                      
                      
                       CircleAvatar(
                          radius: 64,
                          child: MyImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRz8cLf8-P2P8GZ0-KiQ-OXpZQ4bebpa3K3Dw&usqp=CAU'),
                          
                        ), 

              ),

              Positioned(
                left: 35,
                top: 35,
                child: Row(
                  children: [

                  ],
                ),
              ),
              Positioned(
                left: 30,
                top: 105,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    
                    Text(
                             FirebaseAuth.instance.currentUser!.email ?? '',
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              height: 0,
                            ),
                          ),
                  ],
                ),
              ),
              
             
             
              Positioned(
                left: 26,
                top: 357,
                child: Column(
                  children: [
                    Container(
                      width: 400,
                      height: 150,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Container(
                              width: 400,
                              height: 150,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 1, color: Color.fromRGBO(80, 169, 226, 1)),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 17.56,
                            top: 12,
                            child: SizedBox(
                              width: 340,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const SizedBox(height: 10),
                                  const Text(
                                    'Description',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      fontFamily: 'Roboto',
                                      color: Colors.black,
                                      height: 0.14,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                 TextField(
                                  maxLines: 3,
                            controller: bioController,
                            decoration: const InputDecoration(
                              fillColor: Colors.grey,
                              hintMaxLines: 3,
                              border: InputBorder.none,
                              hintText: 'Bio needs to be here...',
                              hintStyle: TextStyle(fontSize: 14),
                            ),
                          ),
                                  const SizedBox(height: 16),
                                ],
                              ),
                            ),
                          ),
                         
                        ],
                      ),
                    ),
                    SizedBox(height: 15,),
                    ElevatedButton(onPressed: (){
                        updateUserProfile();
                        Navigator.pop(context);
                    },style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color.fromRGBO(80, 169, 226, 1))), child: Text('summit',style: TextStyle(color: Colors.white),))
                  ],
                ),
              ),
              Positioned(
                left: 24,
                top: 150,
                child: Container(
                  width: 185,
                  height: 33,
                  child: Stack(
                    children: [
                  
                     
                    ],
                  ),
                ),
              ),
            
              Positioned(
                left: 135,
                top: 305,
                child: Container(
                  width: 26.27,
                  height: 26,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 5.47, vertical: 5.42),
                  clipBehavior: Clip.antiAlias,
                  decoration:  ShapeDecoration(
                    color: Color(0xFF50A9E2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: GestureDetector(
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 18,
                    ),
                    onTap: () {
                       pickAndUploadImage();
                      // make it to navigate to postpage it is the plus sign in the users profile picture
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
