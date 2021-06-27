import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'email_sign_in_form_stateful.dart';

class EmailSignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in'),
        elevation: 2.0, // 앱바 그림자
      ),
      body: SingleChildScrollView(
        child: Padding( //패딩 추가
          padding: const EdgeInsets.all(16.0),
          child: Card(
            child: EmailSignInFormStateful(),
          ),
        ),
      ),
      backgroundColor: Colors.grey[200], //백그라운드 컬러
    );
  }
}


