import 'package:flutter/material.dart';

import 'auth.dart';

class AuthProvider extends InheritedWidget{
  AuthProvider({@required this.auth, @required this.child});
  final AuthBase auth;
  final Widget child;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  static AuthBase of(BuildContext context){ //생성자
    AuthProvider provider = context.dependOnInheritedWidgetOfExactType<AuthProvider>();
    return provider.auth;
  }

}