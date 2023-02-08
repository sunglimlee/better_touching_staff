import 'package:better_touching_staff/controllers/auth_controller.dart';
import 'package:better_touching_staff/controllers/database_controller.dart';
import 'package:better_touching_staff/model/current_user_job_model.dart';
import 'package:better_touching_staff/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:better_touching_staff/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsForm extends ConsumerStatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _SettingsFormState();
}

class _SettingsFormState extends ConsumerState<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _couponList = ['0', '100', '200', '300', '400', '500'];

  // form values
  String? _currentName;
  String? _currentAge;
  String? _currentCoupon;
  bool loading = false;
  String error = '';

  @override
  Widget build(BuildContext context) {
    //final user = Provider.of<User>(context);
    final user = ref.watch(userStreamProvider);
    // 희한하게도 currentUserJobModel 이 그대로 유지되고 있다. 그래서 dispose 가 필요한건가?
    final currentUser = ref.watch(currentUserJobModel);
    return currentUser.when(data: (data) {
        return Form(
          key: _formKey,
          child: Column(
            children: [
              const Text(
                'Update your Job setting.',
                style: TextStyle(fontSize: 18.0),
              ),
              const SizedBox(
                height: 20.0,
              ),
              // (name)
              TextFormField(
                initialValue: _currentName ??
                    data.name.toString(),
                decoration: myInputDecoration,
                validator: (val) => val != null && val.isEmpty
                    ? 'Please enter a name'
                    : null,
                onChanged: (val) => setState(() {
                  _currentName = val;
                }),
              ),
              const SizedBox(
                height: 20.0,
              ),
              // slider (age),
              Slider(
                  label: _currentAge ??
                      data.age.toString(),
                  //double.parse((_currentAge ?? '0')).round().toString(),
                  value: () {
                    return double.parse((_currentAge ??
                        data.age.toString()));
                  }(),
                  activeColor: () {
                    _currentAge ??=
                        data.age.toString();
                    var i = 0;
                    // 100 - 900 까지로 변환
                    if (int.parse(_currentAge ?? '0') <= 16) {
                      i = 100;
                    } else if (int.parse(_currentAge ?? '0') <= 16 * 2) {
                      i = 200;
                    } else if (int.parse(_currentAge ?? '0') <= 16 * 3) {
                      i = 300;
                    } else if (int.parse(_currentAge ?? '0') <= 16 * 4) {
                      i = 400;
                    } else if (int.parse(_currentAge ?? '0') <= 16 * 5) {
                      i = 500;
                    } else if (int.parse(_currentAge ?? '0') <= 16 * 6) {
                      i = 600;
                    } else if (int.parse(_currentAge ?? '0') <= 16 * 7) {
                      i = 700;
                    } else if (int.parse(_currentAge ?? '0') <= 16 * 8) {
                      i = 800;
                    } else {
                      i = 900;
                    }
                    return Colors.brown[i];
                  }(),
                  inactiveColor: () {
                    var i = 0;
                    // 100 - 900 까지로 변환
                    // [issue] Invalid radix-10 number (at character 1) null ^
                    // [answer] https://stackoverflow.com/questions/70206285/invalid-radix-10-number-at-character-1-null/70206418
                    if (int.parse(_currentAge ?? '0') <= 16) {
                      i = 100;
                    } else if (int.parse(_currentAge ?? '0') <= 16 * 2) {
                      i = 200;
                    } else if (int.parse(_currentAge ?? '0') <= 16 * 3) {
                      i = 300;
                    } else if (int.parse(_currentAge ?? '0') <= 16 * 4) {
                      i = 400;
                    } else if (int.parse(_currentAge ?? '0') <= 16 * 5) {
                      i = 500;
                    } else if (int.parse(_currentAge ?? '0') <= 16 * 6) {
                      i = 600;
                    } else if (int.parse(_currentAge ?? '0') <= 16 * 7) {
                      i = 700;
                    } else if (int.parse(_currentAge ?? '0') <= 16 * 8) {
                      i = 800;
                    } else {
                      i = 900;
                    }
                    return Colors.brown[i];
                  }(),
                  min: 0.0,
                  max: 150.0,
                  divisions: 150,
                  // 그냥 빼주면 되네.
                  onChanged: (val) {
                    setState(() {
                      //print('_currentAge 의 값은 ${_currentAge}');
                      _currentAge = val.round().toString();
                    });
                  }),
              // dropdown (coupon)
              DropdownButtonFormField(
                  value: _currentCoupon ??
                      data.coupon.toString(),
                  decoration: myInputDecoration,
                  items: _couponList.map((e) {
                    return DropdownMenuItem(
                        value: e, child: Text('$e coupons'));
                  }).toList(),
                  validator: (val) => val != null && val.isEmpty
                      ? 'Please choose the coupon amount'
                      : null,
                  onChanged: (val) => setState(() {
                    _currentCoupon = val;
                  })),

              // button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink[400],
                    textStyle: const TextStyle(color: Colors.white)),
                onPressed: () async {
                  // validate 했는데???? Slider 때문에 여전히 null 값 체크를 해주어야 한다.
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      loading = true;
                    });

                    print(_currentName ??
                        data.name.toString());
                    print(_currentAge ??
                        data.age.toString());
                    print(_currentCoupon ??
                        data.coupon.toString());

                    // 데이터 저장 부분
                    // [issue] 예외처리, Exception, Future, error 해결법
                    // https://stackoverflow.com/questions/54474689/how-do-i-return-error-from-a-future-in-dart
                    CurrentUserJobModel currentUserJobModel =
                    CurrentUserJobModel(
                        uid: user.value!.uid,
                        name: _currentName ??
                            data.name
                                .toString(),
                        coupon: _currentCoupon ??
                            data.coupon
                                .toString(),
                        age: _currentAge ??
                            data.age
                                .toString());
                    // .whenComplete() 함수도 이제 알고 그걸 이용해서 Navigator.pop(context) 사용한것도 좋고... 많이 늘었네..!!!!!
                    await DatabaseService(user: user.value)
                        .modifyDocumentFromSettingFormWithCurrentUserJobModel(
                        currentUserJobModel)
                        .catchError((e) => print(e))
                        .whenComplete(() => Navigator.pop(context));
                  }
                },
                child: const Text('     Update     '),
              ),
            ],
          ),
        );

    },
        error: (error, stackTrace) => const Center(child: Text("에러가 발생했습니다."),), 
        loading: () {return const Center(child: CircularProgressIndicator());});
  }
}
