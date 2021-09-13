import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../widgets/textField.dart' as tx;
import '../widgets/textAddEvent.dart';

class DynamicTextFields extends StatefulWidget {
  final String text;
  final List<dynamic> list;

  DynamicTextFields(this.text, this.list);

  @override
  _DynamicTextFieldsState createState() => _DynamicTextFieldsState();
}

class _DynamicTextFieldsState extends State<DynamicTextFields> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Textt(
                text: widget.text,
                color: Colors.white,
              ),
              CupertinoButton(
                onPressed: () {
                  setState(() {
                    widget.list.add('${widget.text}');
                  });
                },
                child: Icon(
                  CupertinoIcons.add_circled,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 200,
            child: ListView.builder(
              itemBuilder: (ctx, index) {
                return tx.TextField(widget.list[index], (String val) {
                  widget.list[index] = val;
                });
              },
              itemCount: widget.list.length,
            ),
          ),
        ],
      ),
    );
  }
}
