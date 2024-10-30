

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:login/new.dart';
import 'package:login/profilesnew/edit_2.dart';



import 'clipper.dart';



class ProfileE extends StatefulWidget {
    String User; 

   ProfileE({Key? key,required this.User}) : super(key: key);
 @override
  State<ProfileE> createState() => _EditProfileState();
}


class _EditProfileState extends State<ProfileE> {
  
  @override
  Widget build(BuildContext context) {
    return 
     Scaffold(
        body: ListView(
          children: [
            Profils(User: widget.User,)
            
          ],
        ),
      );
    
  }
}







class Profils extends StatefulWidget {
  String User;
   Profils({Key? key,required this.User}) : super(key: key);
 @override
  // ignore: library_private_types_in_public_api
 State<Profils> createState() => ProfileState();
}

class ProfileState extends State<Profils> {
 final currentUser = FirebaseAuth.instance.currentUser;
  late Stream<DocumentSnapshot<Map<String, dynamic>>> userStream;

  //PanelController panelController = PanelController();

  //bool isPanelOpen = false;
  Stream<DocumentSnapshot<Map<String, dynamic>>> fetchUserData() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .snapshots();
       // .map((doc) => UserModel.fromMap(doc.data() as Map<String, dynamic>));
  }



  @override
  void initState() {
   // profileImageUrl = 
        //"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRz8cLf8-P2P8GZ0-KiQ-OXpZQ4bebpa3K3Dw&usqp=CAU";

   // bioController.text =  "";
   userStream = fetchUserData();
 
    super.initState();
  }




  @override
  Widget build(BuildContext context) {

    return
     StreamBuilder<DocumentSnapshot>(
       stream:userStream ,
       builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
         if (snapshot.connectionState == ConnectionState.active) {
                    final  user = snapshot.data!.data() as Map<String, dynamic>;
                    if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(height:0 ,width:0 ,);
        }
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

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
                    left: 50,
                    top: 200,
                    child:  
                                ClipOval( child:Container(
          height:100 ,
          width: 100,
          child: MyImage(user['profileImageUrl'])))
                              
                                  

              ),

         
                   Positioned(
                left: 170,
                top: 35,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
              
                  
        
                    const SizedBox(width: 10),
                  
                  ],
                ),
              ),
              Positioned(
                top: 95,
                left: 200,
                child: GestureDetector(
                  onTap: () {
                   Navigator.push(context, MaterialPageRoute(builder: (context) =>ProfileEdit(bio: user['bio'],name: user['profileImageUrl'],) ,));
                   
                   
                   //ProfileEdit(user: user,);
                  },
                  child: const Icon(Icons.edit_outlined,
                      color: Colors.white, size: 30),
                ),
              ),

                  Positioned(
                    left: 30,
                    top: 105,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          //width: 209,
                          //height: 37,
                          child:  Text(
                            user['username'],
                            style:GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          ),
         
                        ),
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
                                    Text(
                                user['bio'] ?? 'Bio needs to be here...' ,
                                style: TextStyle(
                                  height: 1.5,
                                  fontSize: 12,
                                  fontFamily: 'Roboto',
                                  color: Color(0xFF8F92A1),
                                  letterSpacing: 1,
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
                        SizedBox(height: 30,),
                          ElevatedButton(onPressed: (){
                                    signout();
                       
                    },style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color.fromRGBO(80, 169, 226, 1))), child: Text('Log out',style: TextStyle(color: Colors.white),))
                      
                      ],
                    ),
                  ),
                 
                
                  
                ],
              ),
            ),
          ],
             );
       }else {
                    return Container(height: 0,width: 0);
       }
       }
     );
  
  

  }
    

}
 void signout(){
           
    FirebaseAuth.instance.signOut();
   
  }

