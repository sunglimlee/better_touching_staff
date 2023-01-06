import 'package:better_touching_staff/model/job_model.dart';
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
    _printJobModels(context);
    return Container();
  }

  // JobModels 프린트 하는 함수
  _printJobModels(BuildContext context) {
    final jobModels = Provider.of<List<JobModel>?>(context);
    if (jobModels != null) {
      for (var jobModel in jobModels) {
        print('name = ${jobModel.name}, age = ${jobModel.age}, coupon = ${jobModel.coupon}');
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
