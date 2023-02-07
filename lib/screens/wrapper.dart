import 'package:better_touching_staff/screens/authenticate/authenticate.dart';
import 'package:better_touching_staff/screens/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// 조건 분기가 될 위젯이다. 중요한 사살은 이 wrapper 클래스는 Provider 에 대한 내용만 보고 분기를 한다.
class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 잘봐라. 변수를 만들 때 null 이 들어가는지 계속 확인해야 한다.
    final User? user = Provider.of<User?>(context); // 여기 보듯이 user 값은 null 이 될 수 있따.
    // return either Home or Authenticate widget
    return Container(
      alignment: Alignment.center,
      child: () {
        print('[⭐⭐⭐️/wrapper/build/ 현재 user 의 값은 : $user 입니다.'); // user 의 값이 있다.. 이렇게 오래되었는데도 안없어지고 그대로 있네..
        //print('[⭐⭐/wrapper/build/ user의 uid 값은 : ${user?.uid}');
        return user == null ? const Authenticate() : Home();
      } (),

    );
  }
}
