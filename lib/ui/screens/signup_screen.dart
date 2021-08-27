import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_pro/providers/app_provider.dart';
import 'package:test_pro/ui/widgets/password_form_field.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = '/signup';
  final Function onAction;

  const SignupScreen({Key? key, required this.onAction}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  AppProvider? _appProvider;
  final formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;
  String? _passwordConfirm;
  bool loading = false;
  bool _isInit = true;

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

    final signUpButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            bool result = await _appProvider!.signUp(_email!, _password!);
            if (result) widget.onAction();
          }
        },
        padding: EdgeInsets.all(18.0),
        color: Colors.grey.shade400,
        child: Text('Continue', style: TextStyle(color: Colors.white)),
      ),
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
                labelText: 'Create Password',
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
              SizedBox(height: 25.0),
              PasswordFormField(
                labelText: 'Re-write Password',
                initialValue: '',
                onSaved: (value) {
                  _passwordConfirm = value.toString();
                },
                onChanged: (value) {
                  _passwordConfirm = value.toString();
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return "This field is required";
                  } else if (value != _password) {
                    return "Passwords doesnt match";
                  }
                  return null;
                },
              ),
              SizedBox(height: 120.0),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s,',
                  softWrap: true,
                  textAlign: TextAlign.center,
                ),
              ),
              signUpButton,
              SizedBox(height: 8.0),
            ],
          ),
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
