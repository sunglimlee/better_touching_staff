import 'package:better_touching_staff/controllers/database_controller.dart';
import 'package:better_touching_staff/screens/home/job_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class JobList extends ConsumerStatefulWidget {
  const JobList({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _JobListState();
}

class _JobListState extends ConsumerState<JobList> {
  @override
  Widget build(BuildContext context) {
    //_printJobModels(context);
    return _showListViewJobModels(context);
    //return Container();
  }

  // JobModels ListView 로 보여주는 함수
  _showListViewJobModels(BuildContext context) {
    // 리스트가 null 일 수 있으니깐 초기화를 시켜준다. 데이터의 흐름이다. 초기화와 종결화가 아주 중요하다.
    //final jobModels = Provider.of<List<JobModel>?>(context) ?? [];
    final jobModelsWatch = ref.watch(jobList);

    return ListView.builder(
      itemCount: jobModelsWatch.value?.length ?? 0,
      // 이게 100% 이해되네.. jobModels 는 null 이 될 수 있고 그래서 null 이면 0 을 출력해라는 거지..
      itemBuilder: (BuildContext context, int index) {
        return JobTile(jobModel: jobModelsWatch.value?[index]);
      },
    );
  }

  // JobModels 프린트 하는 함수
  _printJobModels(BuildContext context) {
    //final jobModels = Provider.of<List<JobModel>?>(context);
    final jobModelsWatch = ref.watch(jobList);
    if (jobModelsWatch.value != null) {
      for (var jobModel in jobModelsWatch.value!) { // 위에서 null 아니라고 했으니깐 ! 를 사용할 수 있지.
        print(
            'name = ${jobModel.name}, age = ${jobModel.age}, coupon = ${jobModel.coupon}');
      }
      // List 이기 때문에 forEach 사용도 가능하지..
      /*
      jobModels!.forEach((jobModel) {
        print(
            'name = ${jobModel.name}, age = ${jobModel.age}, coupon = ${jobModel
                .coupon}');
      });
      */
    }
  }
}
