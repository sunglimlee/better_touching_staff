import 'package:flutter/material.dart';

// 이것도 wrapper widget 인데 프로그램이 크지 않기 때문에 그냥 stateless 로 하고 BottomSheet 을 사용한다.
class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const Text('Home Page'),
    );
  }
}
