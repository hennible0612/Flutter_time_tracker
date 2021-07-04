
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:time_traker_flutter_course/home/models/job.dart';
abstract class Database{
  Future<void> createJob(Job job);
}

class FirestoreDatabase implements Database{
  FirestoreDatabase({@required this.uid}) : assert(uid != null);
  final String uid;

  Future<void> createJob(Job job) async{
    final path = '/users/$uid/jobs/job_abc'; //위치
    final documentReference = FirebaseFirestore.instance.doc(path);
    await documentReference.set(job.toMap()); //위치에 데이터 넣음
  }
}