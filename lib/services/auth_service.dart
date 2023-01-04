import 'package:firebase_auth/firebase_auth.dart';

/// Firebase 이용한 Authentication
class AuthService {
  // 잘봐라 default 이므로 무조건 하나로만 서비스된다. 즉 이 자체가 singleton 이란 뜻
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // 이제 이 _firebaseAuth 는 하나만 존재하므로 여기에서 값을 Stream 으로 받아서 그 값을 변경하도록 하면 된다.
  // Firebase Auth Service 가 Stream 을 이용해서 자동으로 값을 보내준다. authStateChanges() 를 이용해서
  // Auth change user stream
  Stream<User?> get user {
    return _firebaseAuth.authStateChanges();
  }

  // sign in anonymous
  Future<dynamic> signInAnonymous() async {
    try {
      // 여기서 signIn 을 했을 때 결과 같이 나오지.. 나오는 결과 값을 가지고 뭘 해야 하는데
      // 경우의 수중에서 어떤것을 선택하는게 중요하다. 내가 원하는 걸로 해도 된다. 알다시피 여기에서 사인이 문제가 없는지 확인해주는게 좋겠지.
      // 이렇게 하면 여기서 기다려야 하는거잖아.
      UserCredential userCredential = await _firebaseAuth.signInAnonymously();
      // 기다렸기 때문에 값을 받는게 가능하지.
      User? user = userCredential.user; // 일반적인 방법
      // 내가 필요한 것만 추림 User
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // log out
  Future<dynamic> signOut() async {
    try {
      return await _firebaseAuth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register with email & password
  Future<dynamic> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // login with email & password
  Future<dynamic> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } catch (e) {
      print(e.toString());
      return null; // 문제가 생겼기 때문에 null 을 리턴한다. TODO 향후 여기서 e.toString() 을 리턴해서 서버의 에러값을 활용하자.
    }
  }
}
