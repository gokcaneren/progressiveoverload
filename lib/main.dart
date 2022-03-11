import 'package:flutter/material.dart';
import 'package:progressive_overload/pages/loading_page.dart';
import 'package:progressive_overload/pages/navigation_page.dart';
import 'package:progressive_overload/pages/login.dart';
import 'package:progressive_overload/pages/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:progressive_overload/pages/reset_password.dart';
import 'package:progressive_overload/services/theme_data.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider<ThemeColorData>(
      create: (BuildContext context) => ThemeColorData(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<ThemeColorData>(context, listen: false)
        .loadThemeFromSharePref();

    
        return MaterialApp(
          theme: Provider.of<ThemeColorData>(context).themeColor,
          initialRoute: "/",
          routes: {
            "/": (context) => Login(),
            "/home": (context) => NavigationPage(),
            "/sign_in": (context) => Register(),
            "/loading": (context) => LoadingPage(),
            "/repassword": (context) =>RePassword()
          },
          debugShowCheckedModeBanner: false,
        );
      }
    

  
}

