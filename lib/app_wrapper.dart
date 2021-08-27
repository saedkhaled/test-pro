import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:test_pro/providers/app_provider.dart';
import 'package:test_pro/ui/pages/auth_page.dart';
import 'package:test_pro/ui/pages/home_page.dart';

class AppWrapper extends StatefulWidget {
  static const routeName = '/app-wrapper';

  const AppWrapper({Key? key}) : super(key: key);

  @override
  _AppWrapperState createState() => _AppWrapperState();
}

class _AppWrapperState extends State<AppWrapper> {
  AppProvider? _appProvider;
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      _appProvider = Provider.of<AppProvider>(context);
      _isInit = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_appProvider!.isLoggedIn) {
      return AuthPage();
    } else {
      return HomePage();
    }
  }
}
