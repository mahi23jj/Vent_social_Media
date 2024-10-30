import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/ad/data.dart';
import 'package:login/ad/final_view.dart';
import 'package:login/new.dart';
import 'package:login/pages/images.dart';
import 'package:login/pages/sample.dart';
import 'package:login/shimmer/1.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ternav_icons/ternav_icons.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';






class Post extends StatefulWidget {
  int index;
  QueryDocumentSnapshot<Object?>? ds;
   Post({Key? key,required this.ds,required this.index}) : super(key: key);

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  List<bool> isLikedList = [];
List<bool> isLikeList = [];
  int likeCount = 0;
  bool isLiked = false;
   bool Liked =false;
  bool showComments = false;
  final currentuser=FirebaseAuth.instance.currentUser;


 
  
@override
void initState() {
  super.initState();
  //fetchLikeCount();
  checkLikedState(); // Check if post is liked when screen initializes
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
       
    } else {
      await likeRef.set({'email': user.email}); // Add like
      
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
          child: CommentInputModal(postid: widget.ds!.id,ds: widget.ds,)
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    int likeCount = List<String>.from(widget.ds?['likes']).length;
   // widget.ds?['countlike'] =likeCount;
    bool isLiked = isLikedList.length > widget.index  ? isLikedList[widget.index] : false;
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
       final CollectionReference userco = FirebaseFirestore.instance.collection('users');
  Future<String> UserProfile(String uid) async {
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
        return Container(height: 0,width: 0,);
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else {
       
        return
        
         ClipOval( child:Container(
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
                padding: const EdgeInsets.symmetric(vertical: 8),
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
                onPressed: ()=>_showCommentInput(context),
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

 bool _showWarning = false;
void _postComment() async {
    final comment = _commentController.text.trim();
    if (comment.isEmpty) {
      return; // Handle empty comments
    }
  

    // final isBadContent = await isContentBad(comment);
    // if (isBadContent) {
    //   setState(() {
    //     _showWarning = true;
    //   });
    // } else {
      // Proceed with posting the comment
      print('Good comment: $comment');
      setState(() {

       // _comments.add(_commentController.text);
        _commentController.clear();
        _showWarning = false;
      });
// }
    
  }

  // Future<bool> isContentBad(String content) async {
  //   final String apiKey = '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';
  //   final Uri apiUrl = Uri.parse('https://api.openai.com/v1/chat/completions');

  //   try {
  //     final response = await http.post(
  //       apiUrl,
  //       headers: <String, String>{
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $apiKey',
  //       },
  //       body: jsonEncode(<String, dynamic>{
  //         "model": "gpt-3.5-turbo",
  //         "messages": [
  //           {
  //             "role": "system",
  //             "content": "Assistance, just do what I command you to do"
  //           },
  //           {
  //             "role": "user",
  //             "content":
  //                 "Please assess the content below to determine if it contains any forms of inappropriate or objectionable material. Specifically, check for insults, sexually explicit content, hate speech, offensive language, or any other content that may be considered harmful or inappropriate.\n\nTo provide your assessment, respond with either 'true' or 'false' (in lowercase) to indicate whether the content is problematic. Please avoid using ambiguous responses such as 'maybe' or 'uncertain' and provide a clear 'true' or 'false' response.\n\nHere is the content for your review:\n$content"
  //           },
  //         ],
  //       }),
  //     );
  //     if (response.statusCode == 200) {
  //       final responseJson = jsonDecode(response.body);
  //       final String textResponse =
  //           responseJson['choices'][0]['message']['content'].trim();
  //       print(textResponse);
  //       return textResponse.toLowerCase() == 'true';
  //     } else {
  //       print('Error from API: ${response.body}');
  //       throw Exception(
  //           'Failed to get response. Status code: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Exception caught: $e');
  //     throw Exception('Error checking content: $e');
  //   }
  // }

final currentuser=FirebaseAuth.instance.currentUser;
 //,String? elem
 
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
Future<String> Profile(String id) async {
  try {
    final userId = await userco.doc(id).get();
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
                     future: UserProf(ml?['id']),
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
                     future: Profile(ml?['id']),
                       builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                       if (snapshot.connectionState == ConnectionState.waiting) {
                           return Container(height: 0,width: 0,);
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else {
        return   Text(snapshot.data!,
                                 
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
           if (_showWarning)
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.7),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Warning: An inappropriate comment has been identified, which violates our privacy policy. Kindly revise your content.',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
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
                          onChanged: (value) {
                            setState(() {
                              _showWarning = false;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: 'Write your comment here...',
                            border: InputBorder.none,
                            errorText: _showWarning ? '' : null,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                onPressed:(){
                  _postComment();
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



class TopPage extends StatefulWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  _TelegramProfileState createState() => _TelegramProfileState();
}

class _TelegramProfileState extends State<TopPage> {
  Stream<QuerySnapshot>? _userStream;
  Color colorPrimary = Color.fromARGB(255, 50, 171, 218);

  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _userStream = FirebaseFirestore.instance
        .collection('Hackthon')
        .orderBy('likesCount', descending: true)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _userStream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 150, child: ImageSlider()),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
                child: Text(
                  "Top Stories",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(snapshot.data!.docs.length, (index) {
                          return 
                          
                          Post(
                            index: index,
                            ds: snapshot.data?.docs[index],
                          );
                        }),
                        
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}



           







        
        
        
        
        
        
        
        
        
        
            
                  

