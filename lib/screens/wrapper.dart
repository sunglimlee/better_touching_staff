import 'package:better_touching_staff/screens/home/home.dart';
import 'package:flutter/material.dart';

/// 조건 분기가 될 위젯이다. 중요한 사살은 이 wrapper 클래스는 Provider 에 대한 내용만 보고 분기를 한다.
class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return either Home or Authenticate widget
    return Container(
      alignment: Alignment.center,
      child: const Home(),
    );
  }
}
