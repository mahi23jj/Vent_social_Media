import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CommentSection extends StatefulWidget {
  final String postId;

  CommentSection({required this.postId});

  @override
  _CommentSectionState createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  final _firestore = FirebaseFirestore.instance;
  final _commentController = TextEditingController();
  bool _isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Profile Image
        CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(
              'https://example.com/profile_image.jpg'), // Replace with user's profile image URL
        ),

        // User and Comment
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User
              Text(
                'User Name', // Replace with user's name
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),

              // Comment
              Text(
                'This is a comment.', // Replace with user's comment
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),

        // Like Icon
        IconButton(
          icon: Icon(
            _isLiked ? Icons.favorite : Icons.favorite_border,
            color: _isLiked ? Colors.red : Colors.grey,
          ),
          onPressed: () {
            setState(() {
              _isLiked = !_isLiked;
              if (_isLiked) {
                _firestore.collection('posts').doc(widget.postId).collection('likes').doc(FirebaseAuth.instance.currentUser!.uid).set({
                  'created_at': Timestamp.now(),
                });
              } else {
                _firestore.collection('posts').doc(widget.postId).collection('likes').doc(FirebaseAuth.instance.currentUser!.uid).delete();
              }
            });
          },
        ),
      ],
    );
  }
}