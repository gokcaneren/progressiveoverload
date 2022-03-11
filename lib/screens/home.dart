import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:progressive_overload/constants.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double _kBoxWidth = 300;
  double _kBoxHeight = 400;

  final TextEditingController _benchKg = TextEditingController();
  final TextEditingController _benchGoal = TextEditingController();

  final TextEditingController _bbPressKg = TextEditingController();
  final TextEditingController _bbPressGoal = TextEditingController();

  final TextEditingController _bbRowKg = TextEditingController();
  final TextEditingController _bbRowGoal = TextEditingController();

  final TextEditingController _squatKg = TextEditingController();
  final TextEditingController _squatGoal = TextEditingController();

  final TextEditingController _deadliftKg = TextEditingController();
  final TextEditingController _deadliftGoal = TextEditingController();

  double benchKg = 160;
  double benchGoal = 180;

  double barbellPressKg = 150;
  double barbellPressGoal = 120;

  double deadliftKg = 220;
  double deadliftGoal = 250;

  double barbellRowKg = 120;
  double barbellRowGoal = 140;

  double squatKg = 240;
  double squatGoal = 270;

  double valueBench = 0;
  double textValueBench = 0;

  double valueBbPress = 0;
  double textValueBbPress = 0;

  double valueDeadlift = 0;
  double textValueDeadlift = 0;

  double valueBbRow = 0;
  double textValueBbRow = 0;

  double valueSquat = 0;
  double textValueSquat = 0;

  String level = 'ADVANCED';
  TextStyle levelStil = kNoviceStil;
  String levelBbPress = 'ADVANCED';
  TextStyle levelStilBbPress = kNoviceStil;
  String levelDeadlift = 'ADVANCED';
  TextStyle levelStilDeadlift = kNoviceStil;
  String levelBbRow = 'ADVANCED';
  TextStyle levelStilBbRow = kNoviceStil;
  String levelSquat = 'ADVANCED';
  TextStyle levelStilSquat = kNoviceStil;

  final _firestore = FirebaseFirestore.instance;

  void _onChangedBench() async {
    var firebaseUser = FirebaseAuth.instance.currentUser;

    await _firestore.collection("Person").doc(firebaseUser!.uid).update({
      'bench': double.parse(_benchKg.text).round(),
    });
  }

  void _onChangedBbPress() async {
    var firebaseUser = FirebaseAuth.instance.currentUser;

    await _firestore.collection("Person").doc(firebaseUser!.uid).update({
      'bbPress': double.parse(_bbPressKg.text).round(),
    });
  }

  void _onChangedDeadlift() async {
    var firebaseUser = FirebaseAuth.instance.currentUser;

    await _firestore.collection("Person").doc(firebaseUser!.uid).update({
      'deadlift': double.parse(_deadliftKg.text).round(),
    });
  }

  void _onChangedBbRow() async {
    var firebaseUser = FirebaseAuth.instance.currentUser;

    await _firestore.collection("Person").doc(firebaseUser!.uid).update({
      'bbRow': double.parse(_bbRowKg.text).round(),
    });
  }

  void _onChangedSquat() async {
    var firebaseUser = FirebaseAuth.instance.currentUser;

    await _firestore.collection("Person").doc(firebaseUser!.uid).update({
      'squat': double.parse(_squatKg.text).round(),
    });
  }

  void _onBenchGoal() async {
    var firebaseUser = FirebaseAuth.instance.currentUser;

    await _firestore.collection("Person").doc(firebaseUser!.uid).update({
      'benchGoal': double.parse(_benchGoal.text).round(),
    });
  }

  void _onBbPressGoal() async {
    var firebaseUser = FirebaseAuth.instance.currentUser;

    await _firestore.collection("Person").doc(firebaseUser!.uid).update({
      'bbPressGoal': double.parse(_bbPressGoal.text).round(),
    });
  }

  void _onDeadliftGoal() async {
    var firebaseUser = FirebaseAuth.instance.currentUser;

    await _firestore.collection("Person").doc(firebaseUser!.uid).update({
      'deadliftGoal': double.parse(_deadliftGoal.text).round(),
    });
  }

  void _onBbRowGoal() async {
    var firebaseUser = FirebaseAuth.instance.currentUser;

    await _firestore.collection("Person").doc(firebaseUser!.uid).update({
      'bbRowGoal': double.parse(_bbRowGoal.text).round(),
    });
  }

  void _onSquatGoal() async {
    var firebaseUser = FirebaseAuth.instance.currentUser;

    await _firestore.collection("Person").doc(firebaseUser!.uid).update({
      'squatGoal': double.parse(_squatGoal.text).round(),
    });
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference personRef = _firestore.collection('Person');
    var weigthsRef = _firestore
        .collection("Person")
        .doc(FirebaseAuth.instance.currentUser!.uid);

    return StreamBuilder<DocumentSnapshot>(
        stream: weigthsRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            if (snapshot.data!.get('bench') < snapshot.data!.get('benchGoal')) {
              valueBench = ((snapshot.data?.get('bench') /
                          snapshot.data?.get('benchGoal') *
                          100 /
                          100))
                      .toDouble() ??
                  0;
              textValueBench = ((snapshot.data?.get('bench') /
                          snapshot.data?.get('benchGoal') *
                          100)
                      .toDouble()) ??
                  0;
            } else {
              valueBench = 0;
              textValueBench = 0;
            }

            if (snapshot.data!.get('bbPress') <
                snapshot.data!.get('bbPressGoal')) {
              valueBbPress = ((snapshot.data?.get('bbPress') /
                          snapshot.data?.get('bbPressGoal') *
                          100 /
                          100))
                      .toDouble() ??
                  0;
              textValueBbPress = ((snapshot.data?.get('bbPress') /
                          snapshot.data?.get('bbPressGoal') *
                          100)
                      .toDouble()) ??
                  0;
            } else {
              valueBbPress = 0;
              textValueBbPress = 0;
            }

            if (snapshot.data!.get('deadlift') <
                snapshot.data!.get('deadliftGoal')) {
              valueDeadlift = ((snapshot.data?.get('deadlift') /
                          snapshot.data?.get('deadliftGoal') *
                          100 /
                          100))
                      .toDouble() ??
                  0;
              textValueDeadlift = ((snapshot.data?.get('deadlift') /
                          snapshot.data?.get('deadliftGoal') *
                          100)
                      .toDouble()) ??
                  0;
            } else {
              valueDeadlift = 0;
              textValueDeadlift = 0;
            }

            if (snapshot.data!.get('bbRow') < snapshot.data!.get('bbRowGoal')) {
              valueBbRow = ((snapshot.data?.get('bbRow') /
                          snapshot.data?.get('bbRowGoal') *
                          100 /
                          100))
                      .toDouble() ??
                  0;
              textValueBbRow = ((snapshot.data?.get('bbRow') /
                          snapshot.data?.get('bbRowGoal') *
                          100)
                      .toDouble()) ??
                  0;
            } else {
              valueBbRow = 0;
              textValueBbRow = 0;
            }

            if (snapshot.data!.get('squat') < snapshot.data!.get('squatGoal')) {
              valueSquat = ((snapshot.data?.get('squat') /
                          snapshot.data?.get('squatGoal') *
                          100 /
                          100))
                      .toDouble() ??
                  0;
              textValueSquat = ((snapshot.data?.get('squat') /
                          snapshot.data?.get('squatGoal') *
                          100)
                      .toDouble()) ??
                  0;
            } else {
              valueSquat = 0;
              textValueSquat = 0;
            }
          }
          if (snapshot.data != null) {
            if (snapshot.data!.get('bench').toDouble() <= 50) {
              level = novice.data.toString();
              levelStil = kNoviceStil;
            } else if (snapshot.data!.get('bench').toDouble() > 50 &&
                snapshot.data!.get('bench').toDouble() <= 80) {
              level = intermediate.data.toString();
              levelStil = kIntermediateStil;
            } else if (snapshot.data!.get('bench').toDouble() > 80 &&
                snapshot.data!.get('bench').toDouble() <= 100) {
              level = proficient.data.toString();
              levelStil = kProficientStil;
            } else if (snapshot.data!.get('bench').toDouble() > 100 &&
                snapshot.data!.get('bench').toDouble() <= 130) {
              level = advanced.data.toString();
              levelStil = kAdvancedStil;
            } else if (snapshot.data!.get('bench').toDouble() > 130 &&
                snapshot.data!.get('bench').toDouble() <= 160) {
              level = elite.data.toString();
              levelStil = kEliteStil;
            } else if (snapshot.data!.get('bench').toDouble() > 160) {
              level = worldClass.data.toString();
              levelStil = kWorldClassStil;
            }

            if (snapshot.data!.get('bbPress').toDouble() <= 30) {
              levelBbPress = novice.data.toString();
              levelStilBbPress = kNoviceStil;
            } else if (snapshot.data!.get('bbPress').toDouble() > 30 &&
                snapshot.data!.get('bbPress').toDouble() <= 50) {
              levelBbPress = intermediate.data.toString();
              levelStilBbPress = kIntermediateStil;
            } else if (snapshot.data!.get('bbPress').toDouble() > 50 &&
                snapshot.data!.get('bbPress').toDouble() <= 70) {
              levelBbPress = proficient.data.toString();
              levelStilBbPress = kProficientStil;
            } else if (snapshot.data!.get('bbPress').toDouble() > 70 &&
                snapshot.data!.get('bbPress').toDouble() <= 100) {
              levelBbPress = advanced.data.toString();
              levelStilBbPress = kAdvancedStil;
            } else if (snapshot.data!.get('bbPress').toDouble() > 100 &&
                snapshot.data!.get('bbPress').toDouble() <= 130) {
              levelBbPress = elite.data.toString();
              levelStilBbPress = kEliteStil;
            } else if (snapshot.data!.get('bbPress').toDouble() > 130) {
              levelBbPress = worldClass.data.toString();
              levelStilBbPress = kWorldClassStil;
            }

            if (snapshot.data!.get('bbRow').toDouble() <= 40) {
              levelBbRow = novice.data.toString();
              levelStilBbRow = kNoviceStil;
            } else if (snapshot.data!.get('bbRow').toDouble() > 40 &&
                snapshot.data!.get('bbRow').toDouble() <= 60) {
              levelBbRow = intermediate.data.toString();
              levelStilBbRow = kIntermediateStil;
            } else if (snapshot.data!.get('bbRow').toDouble() > 60 &&
                snapshot.data!.get('bbRow').toDouble() <= 80) {
              levelBbRow = proficient.data.toString();
              levelStilBbRow = kProficientStil;
            } else if (snapshot.data!.get('bbRow').toDouble() > 80 &&
                snapshot.data!.get('bbRow').toDouble() <= 110) {
              levelBbRow = advanced.data.toString();
              levelStilBbRow = kAdvancedStil;
            } else if (snapshot.data!.get('bbRow').toDouble() > 110 &&
                snapshot.data!.get('bbRow').toDouble() <= 140) {
              levelBbRow = elite.data.toString();
              levelStilBbRow = kEliteStil;
            } else if (snapshot.data!.get('bbRow').toDouble() > 140) {
              levelBbRow = worldClass.data.toString();
              levelStilBbRow = kWorldClassStil;
            }

            if (snapshot.data!.get('deadlift').toDouble() <= 60) {
              levelDeadlift = novice.data.toString();
              levelStilDeadlift = kNoviceStil;
            } else if (snapshot.data!.get('deadlift').toDouble() > 60 &&
                snapshot.data!.get('deadlift').toDouble() <= 100) {
              levelDeadlift = intermediate.data.toString();
              levelStilDeadlift = kIntermediateStil;
            } else if (snapshot.data!.get('deadlift').toDouble() > 100 &&
                snapshot.data!.get('deadlift').toDouble() <= 140) {
              levelDeadlift = proficient.data.toString();
              levelStilDeadlift = kProficientStil;
            } else if (snapshot.data!.get('deadlift').toDouble() > 140 &&
                snapshot.data!.get('deadlift').toDouble() <= 190) {
              levelDeadlift = advanced.data.toString();
              levelStilDeadlift = kAdvancedStil;
            } else if (snapshot.data!.get('deadlift').toDouble() > 190 &&
                snapshot.data!.get('deadlift').toDouble() <= 240) {
              levelDeadlift = elite.data.toString();
              levelStilDeadlift = kEliteStil;
            } else if (snapshot.data!.get('deadlift').toDouble() > 240) {
              levelDeadlift = worldClass.data.toString();
              levelStilDeadlift = kWorldClassStil;
            }

            if (snapshot.data!.get('squat').toDouble() <= 60) {
              levelSquat = novice.data.toString();
              levelStilSquat = kNoviceStil;
            } else if (snapshot.data!.get('squat').toDouble() > 60 &&
                snapshot.data!.get('squat').toDouble() <= 100) {
              levelSquat = intermediate.data.toString();
              levelStilSquat = kIntermediateStil;
            } else if (snapshot.data!.get('squat').toDouble() > 100 &&
                snapshot.data!.get('squat').toDouble() <= 150) {
              levelSquat = proficient.data.toString();
              levelStilSquat = kProficientStil;
            } else if (snapshot.data!.get('squat').toDouble() > 150 &&
                snapshot.data!.get('squat').toDouble() <= 200) {
              levelSquat = advanced.data.toString();
              levelStilSquat = kAdvancedStil;
            } else if (snapshot.data!.get('squat').toDouble() > 200 &&
                snapshot.data!.get('squat').toDouble() <= 250) {
              levelSquat = elite.data.toString();
              levelStilSquat = kEliteStil;
            } else if (snapshot.data!.get('squat').toDouble() > 250) {
              levelSquat = worldClass.data.toString();
              levelStilSquat = kWorldClassStil;
            }
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    //chest==========
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: _kBoxWidth,
                        height: _kBoxHeight,
                        child: FlipCard(
                          direction: FlipDirection.HORIZONTAL,
                          front: Stack(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: kBoxColor),
                              ),
                              Positioned(
                                left: 10,
                                top: 10,
                                child: ClipOval(
                                  child: Image(
                                    image: AssetImage('assets/chest.jpg'),
                                    width: 100,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 115,
                                top: 45,
                                child: Text(
                                  'BENCH PRESS',
                                  style: kBaslikStil2,
                                ),
                              ),
                              Positioned(
                                left: 140,
                                top: 75,
                                child: Text(
                                  'Main Exercise',
                                  style: kMiniStil2,
                                ),
                              ),
                              Positioned(
                                top: 250,
                                left: 110,
                                child: CircularPercentIndicator(
                                  animation: true,
                                  animationDuration: 1000,
                                  radius: 45,
                                  lineWidth: 10,
                                  percent:
                                      valueBench, //((benchKg/benchGoal)*100/100).toDouble(),
                                  progressColor: Colors.deepPurple,
                                  backgroundColor: Colors.deepPurple.shade100,
                                  circularStrokeCap: CircularStrokeCap.round,
                                  center: Text(
                                    "%${textValueBench.round()}",
                                    style: kBaslikStil2,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 138,
                                left: 55,
                                child: SizedBox(
                                  width: 200,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      '${level}',
                                      style: levelStil,
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: Card(
                                  child: ListTile(
                                    minLeadingWidth: 0,
                                    leading: Icon(
                                      Icons.trending_up,
                                      color: Colors.deepPurple,
                                      size: 27,
                                    ),
                                    title: Text(
                                      'Your Best is ${snapshot.data?.get('bench')} KG',
                                      style: kKartStil,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 350,
                                left: 110,
                                child: Text(
                                  'STATUS',
                                  style: kBaslikStil2,
                                ),
                              ),
                            ],
                          ),
                          back: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: kBoxColor),
                              ),
                              Positioned(
                                left: 10,
                                top: 10,
                                child: ClipOval(
                                  child: Image(
                                    image: AssetImage('assets/chest.jpg'),
                                    width: 100,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 115,
                                top: 45,
                                child: Text(
                                  'BENCH PRESS',
                                  style: kBaslikStil2,
                                ),
                              ),
                              Positioned(
                                left: 140,
                                top: 75,
                                child: Text(
                                  'Main Exercise',
                                  style: kMiniStil2,
                                ),
                              ),
                              Positioned(
                                left: 23,
                                top: 140,
                                child: Text(
                                  'New Bench Press Kg',
                                  style: kBaslikStil2,
                                ),
                              ),
                              Positioned(
                                left: 40,
                                top: 165,
                                child: SizedBox(
                                  width: 200,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    controller: _benchKg,
                                    cursorColor: Colors.white,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    decoration: InputDecoration(
                                      icon: Icon(
                                        Icons.trending_up,
                                        color: Colors.white,
                                      ),
                                      hintText: 'New kg',
                                      hintStyle: TextStyle(color: Colors.white),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 115,
                                top: 220,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (_benchKg.text != "") {
                                      setState(() {
                                        _onChangedBench();
                                      });
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor: kBoxColor,
                                          title: Center(
                                            child: Text(
                                              'SAVED!',
                                              style: kBaslikStil2,
                                            ),
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
                                  }else{
                                    FocusScope.of(context).requestFocus(FocusNode());
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor: kBoxColor,
                                          title: Center(
                                            child: Text(
                                              'NOT SAVED!',
                                              style: kBaslikStil2,
                                            ),
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
                                    'Save',
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
                              Positioned(
                                left: 20,
                                top: 270,
                                child: Text(
                                  'New Bench Press Goal',
                                  style: kBaslikStil2,
                                ),
                              ),
                              Positioned(
                                left: 40,
                                top: 295,
                                child: SizedBox(
                                  width: 200,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    controller: _benchGoal,
                                    cursorColor: Colors.white,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    decoration: InputDecoration(
                                      icon: Icon(
                                        Icons.flash_on,
                                        color: Colors.white,
                                      ),
                                      hintText: 'New Goal kg',
                                      hintStyle: TextStyle(color: Colors.white),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 115,
                                top: 350,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if(_benchGoal.text != ""){
                                    setState(() {
                                      _onBenchGoal();
                                    });
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                        showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor: kBoxColor,
                                          title: Center(
                                            child: Text(
                                              'SAVED!',
                                              style: kBaslikStil2,
                                            ),
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
                                    }else{
                                      FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                      showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor: kBoxColor,
                                          title: Center(
                                            child: Text(
                                              'NOT SAVED!',
                                              style: kBaslikStil2,
                                            ),
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
                                    'Save',
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
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      //shoulder==========
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: _kBoxWidth,
                        height: _kBoxHeight,
                        child: FlipCard(
                          direction: FlipDirection.HORIZONTAL,
                          front: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: kBoxColor),
                              ),
                              Positioned(
                                left: 10,
                                top: 10,
                                child: ClipOval(
                                  child: Image(
                                    image: AssetImage(
                                        'assets/shoulder_muscles.jpg'),
                                    width: 100,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 115,
                                top: 45,
                                child: Text(
                                  'BARBELL PRESS',
                                  style: kBaslikStil3,
                                ),
                              ),
                              Positioned(
                                left: 140,
                                top: 75,
                                child: Text(
                                  'Main Exercise',
                                  style: kMiniStil2,
                                ),
                              ),
                              Positioned(
                                top: 250,
                                left: 110,
                                child: CircularPercentIndicator(
                                  animation: true,
                                  animationDuration: 1000,
                                  radius: 45,
                                  lineWidth: 10,
                                  percent: valueBbPress,
                                  progressColor: Colors.deepPurple,
                                  backgroundColor: Colors.deepPurple.shade100,
                                  circularStrokeCap: CircularStrokeCap.round,
                                  center: Text(
                                    "%${textValueBbPress.round()}",
                                    style: kBaslikStil2,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 138,
                                left: 55,
                                child: SizedBox(
                                  width: 200,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      '$levelBbPress',
                                      style: levelStilBbPress,
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: Card(
                                  child: ListTile(
                                    minLeadingWidth: 0,
                                    leading: Icon(
                                      Icons.trending_up,
                                      color: Colors.deepPurple,
                                      size: 27,
                                    ),
                                    title: Text(
                                      "Your Best is ${snapshot.data?.get('bbPress')} KG",
                                      style: kKartStil,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 350,
                                left: 110,
                                child: Text(
                                  'STATUS',
                                  style: kBaslikStil2,
                                ),
                              ),
                            ],
                          ),
                          back: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: kBoxColor),
                              ),
                              Positioned(
                                left: 10,
                                top: 10,
                                child: ClipOval(
                                  child: Image(
                                    image: AssetImage(
                                        'assets/shoulder_muscles.jpg'),
                                    width: 100,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 115,
                                top: 45,
                                child: Text(
                                  'BARBELL PRESS',
                                  style: kBaslikStil3,
                                ),
                              ),
                              Positioned(
                                left: 140,
                                top: 75,
                                child: Text(
                                  'Main Exercise',
                                  style: kMiniStil2,
                                ),
                              ),
                              Positioned(
                                left: 23,
                                top: 140,
                                child: Text(
                                  'New Barbell Press Kg',
                                  style: kBaslikStil2,
                                ),
                              ),
                              Positioned(
                                left: 40,
                                top: 165,
                                child: SizedBox(
                                  width: 200,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    controller: _bbPressKg,
                                    cursorColor: Colors.white,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    decoration: InputDecoration(
                                      icon: Icon(
                                        Icons.trending_up,
                                        color: Colors.white,
                                      ),
                                      hintText: 'New kg',
                                      hintStyle: TextStyle(color: Colors.white),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 115,
                                top: 220,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if(_bbPressKg.text != ""){
                                    setState(() {
                                      _onChangedBbPress();
                                    });
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                        showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor: kBoxColor,
                                          title: Center(
                                            child: Text(
                                              'SAVED!',
                                              style: kBaslikStil2,
                                            ),
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
                                    }else{
                                      FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                      showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor: kBoxColor,
                                          title: Center(
                                            child: Text(
                                              'NOT SAVED!',
                                              style: kBaslikStil2,
                                            ),
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
                                    'Save',
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
                              Positioned(
                                left: 11,
                                top: 270,
                                child: Text(
                                  'New Barbell Press Goal',
                                  style: kBaslikStil2,
                                ),
                              ),
                              Positioned(
                                left: 40,
                                top: 295,
                                child: SizedBox(
                                  width: 200,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    controller: _bbPressGoal,
                                    cursorColor: Colors.white,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    decoration: InputDecoration(
                                      icon: Icon(
                                        Icons.flash_on,
                                        color: Colors.white,
                                      ),
                                      hintText: 'New Goal kg',
                                      hintStyle: TextStyle(color: Colors.white),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 115,
                                top: 350,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if(_bbPressGoal.text !=""){
                                    setState(() {
                                      _onBbPressGoal();
                                    });
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                        showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor: kBoxColor,
                                          title: Center(
                                            child: Text(
                                              'SAVED!',
                                              style: kBaslikStil2,
                                            ),
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
                                    }else{
                                      FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                      showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor: kBoxColor,
                                          title: Center(
                                            child: Text(
                                              'NOT SAVED!',
                                              style: kBaslikStil2,
                                            ),
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
                                    'Save',
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
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      //Deadlift========
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: _kBoxWidth,
                        height: _kBoxHeight,
                        child: FlipCard(
                          direction: FlipDirection.HORIZONTAL,
                          front: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: kBoxColor),
                              ),
                              Positioned(
                                left: 10,
                                top: 10,
                                child: ClipOval(
                                  child: Image(
                                    image: AssetImage('assets/deadlift.jpg'),
                                    width: 125,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 140,
                                top: 45,
                                child: Text(
                                  'DEADLIFT',
                                  style: kBaslikStil2,
                                ),
                              ),
                              Positioned(
                                left: 140,
                                top: 75,
                                child: Text(
                                  'Main Exercise',
                                  style: kMiniStil2,
                                ),
                              ),
                              Positioned(
                                top: 250,
                                left: 110,
                                child: CircularPercentIndicator(
                                  animation: true,
                                  animationDuration: 1000,
                                  radius: 45,
                                  lineWidth: 10,
                                  percent: valueDeadlift,
                                  progressColor: Colors.deepPurple,
                                  backgroundColor: Colors.deepPurple.shade100,
                                  circularStrokeCap: CircularStrokeCap.round,
                                  center: Text(
                                    "%${textValueDeadlift.round()}",
                                    style: kBaslikStil2,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 138,
                                left: 55,
                                child: SizedBox(
                                  width: 200,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      '$levelDeadlift',
                                      style: levelStilDeadlift,
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: Card(
                                  child: ListTile(
                                    minLeadingWidth: 0,
                                    leading: Icon(
                                      Icons.trending_up,
                                      color: Colors.deepPurple,
                                      size: 27,
                                    ),
                                    title: Text(
                                      "Your Best is ${snapshot.data?.get('deadlift')} KG",
                                      style: kKartStil,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 350,
                                left: 110,
                                child: Text(
                                  'STATUS',
                                  style: kBaslikStil2,
                                ),
                              ),
                            ],
                          ),
                          back: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: kBoxColor),
                              ),
                              Positioned(
                                left: 10,
                                top: 10,
                                child: ClipOval(
                                  child: Image(
                                    image: AssetImage('assets/deadlift.jpg'),
                                    width: 125,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 140,
                                top: 45,
                                child: Text(
                                  'DEADLIFT',
                                  style: kBaslikStil2,
                                ),
                              ),
                              Positioned(
                                left: 140,
                                top: 75,
                                child: Text(
                                  'Main Exercise',
                                  style: kMiniStil2,
                                ),
                              ),
                              Positioned(
                                left: 55,
                                top: 140,
                                child: Text(
                                  'New Deadlift Kg',
                                  style: kBaslikStil2,
                                ),
                              ),
                              Positioned(
                                left: 40,
                                top: 165,
                                child: SizedBox(
                                  width: 200,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    controller: _deadliftKg,
                                    cursorColor: Colors.white,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    decoration: InputDecoration(
                                      icon: Icon(
                                        Icons.trending_up,
                                        color: Colors.white,
                                      ),
                                      hintText: 'New kg',
                                      hintStyle: TextStyle(color: Colors.white),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 115,
                                top: 220,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if(_deadliftKg.text !=""){
                                    setState(() {
                                      _onChangedDeadlift();
                                    });
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                        showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor: kBoxColor,
                                          title: Center(
                                            child: Text(
                                              'SAVED!',
                                              style: kBaslikStil2,
                                            ),
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
                                    }else{
                                      FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                      showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor: kBoxColor,
                                          title: Center(
                                            child: Text(
                                              'NOT SAVED!',
                                              style: kBaslikStil2,
                                            ),
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
                                    'Save',
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
                              Positioned(
                                left: 40,
                                top: 270,
                                child: Text(
                                  'New Deadlift Goal',
                                  style: kBaslikStil2,
                                ),
                              ),
                              Positioned(
                                left: 40,
                                top: 295,
                                child: SizedBox(
                                  width: 200,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    controller: _deadliftGoal,
                                    cursorColor: Colors.white,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    decoration: InputDecoration(
                                      icon: Icon(
                                        Icons.flash_on,
                                        color: Colors.white,
                                      ),
                                      hintText: 'New Goal kg',
                                      hintStyle: TextStyle(color: Colors.white),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 115,
                                top: 350,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if(_deadliftGoal.text !=""){
                                    setState(() {
                                      _onDeadliftGoal();
                                    });
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                        showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor: kBoxColor,
                                          title: Center(
                                            child: Text(
                                              'SAVED!',
                                              style: kBaslikStil2,
                                            ),
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
                                    }else{
                                      FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                      showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor: kBoxColor,
                                          title: Center(
                                            child: Text(
                                              ' NOT SAVED!',
                                              style: kBaslikStil2,
                                            ),
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
                                    'Save',
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
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      //Barbell Row==============
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: _kBoxWidth,
                        height: _kBoxHeight,
                        child: FlipCard(
                          direction: FlipDirection.HORIZONTAL,
                          front: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: kBoxColor),
                              ),
                              Positioned(
                                left: 10,
                                top: 10,
                                child: ClipOval(
                                  child: Image(
                                    image:
                                        AssetImage('assets/back_muscles.jpg'),
                                    width: 100,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 115,
                                top: 45,
                                child: Text(
                                  'BARBELL ROW',
                                  style: kBaslikStil2,
                                ),
                              ),
                              Positioned(
                                left: 140,
                                top: 75,
                                child: Text(
                                  'Main Exercise',
                                  style: kMiniStil2,
                                ),
                              ),
                              Positioned(
                                top: 250,
                                left: 110,
                                child: CircularPercentIndicator(
                                  animation: true,
                                  animationDuration: 1000,
                                  radius: 45,
                                  lineWidth: 10,
                                  percent: valueBbRow,
                                  progressColor: Colors.deepPurple,
                                  backgroundColor: Colors.deepPurple.shade100,
                                  circularStrokeCap: CircularStrokeCap.round,
                                  center: Text(
                                    "%${textValueBbRow.round()}",
                                    style: kBaslikStil2,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 138,
                                left: 55,
                                child: SizedBox(
                                  width: 200,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      '$levelBbRow',
                                      style: levelStilBbRow,
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: Card(
                                  child: ListTile(
                                    minLeadingWidth: 0,
                                    leading: Icon(
                                      Icons.trending_up,
                                      color: Colors.deepPurple,
                                      size: 27,
                                    ),
                                    title: Text(
                                      "Your Best is ${snapshot.data?.get('bbRow')} KG",
                                      style: kKartStil,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 350,
                                left: 110,
                                child: Text(
                                  'STATUS',
                                  style: kBaslikStil2,
                                ),
                              ),
                            ],
                          ),
                          back: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: kBoxColor),
                              ),
                              Positioned(
                                left: 10,
                                top: 10,
                                child: ClipOval(
                                  child: Image(
                                    image:
                                        AssetImage('assets/back_muscles.jpg'),
                                    width: 100,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 115,
                                top: 45,
                                child: Text(
                                  'BARBELL ROW',
                                  style: kBaslikStil2,
                                ),
                              ),
                              Positioned(
                                left: 140,
                                top: 75,
                                child: Text(
                                  'Main Exercise',
                                  style: kMiniStil2,
                                ),
                              ),
                              Positioned(
                                left: 23,
                                top: 140,
                                child: Text(
                                  'New Barbell Row Kg',
                                  style: kBaslikStil2,
                                ),
                              ),
                              Positioned(
                                left: 40,
                                top: 165,
                                child: SizedBox(
                                  width: 200,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    controller: _bbRowKg,
                                    cursorColor: Colors.white,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    decoration: InputDecoration(
                                      icon: Icon(
                                        Icons.trending_up,
                                        color: Colors.white,
                                      ),
                                      hintText: 'New kg',
                                      hintStyle: TextStyle(color: Colors.white),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 115,
                                top: 220,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if(_bbRowKg.text !=""){
                                    setState(() {
                                      _onChangedBbRow();
                                    });
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                        showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor: kBoxColor,
                                          title: Center(
                                            child: Text(
                                              'SAVED!',
                                              style: kBaslikStil2,
                                            ),
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
                                    }else{
                                      FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                      showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor: kBoxColor,
                                          title: Center(
                                            child: Text(
                                              'NOT SAVED!',
                                              style: kBaslikStil2,
                                            ),
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
                                    'Save',
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
                              Positioned(
                                left: 20,
                                top: 270,
                                child: Text(
                                  'New Barbell Row Goal',
                                  style: kBaslikStil2,
                                ),
                              ),
                              Positioned(
                                left: 40,
                                top: 295,
                                child: SizedBox(
                                  width: 200,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    controller: _bbRowGoal,
                                    cursorColor: Colors.white,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    decoration: InputDecoration(
                                      icon: Icon(
                                        Icons.flash_on,
                                        color: Colors.white,
                                      ),
                                      hintText: 'New Goal kg',
                                      hintStyle: TextStyle(color: Colors.white),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 115,
                                top: 350,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if(_bbRowGoal.text !=""){
                                    setState(() {
                                      _onBbRowGoal();
                                    });
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                        showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor: kBoxColor,
                                          title: Center(
                                            child: Text(
                                              'SAVED!',
                                              style: kBaslikStil2,
                                            ),
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
                                    }else{
                                      FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                      showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor: kBoxColor,
                                          title: Center(
                                            child: Text(
                                              'NOT SAVED!',
                                              style: kBaslikStil2,
                                            ),
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
                                    'Save',
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
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      //Squat ========================
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: _kBoxWidth,
                        height: _kBoxHeight,
                        child: FlipCard(
                          direction: FlipDirection.HORIZONTAL,
                          front: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: kBoxColor),
                              ),
                              Positioned(
                                left: 10,
                                top: 10,
                                child: ClipOval(
                                  child: Image(
                                    image: AssetImage('assets/squat.png'),
                                    width: 120,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 140,
                                top: 45,
                                child: Text(
                                  'SQUAT',
                                  style: kBaslikStil2,
                                ),
                              ),
                              Positioned(
                                left: 140,
                                top: 75,
                                child: Text(
                                  'Main Exercise',
                                  style: kMiniStil2,
                                ),
                              ),
                              Positioned(
                                top: 250,
                                left: 110,
                                child: CircularPercentIndicator(
                                  animation: true,
                                  animationDuration: 1000,
                                  radius: 45,
                                  lineWidth: 10,
                                  percent: valueSquat,
                                  progressColor: Colors.deepPurple,
                                  backgroundColor: Colors.deepPurple.shade100,
                                  circularStrokeCap: CircularStrokeCap.round,
                                  center: Text(
                                    "%${textValueSquat.round()}",
                                    style: kBaslikStil2,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 138,
                                left: 55,
                                child: SizedBox(
                                  width: 200,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      '$levelSquat',
                                      style: levelStilSquat,
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: Card(
                                  child: ListTile(
                                    minLeadingWidth: 0,
                                    leading: Icon(
                                      Icons.trending_up,
                                      color: Colors.deepPurple,
                                      size: 27,
                                    ),
                                    title: Text(
                                      "Your Best is ${snapshot.data?.get('squat')} KG",
                                      style: kKartStil,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 350,
                                left: 110,
                                child: Text(
                                  'STATUS',
                                  style: kBaslikStil2,
                                ),
                              ),
                            ],
                          ),
                          back: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: kBoxColor),
                              ),
                              Positioned(
                                left: 10,
                                top: 10,
                                child: ClipOval(
                                  child: Image(
                                    image: AssetImage('assets/squat.png'),
                                    width: 120,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 140,
                                top: 45,
                                child: Text(
                                  'SQUAT',
                                  style: kBaslikStil2,
                                ),
                              ),
                              Positioned(
                                left: 140,
                                top: 75,
                                child: Text(
                                  'Main Exercise',
                                  style: kMiniStil2,
                                ),
                              ),
                              Positioned(
                                left: 60,
                                top: 140,
                                child: Text(
                                  'New Squat Kg',
                                  style: kBaslikStil2,
                                ),
                              ),
                              Positioned(
                                left: 40,
                                top: 165,
                                child: SizedBox(
                                  width: 200,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    controller: _squatKg,
                                    cursorColor: Colors.white,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    decoration: InputDecoration(
                                      icon: Icon(
                                        Icons.trending_up,
                                        color: Colors.white,
                                      ),
                                      hintText: 'New kg',
                                      hintStyle: TextStyle(color: Colors.white),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 115,
                                top: 220,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if(_squatKg.text !=""){
                                    setState(() {
                                      _onChangedSquat();
                                    });
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                        showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor: kBoxColor,
                                          title: Center(
                                            child: Text(
                                              'SAVED!',
                                              style: kBaslikStil2,
                                            ),
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
                                    }else{
                                      FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                      showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor: kBoxColor,
                                          title: Center(
                                            child: Text(
                                              'NOT SAVED!',
                                              style: kBaslikStil2,
                                            ),
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
                                    'Save',
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
                              Positioned(
                                left: 50,
                                top: 270,
                                child: Text(
                                  'New Squat Goal',
                                  style: kBaslikStil2,
                                ),
                              ),
                              Positioned(
                                left: 40,
                                top: 295,
                                child: SizedBox(
                                  width: 200,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    controller: _squatGoal,
                                    cursorColor: Colors.white,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    decoration: InputDecoration(
                                      icon: Icon(
                                        Icons.flash_on,
                                        color: Colors.white,
                                      ),
                                      hintText: 'New Goal kg',
                                      hintStyle: TextStyle(color: Colors.white),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 115,
                                top: 350,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if(_squatGoal.text !=""){
                                    setState(() {
                                      _onSquatGoal();
                                    });
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                        showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor: kBoxColor,
                                          title: Center(
                                            child: Text(
                                              'SAVED!',
                                              style: kBaslikStil2,
                                            ),
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
                                    }else{
                                      FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                      showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor: kBoxColor,
                                          title: Center(
                                            child: Text(
                                              'NOT SAVED!',
                                              style: kBaslikStil2,
                                            ),
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
                                    'Save',
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
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
