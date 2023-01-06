import 'package:better_touching_staff/controllers/auth_controller.dart';
import 'package:better_touching_staff/widgets/widgets.dart';
import 'package:flutter/material.dart';

class LogIn extends StatefulWidget {
  final Function callBack;

  const LogIn({Key? key, required this.callBack}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final AuthController _authController = AuthController();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = ''; // firebase 에서 전달받은 값이 null 이라면 error 처리를 해주어야 한다.
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: const Text('Login to Staffan'),
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
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20.0,
                    ),
                    // email
                    TextFormField(
                      initialValue: email, // 초기값을 계속 가지고 있도록 한다.
                      // TODO : email validation 기능 더 넣어야함.
                      // TODO : TextFormField 를 좀 더 꾸며주자.
                      decoration: myInputDecoration.copyWith(hintText: 'Email'),
                      validator: (val) {
                        return val!.isEmpty ? 'Enter an Email' : null;
                      },
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
                      // TODO : password validation 기능 더 넣어야함.
                      initialValue: password,
                      decoration:
                          myInputDecoration.copyWith(hintText: 'Password'),
                      validator: (val) {
                        return val!.length < 6
                            ? 'Enter a password 6+ chars long'
                            : null;
                      },
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
                      onPressed: () async {
                        // TODO 향후 여기서도 파이어베이스에서 넘어온 에러값을 활용해보자.
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            loading = true;
                          });
                          dynamic result =
                              await _authController.loginWithEmailAndPassword(
                                  email.toString(), password.toString());
                          if (result == null) {
                            setState(() {
                              loading = false;
                              error = 'could not login with those credentials';
                            });
                          }
                        }
                      },
                      child: const Text('     Log In     '),
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      error,
                      // Immediately invoking an anonymous function
                      style: () {
                        // print('$error 입니다.');
                        return const TextStyle(color: Colors.red, fontSize: 14);
                      }(),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
