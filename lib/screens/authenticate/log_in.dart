import 'package:better_touching_staff/controllers/auth_controller.dart';
import 'package:flutter/material.dart';

class LogIn extends StatefulWidget {
  final Function callBack;

  const LogIn({Key? key, required this.callBack}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
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
        title: const Text('LogIn to Staffan'),
        actions: [
          ElevatedButton.icon(
              // Log Out
              onPressed: () {
                // 여기서 setState 를 할 필요가 없지.. 외부에서 할거니깐..
                widget.callBack();
              },
              // ElevatedButton without, no, remove border
              // https://stackoverflow.com/questions/69942023/how-to-remove-border-in-outlinedbutton
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown[400],
                  elevation: 0,
                  shadowColor: Colors.transparent),
              icon: const Icon(Icons.person),
              label: const Text('Register'))
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
                child: const Text('     Log In     '),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
