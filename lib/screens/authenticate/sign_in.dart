import 'package:better_touching_staff/controllers/auth_controller.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthController _authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: const Text('Sign in to Brew Crew'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: ElevatedButton(
          child: const Text('Sign in anonymous'),
          onPressed: () async {
            // 잘봐라.. Future 로 날라오니깐 기다려줘야지.. 그래서 await 를 사용해야한다.꼭 기억해라.. 정말 중요한 거다.
            // 곰곰히 생각해보니깐 값의 변경유무에 따라서 그 화면을 바꾸어주는거잖아.. 그래서 여기에서 조건을 가지고 작업하는게 맞다고 본다.
            dynamic result = await _authController.signInAnonymous();
            result == null
                ? print('error sign in')
                : {print('signed in \n${result.uid}')};
          },
        ),
      ),
    );
  }
}
