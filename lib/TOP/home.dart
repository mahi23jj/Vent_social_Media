
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/ad/final_view.dart';
import 'package:login/new.dart';
import 'package:login/pages/images.dart';
import 'package:login/TOP/topview.dart';




class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(93);
  final CollectionReference userco = FirebaseFirestore.instance.collection('users');
  Future<String> UserProfile() async {
  try {
    final userId = await userco.doc(FirebaseAuth.instance.currentUser?.uid).get();
    if (userId.exists) {
      final data = userId.data() as Map<String, dynamic>;
      return data['profileImageUrl'];
    } else {
      throw Exception('User not found');
    }
  } catch (e) {
    print('Error in UserProfile: $e');
    throw Exception('Error in UserProfile: $e');
  }
}
 Future<String> Profile() async {
  try {
    final userId = await userco.doc(FirebaseAuth.instance.currentUser?.uid).get();
    if (userId.exists) {
      final data = userId.data() as Map<String, dynamic>;
      return data['username'];
    } else {
      throw Exception('User not found');
    }
  } catch (e) {
    print('Error in UserProfile: $e');
    throw Exception('Error in UserProfile: $e');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric( horizontal: 16.0,vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [


              FutureBuilder<String>(
    future: UserProfile(),
    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Container(height: 0,width: 0,);
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else {
        return ClipOval( child:Container(
          height:55 ,
          width: 55,
          child: MyImage(snapshot.data!)));
      }
    },
  ),
              
              const SizedBox(width: 12),
               Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                   //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Hello,',
                          style: GoogleFonts.roboto(
                            color: Color(0xFF15193F),
                            fontSize: 20,
                           
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(width: 4,),
                         FutureBuilder<String>(
    future: Profile(),
    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Container(height: 0,width: 0,);
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else {
        return   Text(
                          snapshot.data!,
                          style: GoogleFonts.roboto(
                            color: Color(0xFF15193F),
                            fontSize: 20,
                           
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        );

      }
    },
  ),
                        
                      ],
                    ),
                    Text(
                      'Welcome Back',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0), // Reduced gap
        child: Container(
          width: double.infinity,
          height:  700,
          child: Align(
            alignment: Alignment.centerLeft,
            child: CombinedWidget(),
          ),
        ),
      ),
    );
  }
}


class CombinedWidget extends StatelessWidget {
  CombinedWidget({Key? key}) : super(key: key);


   final CollectionReference userco = FirebaseFirestore.instance.collection('users');
  Future<String> UserProfile() async {
  try {
    final userId = await userco.doc(FirebaseAuth.instance.currentUser?.uid).get();
    if (userId.exists) {
      final data = userId.data() as Map<String, dynamic>;
      return data['profileImageUrl'];
    } else {
      throw Exception('User not found');
    }
  } catch (e) {
    print('Error in UserProfile: $e');
    throw Exception('Error in UserProfile: $e');
  }
}
 Future<String> Profile() async {
  try {
    final userId = await userco.doc(FirebaseAuth.instance.currentUser?.uid).get();
    if (userId.exists) {
      final data = userId.data() as Map<String, dynamic>;
      return data['username'];
    } else {
      throw Exception('User not found');
    }
  } catch (e) {
    print('Error in UserProfile: $e');
    throw Exception('Error in UserProfile: $e');
  }
}

  @override
  Widget build(BuildContext context) {
    return 
       
         MaterialApp(
          debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color.fromRGBO(250, 249, 248, 1),
      ),
           home: const Scaffold(
             body:Column(
                       
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              
                // Expanded(child: FinalView()),
                 
               
                    
                       
                            
                                 
                                  
                                    
                                  
                                 
                               
                    Expanded   (
                      child:TopPage() ,)
                      
                     
                   
                 
                   
                ],
                     ),
           
           ),
         );
      
    
  }
}
