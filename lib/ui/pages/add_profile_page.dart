import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:test_pro/providers/app_provider.dart';
import 'package:test_pro/ui/pages/home_page.dart';
import 'package:test_pro/ui/screens/age_screen.dart';
import 'package:test_pro/ui/screens/gender_screen.dart';
import 'package:test_pro/ui/screens/height_screen.dart';
import 'package:test_pro/ui/screens/weight_screen.dart';

class AddProfilePage extends StatefulWidget {
  static const routeName = '/add-profile';

  const AddProfilePage({Key? key}) : super(key: key);

  @override
  _AddProfilePageState createState() => _AddProfilePageState();
}

class _AddProfilePageState extends State<AddProfilePage> {
  AppProvider? _appProvider;
  bool _isInit = true;
  final controller = PageController();
  bool _isPassed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 30,
          child: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: controller,
            children: [
              GenderScreen(),
              AgeScreen(),
              HeightScreen(),
              WeightScreen(),
            ],
          ),
        ),
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: IgnorePointer(
              ignoring: _isPassed,
              child: RaisedButton(
                padding: EdgeInsets.all(18.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                onPressed: () async {
                  if (controller.page!.toInt() < 3) {
                    controller.animateToPage(controller.page!.toInt() + 1,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeIn);
                  } else {
                    await _appProvider!.saveUser();
                    Navigator.pushReplacementNamed(context, HomePage.routeName);
                  }
                },
                color: Colors.blue.shade900,
                child: Text(
                  'Next',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: SmoothPageIndicator(
              controller: controller, // PageController
              count: 4,
              effect: SlideEffect(
                  dotWidth: 10.0,
                  dotHeight: 10.0,
                  dotColor: Colors.grey.shade400,
                  activeDotColor: Colors.grey.shade700),
            ),
          ),
        ),
      ],
    ));
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
