import 'package:flutter/material.dart';
import 'package:progressive_overload/constants.dart';
import 'package:progressive_overload/pages/login.dart';
import 'package:progressive_overload/services/auth.dart';


class Register extends StatefulWidget {
  const Register({ Key? key }) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _isObscure=true;

  final TextEditingController _userNameController=TextEditingController();
  final TextEditingController _emailController=TextEditingController();
  final TextEditingController _passwordController=TextEditingController();
  final TextEditingController _passwordAgainController=TextEditingController();

  AuthService _authService=AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text('Sign Up',
        style: kBaslikStil
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(children: [
              Container(
                height: 200,
                width: 400,
                child: Image(image: AssetImage('assets/muscle.jpg')),
              ),
              Positioned(
                child: Align(alignment: Alignment.bottomCenter,
                  child: Text('Progressive Overload',
                  style: kBaslikStil,
                  ),
                ),
              ),
              Positioned(
                top: 30,
                left: 100,
                child: Text('To Make You Build Muscle',
                style: kMiniStil,
                )
                ),
            ],
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Container(
                height: 370,
                width: 400,
                decoration: BoxDecoration(color: Colors.blue[800]!.withOpacity(0.7),
                borderRadius: BorderRadius.circular(21)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _userNameController,
                        cursorColor: Colors.white,
                         style: TextStyle(
                                color: Colors.white,
                              ),
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          hintText: 'Username',
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
                              _isObscure ? Icons.visibility : Icons.visibility_off,
                              color: Colors.white,
                            ),
                            onPressed: (){
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            }, 
                            ),
                          hintText: 'Password',
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _passwordAgainController,
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
                              _isObscure ? Icons.visibility : Icons.visibility_off,
                              color: Colors.white,
                            ),
                            onPressed: (){
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                            ),
                          hintText: 'Password Again',
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
                     ElevatedButton(
                       onPressed: ()async{
                        if(_userNameController.text!=""){
                          if(_emailController.text.contains('@gmail.com') || _emailController.text.contains('@hotmail.com') || _emailController.text.contains('@windowslive.com') || _emailController.text.contains('@yahoo.com')){
                          if(_passwordController.text.length>5){         
                          if(_passwordController.text==_passwordAgainController.text){
                         await showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            backgroundColor: kBoxColor,
                                            title: Center(
                                              child: Text(
                                                'Verify Your Account!',
                                                style: kBaslikStil2,
                                              ),
                                            ),
                                            content: Text(
                                              'A Confirmation email has been sent to the your e-mail adress, Please check your e-mail!',
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
                                      FocusScope.of(context).requestFocus(FocusNode());
                         _authService.createPerson(_userNameController.text, _emailController.text, _passwordController.text).then((value) => 
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>Login())));
                       }else{
                         await showDialog(context: context, builder: (BuildContext context){
                           return AlertDialog(
                                            backgroundColor: kBoxColor,
                                            title: Center(
                                              child: Text(
                                                'Passwords Must Be Same!',
                                                style: kBaslikStil2,
                                              ),
                                            ),
                                            content: Text(
                                              'Passwords Are Not Same!',
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
                         });
                       }
                       }else{
                         await showDialog(context: context, builder: (BuildContext context){
                           return AlertDialog(
                                            backgroundColor: kBoxColor,
                                            title: Center(
                                              child: Text(
                                                'Password Error!',
                                                style: kBaslikStil2,
                                              ),
                                            ),
                                            content: Text(
                                              'Password Must Be At Least 6 Character!',
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
                         });
                       }}else{
                         await showDialog(context: context, builder: (BuildContext context){
                           return AlertDialog(
                                            backgroundColor: kBoxColor,
                                            title: Center(
                                              child: Text(
                                                'Email Error!',
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
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(32.0))),
                                          );
                         });
                       }}else{
                         await showDialog(context: context, builder: (BuildContext context){
                           return AlertDialog(
                                            backgroundColor: kBoxColor,
                                            title: Center(
                                              child: Text(
                                                'Username Error!',
                                                style: kBaslikStil2,
                                              ),
                                            ),
                                            content: Text(
                                              'Username Can`t Be Empty!',
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
                         });
                       }},
                     child: Text('Sign Up',
                     style: kButtonStil,
                     ),
                     style: ButtonStyle(
                       backgroundColor: MaterialStateProperty.all(Colors.white),
                       overlayColor: MaterialStateProperty.all(Colors.blue[800]!.withOpacity(0.5)),
                       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                         RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(10.0),
                         ),
                       ),
                     ),
                     ),
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Text('Already Have an Account?'))
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