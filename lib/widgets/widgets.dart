import 'package:flutter/material.dart';

// const 로 fixed 시켜 버렸다.
// 이렇게 해서 외부에서 쓸 때 .copyWith 로 같이 사용하면 된다.
const myInputDecoration = InputDecoration(
  //hintText: 'Email',
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2.0)),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2.0)),
);

// 이렇게 하고도 싶어???
class myInputDecoration2 extends InputDecoration {
  @override
  // TODO: implement hintText
  String? get hintText => super.hintText;
}

/*
// 이방식은 안된다. 왜냐면 InputDecoration 이 Widget 이 아니므로
class myInputDecoation3 extends StatelessWidget {
  const myInputDecoation3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InputDecoration();
  }
}
*/

// 함수를 이용해서 위젯을 만드는 방법
dynamic myInputDecoration4() {
  return const InputDecoration(hintText: '이거도 되네.');
}

// StatelessWidget 을 이용해서 Container 를 이용해서 배경을 바꾸는 방법
class myCircleProgressIndicator extends StatelessWidget {
  const myCircleProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.brown[100],
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}
