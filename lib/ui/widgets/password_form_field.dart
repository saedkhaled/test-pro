import 'package:flutter/material.dart';

class PasswordFormField extends StatefulWidget {
  final String labelText;
  final String initialValue;
  final Function onSaved;
  final Function onChanged;
  final Function validator;

  const PasswordFormField(
      {Key? key,
      required this.labelText,
      required this.initialValue,
      required this.onSaved,
      required this.onChanged,
      required this.validator})
      : super(key: key);

  @override
  _PasswordFormFieldState createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool _hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Text(
          widget.labelText,
          style: TextStyle(fontSize: 16.0),
        ),
      ),
      SizedBox(
        height: 10.0,
      ),
      TextFormField(
        validator: (value) => widget.validator(value),
        autofocus: false,
        obscureText: _hidePassword,
        onSaved: (value) => widget.onSaved(value),
        onChanged: (value) => widget.onChanged(value),
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(
              _hidePassword
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              color: Colors.grey.shade400,
            ),
            onPressed: () {
              setState(() {
                _hidePassword = !_hidePassword;
              });
            },
          ),
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
        ),
      )
    ]);
  }
}
