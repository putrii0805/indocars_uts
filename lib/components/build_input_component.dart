import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:indocars/constants.dart';

class BuildInputText extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String label;

  const BuildInputText({
    super.key,
    required this.controller,
    required this.label,
    this.keyboardType = TextInputType.text,
  });

  @override
  State<BuildInputText> createState() => _BuildInputTextState();
}

class _BuildInputTextState extends State<BuildInputText> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {}); // Update the UI when focus changes
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      elevation: _isFocused ? 5.0 : 0,
      clipBehavior: Clip.none,
      shadowColor: kPrimaryColorShadow,
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        focusNode: _focusNode,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          label: Text(widget.label),
          focusColor: kPrimaryColor,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: kPrimaryColor,
            ),
          ),
          labelStyle: TextStyle(
            color: _isFocused ? kPrimaryColor : Colors.grey,
          ),
        ),
      ),
    );
  }
}
