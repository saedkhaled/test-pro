import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_pro/app_wrapper.dart';
import 'package:test_pro/ui/pages/add_profile_page.dart';
import 'package:test_pro/ui/pages/auth_page.dart';
import 'package:test_pro/ui/pages/home_page.dart';
import 'package:test_pro/ui/pages/set_name_page.dart';

final routes = <String, WidgetBuilder>{
  SetNamePage.routeName: (BuildContext context) => SetNamePage(),
  AddProfilePage.routeName: (BuildContext context) => AddProfilePage(),
  AppWrapper.routeName: (BuildContext context) => AppWrapper(),
  HomePage.routeName: (BuildContext context) => HomePage(),
  AuthPage.routeName: (BuildContext context) => AuthPage(),
};
