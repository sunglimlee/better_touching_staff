import 'package:better_touching_staff/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseController {
  final User? user;

  // 외부에서 받은 값을 이용해서 멤버변수에 초기화를 하는 방법, late 사용하고, 생성자에서 초기화해준다.
  late DatabaseService databaseService;

  DatabaseController({this.user}) {
    databaseService = DatabaseService(user: user);
  }

  Future<dynamic> addNewUserDummyDataIntoFirestore(String name) async {
    // 기본값이 들어있다는걸 기억하자.
    return await databaseService.addNewUserDummyDataIntoFirestore();
  }
}
