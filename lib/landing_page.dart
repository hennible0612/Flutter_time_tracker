import 'package:flutter/material.dart';
import 'package:time_traker_flutter_course/app/sign_in/sign_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:time_traker_flutter_course/home/jobs_page.dart';
import 'package:time_traker_flutter_course/services/auth.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return StreamBuilder<User>(
        stream: auth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {//snapshot은 스트림에서 data를 가지고 있다.
            final User user = snapshot.data;
            if (user == null) { //로그인이 되어있지 않다면
              return SignInPage.create(context); //SignInPage의 onSignIn호출

               //landing_page 자동적으로 SignInPage호출
            }
            return JobsPage(

            ); //로그인이 되어있으면
          }
          return Scaffold(//if문에서 else
              body: Center(
                child: CircularProgressIndicator(),
              )
          );
        },
    );
  }
}









