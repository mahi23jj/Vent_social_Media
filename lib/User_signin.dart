// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login/bottom.dart';
import 'Psychologist_signin.dart';
import 'Login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController controlNickname = TextEditingController();
  final TextEditingController controlUsername = TextEditingController();
  final TextEditingController controlEmail = TextEditingController();
  bool passwordVisible = false;
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.lightBlue,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 150),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30)),
                ),
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 30),
                    const Text(
                      'Sign in',
                      style: TextStyle(
                        color: Colors.lightBlue,
                        fontSize: 40,
                        fontFamily: 'GoogleFonts.lato',
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.end,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: 30),
                        const Text(
                          'Username',
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.normal,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        TextFormField(
                          controller: controlUsername,
                          obscureText: false,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person_3_rounded),
                            hintText: 'Username',
                            hintStyle: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Email',
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.normal,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        TextFormField(
                          controller: controlEmail,
                          obscureText: false,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            hintText: 'example@gmail.com',
                            hintStyle: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 130),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PsychoPage()),
                                );
                              },
                              child: Text(
                                "Sign in as Psychologist",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            Spacer(),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LastPage(mails:controlEmail.text,use: controlUsername.text,)),
                                );
                              },
                              child: Text(
                                "Next",
                                style: TextStyle(color: Colors.lightBlue),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signIn() {
    
    String email = controlEmail.text;
    print('Email: $email');
  }
}

class LastPage extends StatefulWidget {
  String use;
  String mails;
  LastPage({Key? key,required this.mails,required this.use}) : super(key: key);

  @override
  _LastPageState createState() => _LastPageState();
}

class _LastPageState extends State<LastPage> {
  String selectedUniversity = 'University A';
  String selectedYear = 'Year 1';
  final TextEditingController controlPassword = TextEditingController();
  final TextEditingController   contfirmPassword =TextEditingController();
  bool password = false;
  bool passwordVisible = false;
   void signin(){
           if (paswordcheak()){
    FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: widget.mails,
     password: controlPassword.text.trim()
    );
   }
  }
  Future<void> signUp() async {
 if (paswordcheak()){
  try {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: widget.mails,
      password: controlPassword.text.trim(),
    );
    User? user = userCredential.user;
    if (user != null) {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'username': widget.use,
        'email': widget.mails,
        'profileImageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRz8cLf8-P2P8GZ0-KiQ-OXpZQ4bebpa3K3Dw&usqp=CAU',
        'bio':'',
      });
    Navigator.push(context, MaterialPageRoute(builder: (context) => AnimatedBottomBar(users: widget.use,uid:user.uid,),));
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  }
 }
}



  bool paswordcheak() {
    if (contfirmPassword.text.trim() == controlPassword.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    selectedUniversity =
        'University A'; // Initialize selectedUniversity with a default value
    selectedYear = 'Year 1'; // Initialize selectedYear with a default value
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.lightBlue,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 150),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30)),
                ),
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 30),
                    const Text(
                      'Sign in',
                      style: TextStyle(
                        color: Colors.lightBlue,
                        fontSize: 40,
                        fontFamily: 'GoogleFonts.lato',
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 50),
                    Container(
                      width: double.infinity,
                      child: Text(
                        'Password',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.normal,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    TextField(
                      controller: controlPassword,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          },
                        ),
                        hintText: "*********",
                        hintStyle: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      obscureText: !passwordVisible,
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      child: Text(
                        'Password',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.normal,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    TextFormField(
                      controller: contfirmPassword,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          },
                        ),
                        hintText: "*********",
                        hintStyle: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      obscureText: !passwordVisible,
                      validator: (value) {
                          if (value == controlPassword.text.trim()) {
                            return null;
                          } else {
                            return 'error';
                          }
                        },
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        Checkbox(
                          value: password,
                          onChanged: (valor) {
                            setState(() {
                              password = valor ?? false;
                            });
                          },
                        ),
                        const Column(
                          children: [
                            Text(
                              'By checking the box, you agree to our',
                            ),
                            Text(
                              ' Term & Conditions',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 100),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ElevatedButton(
                          onPressed: (){
                             signUp();
                             
                          },
                          child: Text(
                            'SIGN UP',
                            style: TextStyle(fontSize: 14),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.lightBlue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Or",
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PsychoPage()),
                            );
                          },
                          child: Text(
                            'Sign in as Psychologist',
                            style: TextStyle(fontSize: 14),
                          ),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                          );
                        },
                        child: Text('Already have an account? Sign in',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                            textAlign: TextAlign.center),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterPage()),
                            );
                          },
                          child: Text(
                            "Back",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _registrar() {
    print('Create account');
  }

  void _signIn() {
    String password = controlPassword.text;

    print('Password: $password');
  }
}
