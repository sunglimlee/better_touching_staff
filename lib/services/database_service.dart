import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Firestore 에 CRUD 를 작업하기 위한 서비스 클래스 (DatabaseService)
class DatabaseService {
  // user id 는 Firestore 에서 항상 얻어올 수 있다.
  final User? user;

  DatabaseService({this.user});

  // collection reference
  final CollectionReference jobCollectionReference =
      FirebaseFirestore.instance.collection('job_list');

  // 분명히 uid 를 provider 에서 얻어와서 그 값을 이용해서 초기값을 저장하는 기능을 수행하겠지.
  // 1. StreamProvider<User> 를 통해서 항상 User 의 값을 받아올 수 있잖아? 그러니깐 DatabaseService 를 실행할 때마다 값을 넘겨주어서 하는게 제일 좋겠다. 빙고!!!
  // 2. 그게 아니라면 상태관리에서 미리 값을 보관해놓고 그 값을 사용해도 되고
  // 3. 아니면 여기서 상태관리에서 사용되는 값을 사용해도 되고
  // 4. 그것도 아니라면 Auth_Service 에서 User 를 받는 함수를 만들어서 그 함수를 여기서 호출해도 되고..
  // uid 로 연결을 하는것이므로 반드시 필요한 작업이다.
  // 일반적으로 새로운 유저의 uid 를 가지고 데이터를 저장하는 거니깐 authentication 이 문제가 없을 때 그 때 받은 user 정보를 이용해서 바로 다음에 이 함수를 실행토록 한다.
  Future<dynamic> addNewUserDummyDataIntoFirestore(String name) async {
    try {
      user == null
          ? () {
              print("User doesn't exists");
              return null;
            }()
          : await jobCollectionReference.doc(user!.uid).set({
              'name': name,
            }); // 이제부터 Firestore 데어터를 Add 하는 방법을 알아야 하는구나.
    } catch (e) {
      print('registerUserDataIntoFirestore function in DatabaseService Class');
    }
  }
  // get job_list stream
  // new user 가 들어왔을 때 data 가 바뀌었다는 걸 알려주는 함수, 보고 싶은 내용이 뭔데?
  // 여기서 받는 값을 내가 원하는 데이터로 바꾸어서 provider 로 보내고 그 보낸 파일이 듣고 있는 곳들에게 다시 업데이트 되도록 해준다.
  Stream<QuerySnapshot> get jobList {
    return jobCollectionReference.snapshots();
  }

}
