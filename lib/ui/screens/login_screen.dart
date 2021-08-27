import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_pro/providers/app_provider.dart';
import 'package:test_pro/ui/pages/home_page.dart';
import 'package:test_pro/ui/pages/set_name_page.dart';
import 'package:test_pro/ui/widgets/password_form_field.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AppProvider? _appProvider;
  final formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;
  dynamic _user;
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
    final email =
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Text(
          'Email',
          style: TextStyle(fontSize: 16.0),
        ),
      ),
      SizedBox(
        height: 10.0,
      ),
      TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return "This field is required";
          }
          return null;
        },
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        onChanged: (String value) {
          setState(() => _email = value);
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
        ),
      )
    ]);

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            await _appProvider!.signIn(_email!, _password!);
            if (_appProvider!.authUser != null) {
              print('Signed in: ${_appProvider!.authUser!.uid}');
              _appProvider!.isLoggedIn = true;
              if (!_appProvider!.isUserExist) {
                Navigator.pushReplacementNamed(context, SetNamePage.routeName);
              } else {
                Navigator.pushReplacementNamed(context, HomePage.routeName);
              }
            } else {
              print("error singing in!");
            }
          }
        },
        padding: EdgeInsets.all(18.0),
        color: Colors.grey.shade400,
        child: Text('Continue', style: TextStyle(color: Colors.white)),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Forgot Password?',
        style: TextStyle(
            color: Colors.black54,
            decoration: TextDecoration.underline,
            fontSize: 12.0),
      ),
      onPressed: () {},
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Form(
          key: formKey,
          child: ListView(
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              SizedBox(
                height: 40.0,
              ),
              email,
              SizedBox(height: 25.0),
              PasswordFormField(
                labelText: 'Password',
                initialValue: '',
                onSaved: (value) {
                  _password = value.toString();
                },
                onChanged: (value) {
                  _password = value.toString();
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return "This field is required";
                  }
                  return null;
                },
              ),
              SizedBox(height: 5.0),
              forgotLabel,
              SizedBox(height: 200.0),
              loginButton,
              SizedBox(height: 8.0),
            ],
          ),
        ),
      ),
    );
  }
}
