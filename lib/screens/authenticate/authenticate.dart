import 'package:better_touching_staff/screens/authenticate/register.dart';
import 'package:better_touching_staff/screens/authenticate/log_in.dart';
import 'package:flutter/material.dart';

/// 여기서 LogIn widget & Register widget 이 들어간다.
/// Stateful widget 을 사용하는 이유는 뭘까? setState 를 이용해서 state 를 가지고 있기 위해서이지.. 단지 onPressed 때문이 아니라..
class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  // 여기서 잘봐라.. 외부에서 들어오는 건 위에서 작업하지만 여기의 state 저장용 변수는 이곳 State<Authenticate> 에서 작업한다.
  // 변수를 선언하면 쓸 수 있듯이 클래스도 선언해야 그리고 instance 해야 쓸 수 있다. 말 그대로 초기화 같은 거지..
  bool showLogInOrRegister = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: showLogInOrRegister == true
          ? LogIn(
              callBack: toggleForLogInOrRegisterPage,
            )
          : Register(callBack: toggleForLogInOrRegisterPage),
    );
  }

  void toggleForLogInOrRegisterPage() {
    setState(() {
      //print(showLogInOrRegister.toString());
      showLogInOrRegister = !showLogInOrRegister;
    });
  }
}
