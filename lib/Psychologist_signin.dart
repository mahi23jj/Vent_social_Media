// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'User_signin.dart';
import 'Login_page.dart';

class PsychoPage extends StatefulWidget {
  const PsychoPage({Key? key}) : super(key: key);

  @override
  _PsychoPageState createState() => _PsychoPageState();
}

class _PsychoPageState extends State<PsychoPage> {
  final TextEditingController controlNickname = TextEditingController();
  final TextEditingController controlUsername = TextEditingController();
  final TextEditingController controlEmail = TextEditingController();

  String selectedUniversity = 'University A';

  @override
  void initState() {
    super.initState();
    selectedUniversity = 'University A';
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
                      textAlign: TextAlign.start,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: 30),
                        const Text(
                          'Username',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.normal,
                          ),
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
                        SizedBox(height: 20),
                        Text(
                          'Nick name',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        TextFormField(
                          controller: controlNickname,
                          obscureText: false,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person_3_rounded),
                            hintText: 'Nick name',
                            hintStyle: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Email',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        TextFormField(
                          controller: controlEmail,
                          obscureText: false,
                          decoration: InputDecoration(
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
                        SizedBox(height: 20),
                        Text(
                          'Select University:',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'GoogleFonts.lato',
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          child: DropdownButton<String>(
                            value: selectedUniversity,
                            onChanged: (newValue) {
                              setState(() {
                                selectedUniversity = newValue!;
                              });
                            },
                            items: <String>[
                              'University A',
                              'University B',
                              'University C',
                              'University D',
                            ].map<DropdownMenuItem<String>>(
                              (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              },
                            ).toList(),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Upload CV:',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'GoogleFonts.lato',
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            // Spacer(),
                            OutlinedButton.icon(
                              onPressed: () {},
                              //upload image part
                              style: OutlinedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                foregroundColor: Colors.grey,
                                backgroundColor: Colors.white,
                                // side: const```dart
                                // BorderSide(color: Colors.grey, width: 2),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                              ),
                              icon: const Icon(Icons.file_upload_outlined),
                              label:
                                  const Text('   Upload product Picture     '),
                            ),
                            Spacer(),
                          ],
                        ),
                        SizedBox(height: 100),
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
                                "Sign in as User",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            Spacer(),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DropdownMenuPage()),
                                );
                              },
                              child: Text(
                                "Next",
                                style: TextStyle(color: Colors.lightBlue),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
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

class DropdownMenuPage extends StatefulWidget {
  const DropdownMenuPage({Key? key}) : super(key: key);

  @override
  _DropdownMenuPageState createState() => _DropdownMenuPageState();
}

class _DropdownMenuPageState extends State<DropdownMenuPage> {
  String selectedUniversity = 'University A';
  String selectedYear = 'Year 1';
  final TextEditingController controlPassword = TextEditingController();
  bool password = false;
  bool passwordVisible = false;

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
                            Navigator.push(context, MaterialPageRoute(builder: (context) => MyWidget(),));
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
                          onPressed: password ? _registrar : null,
                          child: Text(
                            'Sign in as User',
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
                                  builder: (context) => PsychoPage()),
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
class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Column(
      children: [
        Icon(Icons.lock,size:40 ,),
        SizedBox(height: 10,),
        Text('sorry,no new registration for now')
      ],
    ),),);
  }
}
