import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login/new.dart';

class ImagePage extends StatefulWidget {
  const ImagePage({super.key});



 

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ImagePage> {



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
          return CircleAvatar(
            backgroundImage:NetworkImage('https://www.pngall.com/wp-content/uploads/5/Profile.png'),
          );

        }

        var data = snapshot.data!.data() as Map<String, dynamic>;
        return MyImage(data['profile_image_url']);
      },
    );
  }
}
