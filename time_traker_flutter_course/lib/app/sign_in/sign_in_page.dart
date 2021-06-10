import 'package:flutter/material.dart';
import 'package:time_traker_flutter_course/app/sign_in/sign_in_button.dart';
import 'package:time_traker_flutter_course/app/sign_in/social_sign_in_button.dart';
import 'package:time_traker_flutter_course/app/sign_in/email_sign_in_page.dart';
import 'package:time_traker_flutter_course/services/auth_provider.dart';
class SignInPage extends StatelessWidget {

  Future<void> _signInAnonymously(BuildContext context) async{
    try{//에런 catch
      final auth = AuthProvider.of(context);
      await auth.signInAnonymously();
    }catch(e){
      print(e.toString());
    }
  }
  Future<void> _signInWithGoogle(BuildContext context) async{
    try{//에런 catch
      final auth = AuthProvider.of(context);
      await auth.signInWithGoogle();
    }catch(e){
      print(e.toString());
    }
  }
  Future<void> _signInWithFacebook(BuildContext context) async{
    try{//에런 catch
      final auth = AuthProvider.of(context);
      await auth.signInWithFacebook();
    }catch(e){
      print(e.toString());
    }
  }
  void _signInWithEmail(BuildContext context){
    Navigator.of(context).push( //푸시 내비게이션 스택
      MaterialPageRoute<void>(
        fullscreenDialog: true, //새페이지 방향 디폴트는 오른쪽
        builder: (context) => EmailSignInPage(), //EmailSignInPage리턴
      ),
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Tracker'),
        elevation: 2.0, // 앱바 그림자
      ),
      body: _buildContent(context),
      backgroundColor: Colors.grey[200], //백그라운드 컬러
    );
  }
  Widget _buildContent(BuildContext context) { // _ 언더스코어는 private이 된다. 자기 파일에서만 접속가능
    return Padding( //Container대신 return 가능 단 색깔 지정 불가능, 바꿈에도 실행이 가능한 이유는 childe로 Colum을 가지고 있기 때문
      //body는 스카폴드의 하얀색 배경부분 거기에 컨테이너를 추가
      //color: Colors.yellow,//return padding 할경우 색깔 지정 못함
      padding: EdgeInsets.all(16.0), //모든 컨테이너 안에 4방향 padding을 추가
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,//세로 공백
        crossAxisAlignment:
            CrossAxisAlignment.stretch, //children이 가로로 어떻게 나와야하는지 정함
        children: <Widget>[
          Text('Sign in',//Container대신 Text 넣음음
           textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 48.0),
          SocialSignInButton(
            assetName: 'images/google-logo.png',
            text: 'Sign in with Google',
            textColor: Colors.black87,
            color: Colors.white,
            onPressed: ()=> _signInWithGoogle(context),
          ),
          SizedBox(height: 8.0),
          SocialSignInButton(
            assetName: 'images/facebook-logo.png',
            text: 'Sign in with Facebook',
            textColor: Colors.white,
            color: Color(0xFF334D92),
            onPressed: ()=> _signInWithFacebook(context),
          ),
          SizedBox(height: 8.0),
          SignInButton(
            text: 'Sign in with email',
            textColor: Colors.white,
            color: Colors.teal[700],
            onPressed: () => _signInWithEmail(context),
          ),
          SizedBox(height: 8.0),
          Text(
            'or',
            style: TextStyle(fontSize: 14.0, color: Colors.black87),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.0),
          SignInButton(
            text: 'Go anonymous',
            textColor: Colors.black,
            color: Colors.lime[300],
            onPressed: ()=> _signInAnonymously(context),
          ),

        ],
      ),
    );
  }
}
