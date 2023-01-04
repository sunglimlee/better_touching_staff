import 'package:better_touching_staff/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  // 지금 현재는 getX 를 사용하지 않기로 하니깐 여기서 바로 객체를 만들어서 사용할거다.
  //AuthController({required this.authService});
  AuthService authService = AuthService();

  // Auth change user stream
  Stream<User?> get user {
    return AuthService().user;
  }

  // sign in anonymous
  Future<dynamic> signInAnonymous() async {
    return authService.signInAnonymous();
  }

  // register with email & password
  Future<dynamic> registerEmailAndPassword(
      String email, String password) async {
    return authService.registerEmailAndPassword(email, password);
  }

  // sign out
  Future<dynamic> signOut() async {
    return await authService.signOut();
  }
}
