import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'package:test_pro/providers/app_provider.dart';

class AgeScreen extends StatefulWidget {
  const AgeScreen({Key? key}) : super(key: key);

  @override
  _AgeScreenState createState() => _AgeScreenState();
}

class _AgeScreenState extends State<AgeScreen> {
  AppProvider? _appProvider;
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      _appProvider = Provider.of<AppProvider>(context);
      _appProvider!.currentUser!.age = 18;
      _isInit = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: 200.0,
        ),
        Center(
            child: Text(
          'How old are you?',
          style: TextStyle(fontSize: 20.0),
        )),
        SizedBox(
          height: 100.0,
        ),
        NumberPicker(
          textStyle: TextStyle(fontSize: 20.0, color: Colors.grey.shade400),
          selectedTextStyle:
              TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
          value: _appProvider!.currentUser!.age ?? 18,
          itemCount: 5,
          minValue: 8,
          maxValue: 100,
          onChanged: (value) =>
              setState(() => _appProvider!.currentUser!.age = value),
        ),
      ],
    );
  }
}
