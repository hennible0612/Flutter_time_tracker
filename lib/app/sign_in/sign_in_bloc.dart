
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:time_traker_flutter_course/services/auth.dart';

class SignInBloc{
  SignInBloc({@required this.auth, @required this.isLoading});
  final AuthBase auth;
  final ValueNotifier<bool> isLoading;


  Future<User> _signIn(Future<User> Function() signInMethod) async{ //User리턴
    try{
      isLoading.value = true;
      return await signInMethod();
    }catch(e){
      isLoading.value = false;
      rethrow;
    }
  }
  Future<User> signInAnonymously() async => await _signIn(auth.signInAnonymously);
  Future<User> signInWithGoogle() async => await _signIn(auth.signInWithGoogle);
  Future<User> signInWithFacebook() async => await _signIn(auth.signInWithFacebook);
}