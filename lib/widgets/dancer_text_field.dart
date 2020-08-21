import 'package:flutter/material.dart';

class DancerTextField extends StatefulWidget {
  final TextEditingController controller;
  final bool isSecret;
  final String labelText;
  final Function validator;
  final Function onSaved;
  final int maxLine;
  DancerTextField({
    this.controller,
    this.isSecret,
    this.labelText,
    this.validator,
    this.onSaved,
    this.maxLine,
  });
  @override
  _DancerTextFieldState createState() => _DancerTextFieldState();
}

class _DancerTextFieldState extends State<DancerTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: TextFormField(
        autofocus: false,
        maxLines: widget.maxLine,
        controller: widget.controller,
        validator: widget.validator,
        onSaved: widget.onSaved,
        obscureText: widget.isSecret,
        cursorColor: Theme.of(context).primaryColor,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w300,
          fontSize: 18,
        ),
        decoration: InputDecoration(
          
          labelText: widget.labelText,
          fillColor: Colors.black,
          filled: true,
          isDense: true,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 8.0,
          ),
          
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0.0),
            borderSide: BorderSide(
              color: Colors.white,
              width: 2.0
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0.0),
            borderSide: BorderSide(
              color: Color(0xffBD8929),
              width: 4.0,
            ),
          ),
        ),
      ),
    );
  }
}
