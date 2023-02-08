import 'package:better_touching_staff/controllers/auth_controller.dart';
import 'package:better_touching_staff/screens/home/job_list.dart';
import 'package:better_touching_staff/screens/home/settings_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 이것도 wrapper widget 인데 프로그램이 크지 않기 때문에 그냥 stateless 로 하고 BottomSheet 을 사용한다.
class Home extends ConsumerWidget {

  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
      return Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: const Text('Staffan'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: [
            // [3 ways to to create a button with Icon and Text] https://www.flutterbeads.com/button-with-icon-and-text-flutter/
            // setting button
            ElevatedButton.icon(
                // Sign Out
                onPressed: () => _showSettingsPanel(context),
                // ElevatedButton without, no, remove border
                // https://stackoverflow.com/questions/69942023/how-to-remove-border-in-outlinedbutton
                // TODO 나중에 함수나 클래스로 바꿔서 반복하지 말자.
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown[400],
                    elevation: 0,
                    shadowColor: Colors.transparent),
                icon: const Icon(Icons.settings),
                label: const Text('Settings')),
            // logout button
            ElevatedButton.icon(
                // Sign Out
                onPressed: () {
                  final dynamic result = ref.read(authControllerProvider).signOut();
                  result ?? print('Please check with the internet connection');
                },
                // ElevatedButton without, no, remove border
                // https://stackoverflow.com/questions/69942023/how-to-remove-border-in-outlinedbutton
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown[400],
                    elevation: 0,
                    shadowColor: Colors.transparent),
                icon: const Icon(Icons.person),
                label: const Text('SignOut')),
          ],
        ),
        // ListView 를 보여줄건데 이렇게만 해도 전체를 덮어버리네..
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover,
            )
          ),
            child: const JobList()),
      );
  }

  void _showSettingsPanel(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: const SettingsForm(),
          );
        });
  }
}
