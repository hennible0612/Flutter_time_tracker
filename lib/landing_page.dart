import 'package:flutter/material.dart';
import 'package:time_traker_flutter_course/app/sign_in/sign_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:time_traker_flutter_course/home/jobs_page.dart';
import 'package:time_traker_flutter_course/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:time_traker_flutter_course/services/database.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return StreamBuilder<User>(
        stream: auth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final User user = snapshot.data;
            if (user == null) { //로그인이 되어있지 않다면
              return SignInPage.create(context);
            }
            
            return Provider<Database>(
              create: (_) => FirestoreDatabase(uid: user.uid),
              child: JobsPage(),
            );
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









