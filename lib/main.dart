import 'package:better_touching_staff/controllers/auth_controller.dart';
import 'package:better_touching_staff/screens/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart'; // install FlutterFire_CLI
import 'package:better_touching_staff/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

/// 여기 파이어 베이스를 연결하기 위한 초기화 작업을 해주어야 한다.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
      initialData: null,
      value: AuthController().user, //
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Good Touching Staff',
        // TODO Theme 해야한다.
        theme: ThemeData(
          primarySwatch: Colors.brown,
        ),
        home: const Wrapper(),
      ),
    );
  }
}
