// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:login/TOP/home.dart';
import 'package:login/TOP/topview.dart';
import 'package:login/onbording/splash.dart';
import 'package:login/pages/sample.dart';
import 'package:login/psycho/first.dart';
import 'Login_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyBlTYfFd5W0fk2ELD0oVIXOPSy9DmvHLuY",
        appId: "1:953539689403:web:4b52be341be90317b4e29e",
        messagingSenderId: "953539689403",
        projectId: "login-4471f",
        storageBucket: "login-4471f.appspot.com",
      ),
    );
  }

  await Firebase.initializeApp();
  runApp (MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: ThemeData(
    textTheme: TextTheme(
      titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(fontSize: 16, color: Colors.grey),
      // Add more custom styles as needed
    ),
  ),
      home:SplashPage(),
      
      //PostsPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class toPage extends StatefulWidget {
  
  const toPage({Key? key}) : super(key: key);
   @override
  _TelegramProfileState createState() => _TelegramProfileState();
} 

class _TelegramProfileState extends State<toPage> {
  // List<Map<String, dynamic>> _academicPosts = [];
 
 bool isLiked=false;


  @override
  Widget build(BuildContext context) {
   
    return 
       Scaffold(
        body: GestureDetector(
               onTap: () {
    
      //final email = user.email;
      setState(() {
        isLiked=true;
        //print(isLiked);
      });
    },
  
                child: Icon(
                  isLiked ? Icons.favorite: Icons.favorite_border ,
                  color: isLiked ? Colors.red : Colors.grey,
                ),
              ),
       );
  }
}
