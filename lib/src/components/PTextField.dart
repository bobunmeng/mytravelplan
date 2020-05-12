import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class PTextField extends StatelessWidget {
  final String titleLabel;
  final String placeholder;
  final Function(String) onChanged;
  final bool secureEntry;
  final TextInputType keyboardType;
  final FocusNode focusNode;
  final TextEditingController controller;
  final int maxLines;

  PTextField(
      {@required this.titleLabel,
      this.placeholder,
      this.onChanged,
      this.secureEntry = false,
      this.keyboardType = TextInputType.text,
      this.focusNode,
      this.controller,
      this.maxLines})
      : super();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      child: TextField(
        obscureText: secureEntry,
        decoration:
            InputDecoration(labelText: titleLabel, hintText: placeholder),
        onChanged: onChanged,
        style: TextStyle(fontSize: 14.0),
        keyboardType: keyboardType,
        focusNode: focusNode,
        controller: controller,
        maxLines: maxLines ?? 1,
      ),
    );
  }
}
