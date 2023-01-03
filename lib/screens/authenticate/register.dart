import 'package:better_touching_staff/controllers/auth_controller.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function callBack;
  const Register({Key? key, required this.callBack}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthController _authController = AuthController();

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: const Text('Register to Staffan'),
        actions: [
          // [3 ways to to create a button with Icon and Text] https://www.flutterbeads.com/button-with-icon-and-text-flutter/
          ElevatedButton.icon(
            // Log Out
              onPressed: () {
                widget.callBack(); // 여기서는 함수를 실행하니깐 괄호를 넣어주어야 하는거다.
              },
              // ElevatedButton without, no, remove border
              // https://stackoverflow.com/questions/69942023/how-to-remove-border-in-outlinedbutton
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown[400],
                  elevation: 0,
                  shadowColor: Colors.transparent),
              icon: const Icon(Icons.person),
              label: const Text('LogIn'))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          child: Column(
            children: [
              const SizedBox(
                height: 20.0,
              ),
              // email
              TextFormField(
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              // password
              TextFormField(
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                },
                obscureText: true,
              ),
              const SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink[400],
                    textStyle: const TextStyle(color: Colors.white)),
                onPressed: () async {},
                child: const Text('   Register   '),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
