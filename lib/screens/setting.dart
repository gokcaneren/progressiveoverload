import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:progressive_overload/constants.dart';
import 'package:progressive_overload/services/theme_data.dart';
import 'package:provider/provider.dart';


class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final TextEditingController _height = TextEditingController();
  final TextEditingController _weight = TextEditingController();

  final _firestore = FirebaseFirestore.instance;

  void _updateHeight() async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    await _firestore.collection("Person").doc(firebaseUser!.uid).update({
      'height': double.parse((_height.text)),
    });
  }

  void _updateWeight() async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    await _firestore
        .collection("Person")
        .doc(firebaseUser!.uid)
        .update({'weight': double.parse(_weight.text)});
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 300,
        width: 400,
        decoration: BoxDecoration(
            color: Colors.blue[800]!.withOpacity(0.7),
            borderRadius: BorderRadius.circular(21)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 320,
                child: TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
                  ],
                  controller: _height,
                  cursorColor: Colors.white,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.accessibility,
                      color: Colors.white,
                    ),
                    hintText: 'Heigh (1.80)m',
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
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 320,
                child: TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  controller: _weight,
                  cursorColor: Colors.white,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.pregnant_woman,
                      color: Colors.white,
                    ),
                    hintText: 'Weight kg',
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
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 120,
              child: ElevatedButton(
                onPressed: () async {
                  if (_height.text != "" && _weight.text != "") {
                    setState(() {
                      _updateHeight();
                      _updateWeight();
                    });
                    FocusScope.of(context).requestFocus(FocusNode());
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32.0))),
                        );
                      },
                    );
                  } else if (_height.text != "" && _weight.text == "") {
                    setState(() {
                      _updateHeight();
                    });
                    FocusScope.of(context).requestFocus(FocusNode());
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32.0))),
                        );
                      },
                    );
                  } else if (_height.text == "" && _weight.text != "") {
                    setState(() {
                      _updateWeight();
                    });
                    FocusScope.of(context).requestFocus(FocusNode());
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32.0))),
                        );
                      },
                    );
                  } else {
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32.0))),
                        );
                      },
                    );
                  }
                },
                child: Text(
                  'Save',
                  style: kKartStil,
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
            ),
            SizedBox(
              width: 250,
              child: SwitchListTile(
                title: Text('Dark Mode', style: kBaslikStil),
                onChanged: (_) {
                  Provider.of<ThemeColorData>(context, listen: false)
                      .toggleTheme();
                },
                value: Provider.of<ThemeColorData>(context).isDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
