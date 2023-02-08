import 'package:better_touching_staff/controllers/auth_controller.dart';
import 'package:better_touching_staff/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Register extends ConsumerStatefulWidget {
  final Function callBack;

  const Register({Key? key, required this.callBack}) : super(key: key);

  @override
  ConsumerState createState() => _RegisterState();
}

class _RegisterState extends ConsumerState<Register> {
//  final AuthController _authController = AuthController();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {

    final authControllerWatch = ref.watch(authControllerProvider);

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
                      // TODO : decoration
                      decoration: myInputDecoration.copyWith(hintText: 'Email'),
                      // TODO : email validation 기능 더 넣어야함.
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
                      initialValue: password,
                      // 초기값을 계속 가지고 있도록 한다.
                      // TODO : password validation 기능 더 넣어야함.
                      // TODO : TextFormField 를 좀 더 꾸며주자.
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
                          dynamic result = await authControllerWatch
                              .registerWithEmailAndPassword(
                                  email.toString(), password.toString());
                          // 여기다가 새로운 User 의 uid 를 이용해서 dummy data 를 collection 에 저장하고 싶어...
                          if (result == null) {
                            setState(() {
                              loading = false;
                              error =
                                  'Please supply a valid email and password';
                            });
                          }
                        }
                      },
                      child: const Text('   Register   '),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      error,
                      style: const TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
