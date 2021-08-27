import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_pro/providers/app_provider.dart';

class GenderScreen extends StatefulWidget {
  const GenderScreen({
    Key? key,
  }) : super(key: key);

  @override
  _GenderScreenState createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  AppProvider? _appProvider;
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      _appProvider = Provider.of<AppProvider>(context);
      _appProvider!.currentUser!.gender = false;
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
          'What is your sex?',
          style: TextStyle(fontSize: 20.0),
        )),
        SizedBox(
          height: 50.0,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 50.0, left: 50.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () => setState(
                          () => _appProvider!.currentUser!.gender = false),
                      child: Card(
                          elevation: 20,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                              child: Icon(Icons.female,
                                  color:
                                      _appProvider!.currentUser!.gender ?? true
                                          ? Colors.grey
                                          : Colors.red.shade900,
                                  size: 130.0))),
                    ),
                    SizedBox(height: 20.0),
                    Text('Women')
                  ],
                ),
              ),
              SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () => setState(
                          () => _appProvider!.currentUser!.gender = true),
                      child: Card(
                          elevation: 20,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                              child: Icon(Icons.male,
                                  color:
                                      _appProvider!.currentUser!.gender ?? false
                                          ? Colors.blue.shade900
                                          : Colors.grey,
                                  size: 130.0))),
                    ),
                    SizedBox(height: 20.0),
                    Text('Men')
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
