import 'package:flutter/material.dart';

// const 로 fixed 시켜 버렸다.
const myInputDecoration = InputDecoration(
    //hintText: 'Email',
    fillColor: Colors.white,
    filled: true,
    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 2.0)),
    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 2.0)),
);

// 이렇게 하고도 싶어???
class myInputDecoation extends InputDecoration {
  @override
  // TODO: implement hintText
  String? get hintText => super.hintText;
}
