import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:test_pro/providers/app_provider.dart';
import 'package:test_pro/ui/pages/add_profile_page.dart';

class SetNamePage extends StatefulWidget {
  static const routeName = '/set-name';

  const SetNamePage({Key? key}) : super(key: key);

  @override
  _SetNamePageState createState() => _SetNamePageState();
}

class _SetNamePageState extends State<SetNamePage> {
  AppProvider? _appProvider;
  bool _isInit = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SizedBox(
              height: 200.0,
            ),
            Text(
              'Your Name?',
              style: TextStyle(fontSize: 30.0),
            ),
            SizedBox(
              height: 100.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Your Name',
                ),
                onChanged: (value) => _appProvider!.currentUser!.name = value,
                onSaved: (value) => _appProvider!.currentUser!.name = value,
              ),
            ),
            SizedBox(
              height: 150.0,
            ),
            SizedBox(
              height: 20.0,
            ),
            RaisedButton(
              padding: EdgeInsets.all(18.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              onPressed: () {
                if (_appProvider!.currentUser!.name != null &&
                    _appProvider!.currentUser!.name != '') {
                  Navigator.pushReplacementNamed(
                      context, AddProfilePage.routeName);
                } else {
                  Fluttertoast.showToast(msg: 'please enter your name');
                }
              },
              color: Colors.blue.shade900,
              child: Text(
                'Continue',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
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
