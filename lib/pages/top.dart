
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/new.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class PostsPage extends StatefulWidget {
  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  List<Map<String, dynamic>> _posts = [];

@override
void initState() {
  super.initState();
  _fetchPosts();
}
Future<void> _fetchPosts() async {
  final CollectionReference numsRef = FirebaseFirestore.instance.collection('nums');
  final DocumentReference allRef = numsRef.doc('all');
  final List<QuerySnapshot> subCollectionSnapshots = [];

  for (int i = 1; i <= 5; i++) {
    final QuerySnapshot snapshot = await allRef.collection('$i').orderBy('likes', descending: true).get();
    subCollectionSnapshots.add(snapshot);
  }

  // Clear the _posts list before populating it with new data
  _posts.clear();

  for (final QuerySnapshot snapshot in subCollectionSnapshots) {
    for (final QueryDocumentSnapshot doc in snapshot.docs) {
      final Map<String, dynamic> docData = doc.data() as Map<String, dynamic>;
      final dynamic likes = docData['likes'];

      int likeCount = 0;
      if (likes is List) {
        for (final dynamic like in likes) {
          if (like is String && like.contains('@')) {
            likeCount++;
          }
        }
      } else if (likes is int) {
        likeCount = likes;
      }

      final postData = Map<String, dynamic>.from(docData);
      postData['likes'] = likeCount;
      _posts.add(postData);
    }
  }

  _posts.sort((a, b) => b['likes'].compareTo(a['likes'])); // Sort based on likes
  setState(() {});
}
List<bool> isLikedList = [];
List<bool> isLikeList = [];
  int likeCount = 0;
  bool isLiked = false;
  final currentuser=FirebaseAuth.instance.currentUser;


     

  @override
  Widget build(BuildContext context) {
    return
       Scaffold(
        appBar: AppBar(title: Text('Posts')),
        body: ListView.builder(
          itemCount: _posts.length,
          itemBuilder: (context, index) {
            final post = _posts[index];
          //return   ListTile(title: Text(post['name']),);
           Duration difference = DateTime.now().difference(post['created_at'].toDate());
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


            return  Container(
      margin: const EdgeInsets.all(16),
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
                  "https://images.unsplash.com/photo-1587778082149-bd5b1bf5d3fa?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    Text(
             // widget.ds?['user'],
             'mahi',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
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
              ),
            ],
          ),
         Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: 
              
            post['name'] != null && post['name'].isNotEmpty
                    ? Text(post['name'],style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
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
                  child: post['image'] != null && post['image'].isNotEmpty
                  ? Container(
                      height: 200,
                      width: double.infinity,
                      child:MyImage(post['image']),
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
                 setState(() {
          isLiked = !isLiked;
       //   saveLikedState(isLiked);

          if (isLiked) {
            // Perform actions when post is liked
          //  post  .reference.update({'likes': FieldValue.arrayUnion([currentuser?.email])});
           // likeCount++;
          } else {
            // Perform actions when post is unliked
           // widget.ds?.reference.update({'likes': FieldValue.arrayRemove([currentuser?.email])});
           // likeCount--;
          }
      //   isLikedList[widget.index] = isLiked; 
        }); 
                },
                child: Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border,
                  color: isLiked ? Colors.red : Colors.black,
                ),
              ),
              const SizedBox(width: 8),
              Text(
               likeCount.toString() ,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
         //if (showComments) Comments(postid: widget.postId,),
        ],
      ),
        ]
    ),
            );
            
        //  return  Pos(dst: post,);
           
          },
        ),
      );
    
  }
}
// ignore: must_be_immutable
class Pos extends StatefulWidget {

 // int index;
  Map<String, dynamic> dst;
   Pos({Key? key,required this.dst,}) : super(key: key);

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Pos> {
  List<bool> isLikedList = [];
List<bool> isLikeList = [];
  int likeCount = 0;
  bool isLiked = false;
  bool showComments = false;
  final currentuser=FirebaseAuth.instance.currentUser;



  void _toggleComments() {
    setState(() {
      showComments = !showComments;
    });
  }

  @override
  Widget build(BuildContext context) {
    int likeCount = List<String>.from(widget.dst['likes']).length;
    //bool isLiked = isLikedList.length > widget.index  ? isLikedList[widget.index] : false;
                            
    if(widget.dst['isposted']){
      return Container(
      margin: const EdgeInsets.all(16),
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
                  "https://images.unsplash.com/photo-1587778082149-bd5b1bf5d3fa?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    Text(
             // widget.ds?['user'],
             'mahi',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'AASTU, 1 day ago',
                      style: TextStyle(
                        fontWeight: FontWeight.w100,
                        fontSize: 12,
                      ),
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
              
            widget.dst['name'] != null && widget.dst['name'].isNotEmpty
                    ? Text(widget.dst['name'],style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
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
                  child: widget.dst['image'] != null && widget.dst['image'].isNotEmpty
                  ? Container(
                      height: 200,
                      width: double.infinity,
                      child:MyImage(widget.dst['image']),
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
                 setState(() {
          isLiked = !isLiked;
       //   saveLikedState(isLiked);

          if (isLiked) {
            // Perform actions when post is liked
            // widget.ds?.reference.update({'likes': FieldValue.arrayUnion([currentuser?.email])});
           // likeCount++;
          } else {
            // Perform actions when post is unliked
          // widget.ds?.reference.update({'likes': FieldValue.arrayRemove([currentuser?.email])});
          // likeCount--;
          }
      //   isLikedList[widget.index] = isLiked; 
        }); 
                },
                child: Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border,
                  color: isLiked ? Colors.red : Colors.black,
                ),
              ),
              const SizedBox(width: 8),
              Text(
               likeCount.toString() ,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              IconButton(
                icon: Icon(Icons.comment_outlined),
                color: Colors.black45,
                onPressed: _toggleComments,
              ),
              Text(
                'Comments',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
         //if (showComments) Comments(postid: widget.postId,),
        ],
      ),
    );
    }else{
      return
      Container();
    }
  }
}
