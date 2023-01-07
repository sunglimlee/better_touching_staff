import 'package:flutter/material.dart';
import 'package:better_touching_staff/widgets/widgets.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
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
            initialValue: _currentName ?? 'New User',
            decoration: myInputDecoration,
            validator: (val) =>
                val != null && val.isEmpty ? 'Please enter a name' : null,
            onChanged: (val) => setState(() {
              _currentName = val;
            }),
          ),
          const SizedBox(
            height: 20.0,
          ),
          // slider (age),
          Slider(
              label: _currentAge ?? '0', //double.parse((_currentAge ?? '0')).round().toString(),
              value: () {
                return double.parse((_currentAge ?? '0'));
              }(),
              activeColor: (){
                var i = 0;
                // 100 - 900 까지로 변환
                if (int.parse(_currentAge ?? '0') <= 16) {
                  i = 100;
                } else if (int.parse(_currentAge ?? '0') <= 16*2) {
                  i = 200;
                } else if (int.parse(_currentAge ?? '0') <= 16*3) {
                  i = 300;
                } else if (int.parse(_currentAge ?? '0') <= 16*4) {
                  i = 400;
                } else if (int.parse(_currentAge ?? '0') <= 16*5) {
                  i = 500;
                } else if (int.parse(_currentAge ?? '0') <= 16*6) {
                  i = 600;
                } else if (int.parse(_currentAge ?? '0') <= 16*7) {
                  i = 700;
                } else if (int.parse(_currentAge ?? '0') <= 16*8) {
                  i = 800;
                } else {
                  i = 900;
                }
                return Colors.brown[i];}
                (),
              inactiveColor: (){
                var i = 0;
                // 100 - 900 까지로 변환
                if (int.parse(_currentAge ?? '0') <= 16) {
                  i = 100;
                } else if (int.parse(_currentAge ?? '0') <= 16*2) {
                  i = 200;
                } else if (int.parse(_currentAge ?? '0') <= 16*3) {
                  i = 300;
                } else if (int.parse(_currentAge ?? '0') <= 16*4) {
                  i = 400;
                } else if (int.parse(_currentAge ?? '0') <= 16*5) {
                  i = 500;
                } else if(int.parse(_currentAge ?? '0') <= 16*6) {
                  i = 600;
                } else if (int.parse(_currentAge ?? '0') <= 16*7) {
                  i = 700;
                } else if (int.parse(_currentAge ?? '0') <= 16*8) {
                  i = 800;
                } else {
                  i = 900;
                }
                return Colors.brown[i];}
                (),
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
              value: _currentCoupon ?? _couponList[0],
              decoration: myInputDecoration,
              items: _couponList.map((e) {
                return DropdownMenuItem(value: e, child: Text('$e coupons'));
              }).toList(),
              onChanged: (val) => setState(() {
                    _currentCoupon = val;
                  })),

          // button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink[400],
                textStyle: const TextStyle(color: Colors.white)),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                setState(() {
                  loading = true;
                });

                print(_currentName);
                print(_currentAge ?? 'no value');
                print(_currentCoupon ?? 'no value');

                dynamic result = null;
                if (result == null) {
                  setState(() {
                    loading = false;
                    error = 'something wrong';
                  });
                }
              }
            },
            child: const Text('     Update     '),
          ),
        ],
      ),
    );
  }
}
