import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_pro/providers/app_provider.dart';
import 'package:test_pro/ui/pages/auth_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AppProvider? _appProvider;
  bool _isInit = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: RaisedButton(
              onPressed: () async {
                await _appProvider!.signOut();
                Navigator.pushReplacementNamed(context, AuthPage.routeName);
              },
              child: Text('SignOut'))),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      _appProvider = Provider.of<AppProvider>(context);
      _isInit = false;
    }
  }
}
