import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:progressive_overload/constants.dart';
import 'package:progressive_overload/screens/home.dart';
import 'package:progressive_overload/screens/person.dart';
import 'package:progressive_overload/screens/setting.dart';
import 'package:progressive_overload/services/theme_data.dart';
import 'package:provider/provider.dart';


class NavigationPage extends StatefulWidget {
  const NavigationPage({ Key? key }) : super(key: key);

  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {

  int index=1;

  final screens=[Home(), Person(), Settings()];


  final items= <Widget>[
    Icon(Icons.home, size: 30, color: Colors.white,),
    Icon(Icons.person, size:30,color: Colors.white,),
    Icon(Icons.settings, size:30,color: Colors.white,)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Provider.of<ThemeColorData>(context).isDark ? Colors.grey[900] : null,
      appBar: AppBar(
        title: Text('Progressive Overload',
        style: TextStyle(
          color: Provider.of<ThemeColorData>(context).isDark ? Colors.white : Colors.black
        ),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: screens[index],
      bottomNavigationBar: CurvedNavigationBar(
      items: items,
      index: index,
      onTap: (index)=>setState(()=>this.index=index ) ,
      height: 55,
      color: Colors.blue[800]!.withOpacity(0.7),
      backgroundColor: Colors.transparent,
      ),
    );
  }
}