import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_pro/ui/screens/login_screen.dart';
import 'package:test_pro/ui/screens/signup_screen.dart';

class AuthPage extends StatefulWidget {
  static const routeName = '/auth-page';

  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage>
    with SingleTickerProviderStateMixin {
  static const tabs = [
    Tab(
      child: Text(
        'Sign Up',
        style: TextStyle(fontSize: 16.0),
      ),
    ),
    Tab(
      child: Text(
        'Sign In',
        style: TextStyle(fontSize: 16.0),
      ),
    )
  ];

  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SizedBox(height: 100),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Material(
            color: Colors.grey.shade400,
            elevation: 5.0,
            borderRadius: BorderRadius.circular(15.0),
            child: TabBar(
                controller: tabController,
                unselectedLabelColor: Colors.white,
                labelColor: Colors.black,
                indicatorColor: Colors.white,
                indicator: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    border:
                        Border.all(width: 1.0, color: Colors.grey.shade400)),
                tabs: tabs),
          ),
        ),
        Expanded(
            child: TabBarView(controller: tabController, children: [
          SignupScreen(onAction: () {
            tabController!.animateTo(1,
                duration: Duration(milliseconds: 300), curve: Curves.bounceIn);
            Fluttertoast.showToast(msg: 'Created User Successfully');
          }),
          LoginScreen()
        ])),
      ],
    ));
  }
}
