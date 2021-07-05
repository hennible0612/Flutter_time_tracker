//database.dart
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:time_traker_flutter_course/home/models/job.dart';
import 'APIPath.dart';

abstract class Database{
  Future<void> createJob(Job job);
}

class FirestoreDatabase implements Database{
  FirestoreDatabase({@required this.uid}) : assert(uid != null);
  final String uid;

  Future<void> createJob(Job job) => _setData(
      path: APIPath.job(uid,'job_abc'),
      data: job.toMap(),
    );
  }

  Future<void> _setData({String path, Map<String, dynamic>data}) async{
    final reference = FirebaseFirestore.instance.doc(path);
    print('$path: $data');
    await reference.set(data);
  }
