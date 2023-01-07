import 'package:better_touching_staff/model/job_model.dart';
import 'package:flutter/material.dart';

//ignore: must_be_immutable
class JobTile extends StatelessWidget {
  late JobModel? _jobModel;

  JobTile({Key? key, JobModel? jobModel}) : super(key: key) {
    _jobModel = jobModel;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 0),
        child: ListTile(
          leading: CircleAvatar(
              radius: 25.0,
              // 지금 age 로 strength 를 맞추려고 억지로 * 10, round() 함수까지 사용했다.
              backgroundColor: () {
                var i = 0;
                // 100 - 900 까지로 변환
                if (int.parse(_jobModel?.age ?? '0') <= 16) {
                  i = 100;
                } else if (int.parse(_jobModel?.age ?? '0') <= 16 * 2) {
                  i = 200;
                } else if (int.parse(_jobModel?.age ?? '0') <= 16 * 3) {
                  i = 300;
                } else if (int.parse(_jobModel?.age ?? '0') <= 16 * 4) {
                  i = 400;
                } else if (int.parse(_jobModel?.age ?? '0') <= 16 * 5) {
                  i = 500;
                } else if (int.parse(_jobModel?.age ?? '0') <= 16 * 6) {
                  i = 600;
                } else if (int.parse(_jobModel?.age ?? '0') <= 16 * 7) {
                  i = 700;
                } else if (int.parse(_jobModel?.age ?? '0') <= 16 * 8) {
                  i = 800;
                } else {
                  i = 900;
                }
                return Colors.brown[i];
              }()),
          title: Text(_jobModel?.name ?? 'New User'),
          subtitle: Text(_jobModel?.age != null
              ? '${_jobModel!.age!.toString()} years old.'
              : '0 years old.'),
          trailing: Text(_jobModel?.coupon ?? 'Coupon no exists.'),
        ),
      ),
    );
  }
}
