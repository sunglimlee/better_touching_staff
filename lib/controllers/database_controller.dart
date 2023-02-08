import 'package:better_touching_staff/controllers/auth_controller.dart';
import 'package:better_touching_staff/model/current_user_job_model.dart';
import 'package:better_touching_staff/model/job_model.dart';
import 'package:better_touching_staff/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Riverpod Global 변수 설정하는 부분
final databaseControllerProvider = Provider.autoDispose((ref) {
  // 여기처럼 한번만 읽을 거잖아... 그러니깐 read 를 해야지..
  final userStreamProviderWatch = ref.read(userStreamProvider);
  return DatabaseController(userStreamProviderWatch.value);
});

final jobList = StreamProvider.autoDispose((ref) {
  final databaseControllerProviderWatch = ref.watch(databaseControllerProvider);
  return databaseControllerProviderWatch.jobList;
});

final currentUserJobModel = StreamProvider.autoDispose((ref) {
  final databaseControllerProviderWatch = ref.watch(databaseControllerProvider);
  return databaseControllerProviderWatch.currentUserJobModel;
});



class DatabaseController {
  // 만약 ref 로 참조할 수 없다면 컨트롤러를 만들 때 집어 넣어주면 되잖아.
  User? user;
  DatabaseService databaseService;
  // 이런식으로 초기화를 하는구나. factory 를 사용할 수 도 있고..
  DatabaseController(this.user) : databaseService = DatabaseService(user: user);

  // 이부분도 고쳐주어야 한다.
  Future<dynamic> addNewUserDummyDataIntoFirestore(
      {String name = 'New User',
        String age = '20',
        String coupon = '100'}) async {
    try {
      return databaseService.addNewUserDummyDataIntoFirestore(name: name, age: age, coupon: coupon);
    } catch (e) {
      print('registerUserDataIntoFirestore function in DatabaseService Class');
      rethrow;
    }
  }

  Stream<List<JobModel>> get jobList {
    try {
      return databaseService.jobList;
    } catch (e) {
      rethrow; // 이렇게 Stream 에 Exception 을 넘겨준다.
    }
  }

  Stream<CurrentUserJobModel> get currentUserJobModel {
    try {
      return databaseService.currentUserJobModel;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> modifyDocumentFromSettingFormWithCurrentUserJobModel(
      CurrentUserJobModel currentUserJobModel) async {
    try {
      databaseService.modifyDocumentFromSettingFormWithCurrentUserJobModel(currentUserJobModel);
    } catch (e) {
      // 또는
      // throw Exception('데이터를 쓰는 도중 에러가 발생했습니다. Error occurred while writing');
      return Future.error('데이터를 쓰는 도중 에러가 발생했습니다.Error occurred while writing');
    }
  }

}

