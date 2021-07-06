import 'package:flutter/material.dart';
import 'package:time_traker_flutter_course/common_widgets/show_alert_dialog.dart';
import 'package:time_traker_flutter_course/common_widgets/show_exception_alert_dialog.dart';
import 'package:time_traker_flutter_course/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:time_traker_flutter_course/services/database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'models/job.dart';

class JobsPage extends StatelessWidget {
  Future<void> _signOut(BuildContext context) async{
    try{//에런 catch
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signOut();
    }catch(e){
      print(e.toString());
    }
  }
  Future<void> _confirmSignOut(BuildContext context) async {
    final database = Provider.of<Database>(context, listen: false);
    database.jobsStream();


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

  Future<void> _createJob(BuildContext context) async {
    try{
      final database = Provider.of<Database>(context, listen: false);
      await database.createJob(Job(name: 'Blogging', ratePerHour: 10));
    } on FirebaseException catch(e){
      showExceptionAlertDialog(
        context,
        title: 'Operation failed',
        exception: e,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jobs'),
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
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _createJob(context),
      )
    );
  }
}


