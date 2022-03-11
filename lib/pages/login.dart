import 'package:flutter/material.dart';
import 'package:progressive_overload/constants.dart';
import 'package:progressive_overload/pages/loading_page.dart';
import 'package:progressive_overload/pages/navigation_page.dart';
import 'package:progressive_overload/pages/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:progressive_overload/pages/reset_password.dart';
import 'package:progressive_overload/services/auth.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isObscure = true;

  bool loading = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
        return loading
        ? LoadingPage()
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text('Login', style: kBaslikStil),
              centerTitle: true,
              elevation: 0.0,
              backgroundColor: Colors.transparent,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 200,
                        width: 400,
                        child: Image(image: AssetImage('assets/muscle.jpg')),
                      ),
                      Positioned(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            'Progressive Overload',
                            style: kBaslikStil,
                          ),
                        ),
                      ),
                      Positioned(
                          top: 30,
                          left: 100,
                          child: Text(
                            'To Make You Build Muscle',
                            style: kMiniStil,
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Container(
                      height: 300,
                      width: 400,
                      decoration: BoxDecoration(
                          color: Colors.blue[800]!.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(21)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
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
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: _passwordController,
                              obscureText: _isObscure,
                              cursorColor: Colors.white,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                icon: Icon(
                                  Icons.vpn_key_outlined,
                                  color: Colors.white,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isObscure
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isObscure = !_isObscure;
                                    });
                                  },
                                ),
                                hintText: 'Password',
                                hintStyle: TextStyle(color: Colors.white),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 25,
                            width: 200,
                            child: Divider(
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    try {
                                      if (await _authService.signIn(
                                              _emailController.text,
                                              _passwordController.text) !=
                                          null) {
                                        setState(() {
                                          loading = true;
                                        });
                                        await _authService
                                            .signIn(_emailController.text,
                                                _passwordController.text)
                                            .then((value) =>
                                                Navigator.pushReplacementNamed(
                                                    context, '/home'));
                                      }
                                      else if(await _authService.signIn(
                                              _emailController.text,
                                              _passwordController.text) ==
                                          null){
                                            showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            backgroundColor: kBoxColor,
                                            title: Center(
                                              child: Text(
                                                'Cant Logged in!',
                                                style: kBaslikStil2,
                                              ),
                                            ),
                                            content: Text(
                                              'This Account Not Verified, Please Check Your Email!',
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
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(32.0))),
                                          );
                                        },
                                      );
                                          }
                                    } on FirebaseAuthException catch (e) {
                                      return showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            backgroundColor: kBoxColor,
                                            title: Center(
                                              child: Text(
                                                'Cant Logged in!',
                                                style: kBaslikStil2,
                                              ),
                                            ),
                                            content: Text(
                                              'Email or Password is wrong!',
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
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(32.0))),
                                          );
                                        },
                                      );
                                    }
                                  },
                                  child: Text(
                                    'Sign In',
                                    style: kButtonStil,
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                    overlayColor: MaterialStateProperty.all(
                                        Colors.blue[800]!.withOpacity(0.5)),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Register()));
                                },
                                child: Text(
                                  'Sign Up',
                                  style: kButtonStil,
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  overlayColor: MaterialStateProperty.all(
                                      Colors.blue[800]!.withOpacity(0.5)),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>RePassword()));
                            },
                            child: Text('Forget Password?'))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
