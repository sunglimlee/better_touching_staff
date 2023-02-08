import 'package:better_touching_staff/model/current_user_job_model.dart';
import 'package:better_touching_staff/model/job_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';



/// Firestore 에 CRUD 를 작업하기 위한 서비스 클래스 (DatabaseService)
class DatabaseService {
  // user id 는 Firestore 에서 항상 얻어올 수 있다.
  final User? user;

  DatabaseService({required this.user});

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
  Future<dynamic> addNewUserDummyDataIntoFirestore(
      {String name = 'New User',
      String age = '20',
      String coupon = '100'}) async {
    try {
      user == null
          ? () {
              print("User doesn't exists");
              return null;
            }()
          // 원하는대로 값을 넣을 수 있게 되었다.
          : await jobCollectionReference.doc(user!.uid).set({
              'name': name,
              'age': age,
              'coupon': coupon,
            }); // 이제부터 Firestore 데어터를 Add 하는 방법을 알아야 하는구나.
    } catch (e) {
      print('registerUserDataIntoFirestore function in DatabaseService Class');
    }
  }

  // get job_list stream
  // new user 가 들어왔을 때 data 가 바뀌었다는 걸 알려주는 함수, 보고 싶은 내용이 뭔데?
  // 여기서 받는 값을 내가 원하는 데이터로 바꾸어서 provider 로 보내고 그 보낸 파일이 듣고 있는 곳들에게 다시 업데이트 되도록 해준다.
  // 정말 강력하다. document 의 데이터 하나 바뀌었는데도 그걸 감지해서 snapshot 으로 다 더져 보내주다니..
  // 근데 값이 바뀌면 리스트 전체를 리사이클링 뚜루를 한다는데.. 괜찮을까?
  Stream<List<JobModel>> get jobList {
    try {
      var result = jobCollectionReference
          .snapshots(includeMetadataChanges: true)
          .map((snapshot) => _transformIntoJobModelListFromSnapshot(snapshot));
      print(
          '[⭐⭐⭐⭐ ️database_service/jobList 새로 바뀐 List<JobModel> 의 값은 : ${jobCollectionReference.snapshots().map((event) => print('xxx ${event.docs.length}'))}');
      return result;
    } on Exception {
      print('jobList 를 생성하는 과정에서 예외가 발생했습니다.');
      throw Exception(); // 이렇게 Stream 에 Exception 을 넘겨준다.
    }
  }

  // get user doc stream : 이럴필요가 있는지 보자. 이게 진행되는게 너무나도 아름답네.. 각종 데이터들을 받아오고 만들어서 새로운 나의 데이터를 던져준다.
  Stream<CurrentUserJobModel> get currentUserJobModel {
    // 여기에는 user 가 무조건 있어야 하고 그리고 해당 도큐먼트의 스냅샷을 받는다.
    // ******* 아주 중요한 부분, 맨날 하는데 오늘 새롭네.. ㅋ *******
    // 데이터 변경을 위해서는 각 값에 대해서 변경해야 하니깐 map 을 사용해야지..
    return jobCollectionReference
        .doc(user!.uid)
        .snapshots()
        .map((event) => _getCurrentUserJobModelFromDocumentSnapshot(event));
  }

  CurrentUserJobModel _getCurrentUserJobModelFromDocumentSnapshot(
      DocumentSnapshot documentSnapshot) {
    return CurrentUserJobModel(
      uid: user!.uid,
      name: documentSnapshot.get('name'),
      age: documentSnapshot.get('age'),
      coupon: documentSnapshot.get('coupon'),
    );
  }

  // job list from snapshot
  // 매번 바뀔 때 마다 Stream 에서 불러오기 위해서 함수로 만든다.
  List<JobModel> _transformIntoJobModelListFromSnapshot(
      QuerySnapshot querySnapshot) {
    // QuerySnapshot 에서 JobModel 로 변환
    // [issue] The argument type 'Object?' can't be assigned to the parameter type 'Map<String, dynamic>'
    // [answer] https://stackoverflow.com/questions/70621423/the-argument-type-object-cant-be-assigned-to-the-parameter-type-mapdynamic
    var result = querySnapshot.docs
        .map((doc) => JobModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
    print('transform 한 result 값은 : ${result[0].coupon}'); // 여기보면
    return result;
    /*return querySnapshot.docs.map((doc) {
      return JobModel(
        name: doc.get('name') ?? '',
        age: doc.get('age') ?? 20,
        coupon: doc.get('coupon') ?? 100,
      );
    }).toList();*/
  }

  // Modify document from SettingForm with CurrentUserJobModel
  Future<void> modifyDocumentFromSettingFormWithCurrentUserJobModel(
      CurrentUserJobModel currentUserJobModel) async {
    try {
      await jobCollectionReference
          .doc(currentUserJobModel.uid.toString())
          .set(currentUserJobModel.toJson());
    } catch (e) {
      // 또는
      // throw Exception('데이터를 쓰는 도중 에러가 발생했습니다. Error occurred while writing');
      return Future.error('데이터를 쓰는 도중 에러가 발생했습니다.Error occurred while writing');
    }
  }
}
