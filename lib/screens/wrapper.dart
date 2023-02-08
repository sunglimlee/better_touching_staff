import 'package:better_touching_staff/screens/authenticate/authenticate.dart';
import 'package:better_touching_staff/screens/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/auth_controller.dart';

/// 조건 분기가 될 위젯이다. 중요한 사살은 이 wrapper 클래스는 Provider 에 대한 내용만 보고 분기를 한다.
class Wrapper extends ConsumerWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 잘봐라. 변수를 만들 때 null 이 들어가는지 계속 확인해야 한다.
    final userStreamProviderWatch = ref.watch(userStreamProvider);
    // return either Home or Authenticate widget
    return Container(
      alignment: Alignment.center,
      child:
          userStreamProviderWatch.value == null ? const Authenticate() : Home(),
    );
  }
}
