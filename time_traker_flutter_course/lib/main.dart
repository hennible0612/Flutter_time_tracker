import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:time_traker_flutter_course/landing_page.dart';
import 'package:time_traker_flutter_course/services/auth.dart';
import 'package:time_traker_flutter_course/services/auth_provider.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); //future //firebase 기다림 //await 기다려랴라 단 메서드가 async여야함
  runApp(MyApp()); //메인 함수 MyApp 실행

}

class MyApp extends StatelessWidget {
  @override //statelessWidget 을 오버라이드
  Widget build(BuildContext context) {
    return AuthProvider(
      auth: Auth(),
       child: MaterialApp( //위젯
      title: 'time Tracker',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: LandingPage(

      ), //LandingPage가 sign_in_page호출
      ),
    );
  }
}


