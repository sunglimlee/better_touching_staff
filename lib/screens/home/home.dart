import 'package:better_touching_staff/controllers/auth_controller.dart';
import 'package:flutter/material.dart';

// 이것도 wrapper widget 인데 프로그램이 크지 않기 때문에 그냥 stateless 로 하고 BottomSheet 을 사용한다.
class Home extends StatelessWidget {
  final AuthController _authController = AuthController();

  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: const Text('Brew Crew'),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        actions: [
          // [3 ways to to create a button with Icon and Text] https://www.flutterbeads.com/button-with-icon-and-text-flutter/
          ElevatedButton.icon(
              // Sign Out
              onPressed: () {
                final dynamic result = _authController.signOut();
                result ?? print('Please check with the internet connection');
              },
              // ElevatedButton without, no, remove border
              // https://stackoverflow.com/questions/69942023/how-to-remove-border-in-outlinedbutton
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown[400],
                  elevation: 0,
                  shadowColor: Colors.transparent),
              icon: const Icon(Icons.person),
              label: const Text('SignOut'))
        ],
      ),
    );
  }
}
