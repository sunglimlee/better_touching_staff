import 'package:firebase_auth/firebase_auth.dart';

/// Firebase 이용한 Authentication
class AuthService {
  // 잘봐라 default 이므로 무조건 하나로만 서비스된다. 즉 이 자체가 singleton 이란 뜻
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // sign in anonymous
  Future<dynamic> signInAnonymous() async {
    try {
      // 여기서 signIn 을 했을 때 결과 같이 나오지.. 나오는 결과 값을 가지고 뭘 해야 하는데
      // 경우의 수중에서 어떤것을 선택하는게 중요하다. 내가 원하는 걸로 해도 된다. 알다시피 여기에서 사인이 문제가 없는지 확인해주는게 좋겠지.
      // 이렇게 하면 여기서 기다려야 하는거잖아.
      UserCredential userCredential = await _firebaseAuth.signInAnonymously();
      // 기다렸기 때문에 값을 받는게 가능하지.
      User? user = userCredential.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
// sign in email & password

// register with email & password

// sign out
}
