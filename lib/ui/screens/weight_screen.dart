import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'package:test_pro/providers/app_provider.dart';

class WeightScreen extends StatefulWidget {
  const WeightScreen({Key? key}) : super(key: key);

  @override
  _WeightScreenState createState() => _WeightScreenState();
}

class _WeightScreenState extends State<WeightScreen> {
  AppProvider? _appProvider;
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      _appProvider = Provider.of<AppProvider>(context);
      _appProvider!.currentUser!.weight = 60;
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
          'How much is your weight?',
          style: TextStyle(fontSize: 20.0),
        )),
        SizedBox(
          height: 100.0,
        ),
        NumberPicker(
          textStyle: TextStyle(fontSize: 20.0, color: Colors.grey.shade400),
          selectedTextStyle:
              TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
          value: _appProvider!.currentUser!.weight ?? 60,
          itemCount: 5,
          minValue: 20,
          maxValue: 250,
          onChanged: (value) =>
              setState(() => _appProvider!.currentUser!.weight = value),
        ),
      ],
    );
  }
}
