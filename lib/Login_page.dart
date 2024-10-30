import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login/Psychologist_signin.dart';
import 'package:login/bottom.dart';
import 'package:login/forgetpasword.dart';
// import 'Psychologist_signin.dart';
import 'User_signin.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController controlEmail = TextEditingController();
  final TextEditingController controlUsername = TextEditingController();
  final TextEditingController controlPassword = TextEditingController();
  bool passwordVisible = false;
  String _errorMessage = '';
  Future<void> signIn() async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: controlEmail.text.trim(),
      password: controlPassword.text.trim() ,
    );
    User? user = userCredential.user;
    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if (userDoc.exists && userDoc.data()?['username'] == controlUsername.text ) {
       Navigator.push(context, MaterialPageRoute(builder: (context) => AnimatedBottomBar(users: controlUsername.text.trim(),uid:user.uid ),));
      } else {
        // Authentication failed
      }
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  }
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
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30)),
                ),
                padding: const EdgeInsets.all(40.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 30),
                      const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.lightBlue,
                          fontSize: 40,
                          fontFamily: 'GoogleFonts.lato',
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(height: 20),
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
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a username';
                              }
                              return null;
                            },
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
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter an email';
                              }
                              // You can add more validation logic here, such as checking for a valid email format
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Password',
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.normal,
                            ),
                            textAlign: TextAlign.start,
                          ),
                          TextFormField(
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
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a password';
                              }
                              // You can add more validation logic here, such as checking for a minimum password length
                              return null;
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(height: 10,),
                              TextButton(onPressed:(){
                                  Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Forget(),
                                  ),
                                );
                              }, child: Text('Forget Password')),
                            ],
                          ),
                          SizedBox(height: 16.0),
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
                          const SizedBox(height: 230),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ElevatedButton(
                                onPressed: (){
                                    
                                        signIn();
               //  await _fetchPosts( controlEmail.text, controlPassword.text, controlUsername.text);
                                },
                                child: Text(
                                  'LOGIN',
                                  style: TextStyle(fontSize: 18),
                                ),
                                style: ElevatedButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.lightBlue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Center(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => RegisterPage()),
                                    );
                                  },
                                  child: Text('Create new account? Sign in',
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).primaryColor),
                                      textAlign: TextAlign.center),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  
}
