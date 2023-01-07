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
            backgroundColor: Colors.brown[
                _jobModel?.coupon != null ? int.parse(_jobModel!.coupon!) : 200],
          ),
          title: Text(_jobModel?.name ?? 'New User'),
          subtitle: Text(_jobModel?.age != null
              ? '${_jobModel!.age!.toString()} years old.'
              : '0 years old.'),
        ),
      ),
    );
  }
}
