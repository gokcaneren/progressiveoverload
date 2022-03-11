import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:progressive_overload/constants.dart';
import 'package:progressive_overload/services/theme_data.dart';
import 'package:provider/provider.dart';




class LoadingPage extends StatefulWidget {
  const LoadingPage({ Key? key }) : super(key: key);

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Provider.of<ThemeColorData>(context).isDark ? Colors.grey[900]! : Colors.white,
      body: Center(
        child: SpinKitFadingCube(
          color: kBoxColor,
          size: 150,
          ),
      ),
    );
  }
}