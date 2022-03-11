import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:progressive_overload/constants.dart';
import 'package:progressive_overload/services/theme_data.dart';
import 'package:provider/provider.dart';

class Person extends StatefulWidget {
  const Person({Key? key}) : super(key: key);

  @override
  _PersonState createState() => _PersonState();
}

class _PersonState extends State<Person> {

  String result='0';
  double bmi=24.3;
  final _firestore = FirebaseFirestore.instance;
  String _userName='';

  
  @override
  Widget build(BuildContext context) {
    CollectionReference personRef = _firestore.collection('Person');
    var personInfo=_firestore.collection('Person').doc(FirebaseAuth.instance.currentUser!.uid);

    return StreamBuilder<DocumentSnapshot>(
      stream: personInfo.snapshots(),
      builder: (context, snapshot) {

        if(snapshot.data != null){
          
          _userName=snapshot.data!.get('userName');

          bmi=snapshot.data?.get('weight').toDouble()/(snapshot.data?.get('height').toDouble() * snapshot.data?.get('height')).toDouble();
          
          if(bmi<=19.5)
          {
              result='Bmi: ${bmi.toStringAsFixed(2)} Under Weight';
          }
          else if(bmi>19.5 && bmi<=27.9)
          {
              result='Bmi: ${bmi.toStringAsFixed(2)} Normal Weight';
          } 
          else if(bmi>27.9 && bmi<=33.9)
          {
              result='Bmi: ${bmi.toStringAsFixed(2)} Over Weight';
          }
          else
          {
              result='Bmi: ${bmi.toStringAsFixed(2)} Obese';
          } 
        }

       


        return  SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 200,
                      width: 400,
                        child: ColorFiltered(
                          colorFilter: ColorFilter.mode(Provider.of<ThemeColorData>(context).isDark ? Colors.grey[900]! : Colors.transparent, BlendMode.color),
                          child: Image.asset('assets/muscle11.png')
                        ),
                    ),
                    Positioned(
                        top: 150,
                        left: 85,
                        child: Text(
                          'To Make You Build Muscle',
                          style: Provider.of<ThemeColorData>(context).isDark ? kMiniStil2 : kMiniStil
                        )),
                  ],
                ),
                Center(
                  child: Container(
                    height: 290,
                    width: 400,
                    decoration: BoxDecoration(
                        color: Colors.blue[800]!.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(21)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 15,),
                          SizedBox(
                            width: 335,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)
                              ),
                              child: ListTile(
                                minLeadingWidth:0,
                                leading: Icon(Icons.person),
                                iconColor: kIconColor,
                                title: Text('Username: ${_userName}',
                                style: kKartStil,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 335,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)
                              ),
                              child: ListTile(
                                minLeadingWidth:0,
                                leading: Icon(Icons.accessibility),
                                iconColor: kIconColor,
                                title: Text('Height:${snapshot.data?.get('height').toDouble()} m Weight: ${snapshot.data?.get('weight').toDouble().round()} kg',
                                style: kKartStil,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 335,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)
                              ),
                              child: ListTile(
                                minLeadingWidth:0,
                                leading: Icon(Icons.directions_run),
                                iconColor: kIconColor,
                                title: Text(result,
                                style: kKartStil,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: SizedBox(
                              height: 40,
                              width: 120,
                              child: ElevatedButton(
                                onPressed: ()async{
                                  await FirebaseAuth.instance.signOut();
                                  Navigator.pushReplacementNamed(context, '/');
                                }, 
                                child: Text('Sign Out',
                                style: kKartStil,
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
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
      }
    );
  }
}
