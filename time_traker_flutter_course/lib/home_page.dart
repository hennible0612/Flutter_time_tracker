import 'package:flutter/material.dart';
import 'package:time_traker_flutter_course/common_widgets/show_alert_dialog.dart';
import 'package:time_traker_flutter_course/services/auth_provider.dart';
class HomePage extends StatelessWidget {
  Future<void> _signOut(BuildContext context) async{
    try{//에런 catch
      final auth = AuthProvider.of(context);
      await auth.signOut();
    }catch(e){
      print(e.toString());
    }
  }
  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await showAlertDialog(
      context,
      title: 'Logout',
      content: 'Are you sure that you want to logout? ',
      cancelActionText: 'Cancel',
      defaultActionText: 'Logout',
    );
    if (didRequestSignOut == true){
      _signOut(context);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          FlatButton(
            child: Text('Logout',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                )
            ),
            onPressed:() => _confirmSignOut(context),
          ),
        ],
      )

    );
  }
}
