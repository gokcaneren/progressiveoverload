import 'package:flutter/material.dart';
import 'package:progressive_overload/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';




ThemeData darkMode=ThemeData(
  scaffoldBackgroundColor: Colors.grey[900],
  appBarTheme: AppBarTheme(
    centerTitle: true,
    backgroundColor: kBoxColor,
  ),
  textTheme: TextTheme(
    headline6: TextStyle(color: Colors.white),
    bodyText2: kMiniStil2,
  ),
);


class ThemeColorData extends ChangeNotifier{
 SharedPreferences? _sharedPrefObject;

  bool _isDark=false;

  bool get isDark=>_isDark;

  ThemeData? get themeColor{
    return _isDark ? darkMode : null;
  }

  void toggleTheme(){
    _isDark=!_isDark;
    saveThemeToSharedPref(_isDark);
    notifyListeners();
  }

  Future<void> createSharedPrefObject()async{
    _sharedPrefObject= await SharedPreferences.getInstance();
  }

  void saveThemeToSharedPref(bool value){
    _sharedPrefObject?.setBool('themeData', value);
  }

  void loadThemeFromSharePref()async{
    await createSharedPrefObject();
    _isDark=_sharedPrefObject?.getBool('themeData') ?? true;
  }

}