import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Forget extends StatefulWidget {
  const Forget({super.key});

  @override
  State<Forget> createState() => _Forgetpage();
}
class _Forgetpage extends State<Forget> {
final TextEditingController my = TextEditingController();
Future resets()async{
  try{
   FirebaseAuth.instance.sendPasswordResetEmail(email: my.text.trim());
  } on FirebaseAuthException catch(e){
    if (kDebugMode) {
      return(e);
    }
    showDialog(context: context, builder: (context) {
      return AlertDialog(content: Text(e.message.toString()),);
    },);
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text('Enter your email to get reset link',style: TextStyle(fontWeight: FontWeight.bold),),
        ),
        SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.only(left: 100, right: 100, top: 100),
          child: TextField(
            controller: my,
            decoration: InputDecoration(
              hintText: 'Email',
              prefixIcon: const Icon(
                Icons.people,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.black),
              ),
            ),
          ),
        ),
        SizedBox(height: 10,),
         Center(
                    child: TextButton(
                      onPressed: () =>resets(),
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.black)),
                      child: const Text(
                        'Restart',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                    Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.black)),
                      child: const Text(
                        'Back',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
      ],
    )
    );
  }
}
