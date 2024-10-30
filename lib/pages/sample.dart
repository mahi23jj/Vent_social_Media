import 'dart:js_util';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/new.dart';
import 'package:login/pages/images.dart';
import 'package:login/shimmer/1.dart';
import 'package:shimmer/shimmer.dart';


class AcademicPage extends StatefulWidget {
  
  final String typeId;
  const AcademicPage({Key? key,required this.typeId,}) : super(key: key);
   @override
  _TelegramProfileState createState() => _TelegramProfileState();
} 

class _TelegramProfileState extends State<AcademicPage> {
  Stream<QuerySnapshot>? _userStream;
  


final currentuser=FirebaseAuth.instance.currentUser;
@override
  void initState() {
    super.initState();
    _userStream = FirebaseFirestore.instance
            .collection('Hackthon')
            .where('type', arrayContains: widget.typeId)
            .snapshots();
  }

 


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color.fromARGB(255, 245, 245, 245),
      ),
      home: Scaffold(
        body: StreamBuilder<QuerySnapshot>(
  stream: _userStream,
  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.hasError) {
      return Text('Something went wrong');
    }

    if (snapshot.connectionState == ConnectionState.waiting) {
      return Home();
    }

    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: snapshot.data?.docs.length,
      itemBuilder: (context, index) {
       
        // Replace the placeholder content with actual data from snapshot
        return Post(index:index,ds: snapshot.data?.docs[index]);
      },
    );
  },
),

      ),
    );
  }
}

class Post extends StatefulWidget {

  int index;
  QueryDocumentSnapshot<Object?>? ds;
   Post({Key? key,required this.ds,required this.index,}) : super(key: key);

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  List<bool> isLikedList = [];
List<bool> isLikeList = [];
  int likeCount = 0;
  int count =0;
  bool isLiked = false;
 bool Liked = false;
  bool showComments = false;
  final currentuser=FirebaseAuth.instance.currentUser;
   
  late String _profileImageUrl;
 
@override
void initState() {
  super.initState();
 
   //loadUserProfile();
  checkLikedState(); // Check if post is liked when screen initializes
}
 //String profileImageUrl='https://th.bing.com/th/id/OIP.GHGGLYe7gDfZUzF_tElxiQHaHa?rs=1&pid=ImgDetMain';
 final CollectionReference userco = FirebaseFirestore.instance.collection('users');
 // ignore: non_constant_identifier_names

Future<String> UserProfile(String id) async {
  try {
    final userId = await userco.doc(id).get();
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

 

void checkLikedState() async {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    String userId = user.uid;
    DocumentSnapshot likeDoc = await FirebaseFirestore.instance
        .collection('Hackthon')
        .doc(widget.ds?.id)
        .collection('like')
        .doc(userId)
        .get();

    setState(() {
      Liked = likeDoc.exists; // Update liked state based on document existence
    });
  }
}






  void toggleLikeState() async {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    String userId = user.uid;
    DocumentReference likeRef = FirebaseFirestore.instance
        .collection('Hackthon')
        .doc(widget.ds?.id)
        .collection('like')
        .doc(userId);

    if (Liked) {
      await likeRef.delete();
       if (count > 0) { // Remove like
       setState(() {
        count--; // Decrement likeCount
      });
       }
    } else {
      await likeRef.set({'email': user.email}); // Add like
       setState(() {
       count++; // Increment likeCount
      });
    }
    // Update the like count in the post document
    FirebaseFirestore.instance
        .collection('Hackthon')
        .doc(widget.ds?.id)
        .update({'likesCount': likeCount});

    setState(() {
      Liked = !Liked; // Toggle liked state
    });
  }
}
void _showCommentInput(BuildContext context) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      //backgroundColor: Color.fromRGBO(204, 210, 205, 1),
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.6,
          child: CommentInputModal(postid: widget.ds!.id,ds: widget.ds,),
        );
      },
    );
  }




  
  // Define a method to save liked state to local storage



 

  @override
  Widget build(BuildContext context) {
   // int likeCount = List<String>.from(widget.ds?['likes']).length;
   // bool isLiked = isLikedList.length > widget.index  ? isLikedList[widget.index] : false;
      Duration difference = DateTime.now().difference(widget.ds?['created_at'].toDate());
      String getTimeElapsed(Duration difference) {
         if (difference.inDays > 0) {
                  return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
         } else if (difference.inHours > 0) {
                  return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
        } else if (difference.inMinutes > 0) {
                  return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
        } else {
         return 'just now';
           }
        }

      String timeElapsed = getTimeElapsed(difference);
      
                            
    if(widget.ds?['isposted']){
      return Container(
       margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
            
     
  FutureBuilder<String>(
    future: UserProfile(widget.ds?['id']),
    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator();
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else {
        return ClipOval( child:Container(
          height:40 ,
          width: 40,
          child: MyImage(snapshot.data!)));
      }
    },
  ),

              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    Text(
                       widget.ds?['user'],
             
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'AASTU',
                          style: TextStyle(
                            fontWeight: FontWeight.w100,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(width:5 ,),
                        Text(
                          timeElapsed,
                          style: TextStyle(
                            fontWeight: FontWeight.w100,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
         Column(
            children: [
              
              
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: widget.ds?['name'] != null && widget.ds?['name'].isNotEmpty
                      ? Text(widget.ds?['name'],style:GoogleFonts.roboto(
                        fontSize: 14.0,
                      //fontWeight: FontWeight.bold,
                      color: Colors.black,
                      )
                      
                      
                    
                    )
                      : Container(),
            ),
              
            ],
          ),
          Column(
            children: [
              
                 ClipRect(
                  child: Align(
                    alignment: Alignment.topCenter,
                    heightFactor: 0.7,
                    child: widget.ds?['image'] != null && widget.ds?['image'].isNotEmpty
                    ? Container(
                        
                        height: 350,
                        width: double.infinity,
                        child:MyImage(widget.ds?['image']),
                      )
                    : Container(),
                  ),
                ),
              
            ],
          ),
          Row(
            children: [
           GestureDetector(
  onTap: () {
    toggleLikeState();
  },
  child: Icon(
    Liked ? Icons.favorite : Icons.favorite_border,
    color: Liked ? Colors.red : Colors.grey,
  ),
),
              const SizedBox(width: 8),
              PostItem(widget.ds!.id),
             
              Spacer(),
               IconButton(
                icon: Icon(Icons.message_sharp),
                color: Colors.black45,
                onPressed:()=>_showCommentInput(context) ,
              ),
             
            ],
          ),
         // if (showComments) CommentsSection(postid: widget.ds!.id ,),
        ],
      ),
    );
    }else{
     return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRz8cLf8-P2P8GZ0-KiQ-OXpZQ4bebpa3K3Dw&usqp=CAU',
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    Text(
                      'Annonymes',
             
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'AASTU ',
                          style: TextStyle(
                            fontWeight: FontWeight.w100,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          timeElapsed,
                          style: TextStyle(
                            fontWeight: FontWeight.w100,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
         Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: 
              
            widget.ds?['name'] != null && widget.ds?['name'].isNotEmpty
                    ? Text(widget.ds?['name'],style:  GoogleFonts.roboto(
                    fontSize: 14.0,
                   // fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  )
                    : Container(),
              )
            ],
          ),
          Column(
            children: [
              ClipRect(
                child: Align(
                  alignment: Alignment.topCenter,
                  heightFactor: 0.7,
                  child: widget.ds?['image'] != null && widget.ds?['image'].isNotEmpty
                  ? Container(
                      height: 350,
                      width: double.infinity,
                      child:MyImage(widget.ds?['image']),
                    )
                  : Container(),
                ),
              ),
            ],
          ),
          Row(
            children: [
              GestureDetector(
                onTap: (){
                 toggleLikeState();
                },
                child: Icon(
                  Liked ? Icons.favorite : Icons.favorite_border,
                  color: Liked ? Colors.red : Colors.black,
                ),
              ),
              const SizedBox(width: 8),
            PostItem(widget.ds!.id),
              Spacer(),
              IconButton(
                icon: Icon(Icons.message_sharp),
                color: Colors.black45,
                onPressed:()=>_showCommentInput(context) ,
              ),
              
                
              
            ],
          ),
          //if (showComments) CommentsSection(postid: widget.ds!.id ,),
        ],
      ),
    );
      
    }
  }
}
class CommentInputModal extends StatefulWidget {
  String postid;
   QueryDocumentSnapshot<Object?>? ds;
 CommentInputModal({super.key,required this.postid,required this.ds});
  @override
  _CommentInputModalState createState() => _CommentInputModalState();
}

class _CommentInputModalState extends State<CommentInputModal> {
  final TextEditingController _commentController = TextEditingController();
  List<String> _comments = [];

  
  
  
final currentuser=FirebaseAuth.instance.currentUser;
 //,String? elem
  void _postComment(String comment){
    FirebaseFirestore.instance.collection('Hackthon').doc(widget.postid).collection('comment').add({
      "commenttext":comment,
      "commenttime":Timestamp.now(),
     // 'user': elem
    });
    //_commentController.clear();
  }
   final CollectionReference userco = FirebaseFirestore.instance.collection('users');
  Future<String> UserProf(String uid) async {
  try {
    final userId = await userco.doc(uid).get();
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
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Text('comments')),
          Divider(),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('Hackthon').doc(widget.postid).collection('comment').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot>  snapshot) {
                 if (snapshot.hasError) {
                                                          return  Text('Something went wrong');
                                                        }
                                                        if (snapshot.connectionState == ConnectionState.waiting) {
                                                          return Container(height: 0,width: 0,);
                                          
                                                        } 
                return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.only(left: 10),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                        QueryDocumentSnapshot<Object?>? ml =
                                                                      snapshot.data?.docs[index];

                   
                 Duration difference = DateTime.now().difference(ml?['commenttime'].toDate());
      String getTimeElapsed(Duration difference) {
         if (difference.inDays > 0) {
                  return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
         } else if (difference.inHours > 0) {
                  return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
        } else if (difference.inMinutes > 0) {
                  return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
        } else {
         return 'just now';
           }
        }

      String timeElapsed = getTimeElapsed(difference);
          


                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          FutureBuilder<String>(
    future: UserProf(currentuser!.uid),
    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Container(height: 0,width: 0,);
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else {
        return ClipOval( child:Container(
          height:40 ,
          width: 40,
          child: MyImage(snapshot.data!)));
      }
    },
  ),
                        
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                  FutureBuilder<String>(
    future: Profile(),
    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Container(height: 0,width: 0,);
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else {
        return Text(
                                 snapshot.data!,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                );
      }
    },
  ),
                                
                                const SizedBox(height: 5),
                                Text(
                                 ml?['commenttext'] ,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
                FutureBuilder<String>(
    future: UserProf(currentuser!.uid),
    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Container(height: 0,width: 0,);
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else {
        return ClipOval( child:Container(
          height:40 ,
          width: 40,
          child: MyImage(snapshot.data!)));
      }
    },
  ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11),
                    color: Colors.black12,
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: _commentController,
                          decoration: const InputDecoration(
                            hintText: 'Write your comment here...',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                onPressed:(){
                  _postComment(_commentController.text);
                },
                icon: Icon(Icons.send),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


class PostItem extends StatelessWidget {
  final String postSnapshot;

   PostItem(this.postSnapshot);

  @override
  Widget build(BuildContext context) {
    return 
      
       StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Hackthon')
            .doc(postSnapshot)
            .collection('like')
            .snapshots(),
        builder: (context, snapshot) {
             if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(height: 0, width: 0);
          }

          int likeCount = snapshot.data!.docs.length;
          FirebaseFirestore.instance
        .collection('Hackthon')
        .doc(postSnapshot)
        .update({'likesCount': likeCount});

          return 
           Text(
               '$likeCount like' ,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              );
        },
      );
    
  }
}
