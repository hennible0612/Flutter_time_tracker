

import 'package:flutter/cupertino.dart';
import 'package:time_traker_flutter_course/common_widgets/show_alert_dialog.dart';
import 'package:firebase_core/firebase_core.dart';
Future<void> showExceptionAlertDialog(
  BuildContext context,{
    @required String title,
    @required Exception exception,
}
)=>
    showAlertDialog(
        context,
        title: title,
        content: _message(exception),
        defaultActionText: 'Ok',
    );

String _message(Exception exception){
  if(exception is FirebaseException){//파이어베이스 에러
    return exception.message;
  }
  return exception.toString(); //일반에러
}
