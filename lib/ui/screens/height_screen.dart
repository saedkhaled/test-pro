import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'package:test_pro/providers/app_provider.dart';

class HeightScreen extends StatefulWidget {
  const HeightScreen({Key? key}) : super(key: key);

  @override
  _HeightScreenState createState() => _HeightScreenState();
}

class _HeightScreenState extends State<HeightScreen> {
  AppProvider? _appProvider;
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      _appProvider = Provider.of<AppProvider>(context);
      _appProvider!.currentUser!.length = 160;
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
          'How much is your length?',
          style: TextStyle(fontSize: 20.0),
        )),
        SizedBox(
          height: 100.0,
        ),
        NumberPicker(
          textStyle: TextStyle(fontSize: 20.0, color: Colors.grey.shade400),
          selectedTextStyle:
              TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
          value: _appProvider!.currentUser!.length ?? 160,
          itemCount: 5,
          minValue: 100,
          maxValue: 250,
          onChanged: (value) =>
              setState(() => _appProvider!.currentUser!.length = value),
        ),
      ],
    );
  }
}
