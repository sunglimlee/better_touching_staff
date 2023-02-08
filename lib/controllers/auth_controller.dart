import 'package:better_touching_staff/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// authControllerProvider 전역변수
final authControllerProvider = Provider(
  (ref) {
    return AuthController();
  },
);

// User return, 잘봐라. auth 객체나, 함수에서 나오는 결과 객체나 한번만 사용하고 끝나는게 아니지..
// 사용자의 반응과 스트림과 퓨쳐에 따라 계속 상태가 유지가 되어야 한다는 거지..
// 즉 상태가 유지가 되는 객체를 Riverpod 에 올려야 하는거다.
final userStreamProvider = StreamProvider.autoDispose((ref) {
  final authControllerProviderWatch = ref.watch(authControllerProvider);
  return authControllerProviderWatch.user;
});


class AuthController {
  // 지금 현재는 getX 를 사용하지 않기로 하니깐 여기서 바로 객체를 만들어서 사용할거다.
  //AuthController({required this.authService});
  AuthService authService = AuthService();

  // 이 함수를 보다시피 스트림으로 계속 받는거지.
  // Auth change user stream
  Stream<User?> get user {
    return AuthService().user;
  }

  // sign in anonymous
  Future<dynamic> signInAnonymous() async {
    return await authService.signInAnonymous();
  }

  // register with email & password
  Future<dynamic> registerWithEmailAndPassword(
      String email, String password) async {
    return await authService.registerWithEmailAndPassword(email, password);
  }

  // login with email & password
  Future<dynamic> loginWithEmailAndPassword(
      String email, String password) async {
    return await authService.loginWithEmailAndPassword(email, password);
  }

  // sign out
  Future<dynamic> signOut() async {
    return await authService.signOut();
  }
}
