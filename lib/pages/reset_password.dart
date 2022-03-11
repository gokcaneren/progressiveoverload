import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:progressive_overload/constants.dart';
import 'package:progressive_overload/services/auth.dart';

class RePassword extends StatefulWidget {
  const RePassword({Key? key}) : super(key: key);

  @override
  State<RePassword> createState() => _RePasswordState();
}

class _RePasswordState extends State<RePassword> {
  final TextEditingController _emailController = TextEditingController();

  AuthService _authService = AuthService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          title: Text('Password Recovery', style: kBaslikStil),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.transparent),
      body: Center(
        child: Container(
          height: 250,
          width: 400,
          decoration: BoxDecoration(
              color: Colors.blue[800]!.withOpacity(0.7),
              borderRadius: BorderRadius.circular(21)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Container(
                child: Text(
                  'We Will Send You a Recovery Link',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Text('Enter Your Email',
                    style: TextStyle(color: Colors.white)),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 300,
                child: TextFormField(
                  controller: _emailController,
                  cursorColor: Colors.white,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.mail,
                      color: Colors.white,
                    ),
                    hintText: 'E-mail',
                    hintStyle: TextStyle(color: Colors.white),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () async{
                  try {
                    await _auth.sendPasswordResetEmail(email: _emailController.text);
                    FocusScope.of(context).requestFocus(FocusNode());
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: kBoxColor,
                            title: Center(
                              child: Text(
                                'Password Recovery!',
                                style: kBaslikStil2,
                              ),
                            ),
                            content: Text(
                              'Please check your email to reset your password!',
                              style: kMiniStil2,
                            ),
                            actions: [
                              Center(
                                  child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pushReplacementNamed(context, "/");
                                      },
                                      child: Text('OK!')))
                            ],
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(32.0))),
                          );
                        });
                  } on FirebaseAuthException catch (e) {
                    print('yanssss');
                    FocusScope.of(context).requestFocus(FocusNode());
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: kBoxColor,
                            title: Center(
                              child: Text(
                                'Cannot Send!',
                                style: kBaslikStil2,
                              ),
                            ),
                            content: Text(
                              'Email is wrong!',
                              style: kMiniStil2,
                            ),
                            actions: [
                              Center(
                                  child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('OK!')))
                            ],
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(32.0))),
                          );
                        });
                  }
                },
                child: Text(
                  'Send Mail',
                  style: kButtonStil,
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  overlayColor: MaterialStateProperty.all(
                      Colors.blue[800]!.withOpacity(0.5)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
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
