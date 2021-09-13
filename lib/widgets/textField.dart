import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class TextField extends StatefulWidget {
  final String hint;
  final function;

  TextField(this.hint, this.function);

  @override
  _TextFieldState createState() => _TextFieldState();
}

class _TextFieldState extends State<TextField> {
  final controller = TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    controller.text = widget.hint;
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
      child: CupertinoTextField(
        autofocus: true,
        keyboardType: TextInputType.text,
        onChanged: (String val) {
          widget.function(val);
        },
        controller: controller,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            width: 1,
            color: Colors.white,
          ),
        ),
        style: TextStyle(
          color: Colors.white,
        ),
        cursorColor: Colors.white,
        placeholder: widget.hint,
        placeholderStyle: TextStyle(
          color: Colors.grey[350],
        ),
      ),
    );
  }
}
