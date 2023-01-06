import 'package:better_touching_staff/model/job_model.dart';
import 'package:better_touching_staff/screens/home/job_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JobList extends StatefulWidget {
  const JobList({Key? key}) : super(key: key);

  @override
  State<JobList> createState() => _JobListState();
}

class _JobListState extends State<JobList> {
  @override
  Widget build(BuildContext context) {
    //_printJobModels(context);
    return _showListViewJobModels(context);
    //return Container();
  }

  // JobModels ListView 로 보여주는 함수
  _showListViewJobModels(BuildContext context) {
    final jobModels = Provider.of<List<JobModel>?>(context);
    return ListView.builder(
      itemCount: jobModels?.length ?? 0,
      // 이게 100% 이해되네.. jobModels 는 null 이 될 수 있고 그래서 null 이면 0 을 출력해라는 거지..
      itemBuilder: (BuildContext context, int index) {
        return JobTile(jobModel: jobModels?[index]);
      },
    );
  }

  // JobModels 프린트 하는 함수
  _printJobModels(BuildContext context) {
    final jobModels = Provider.of<List<JobModel>?>(context);
    if (jobModels != null) {
      for (var jobModel in jobModels) {
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
