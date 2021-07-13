//database.dart
import 'package:flutter/cupertino.dart';
import 'package:time_traker_flutter_course/home/models/job.dart';
import 'APIPath.dart';
import 'dart:async';

import 'firestore_service.dart';

abstract class Database{
  Future<void> createJob(Job job);
  Stream<List<Job>> jobsStream();
}

class FirestoreDatabase implements Database {
  FirestoreDatabase({@required this.uid}) : assert(uid != null);
  final String uid;

  final _service = FirestoreService.instance;

  Future<void> createJob(Job job) =>
      _service.setData(
        path: APIPath.job(uid, 'job_abc'),
        data: job.toMap(),
      );

  Stream<List<Job>> jobsStream() =>
      _service.collectionStream(
        path: APIPath.jobs(uid),
        builder: (data) => Job.fromMap(data),
      );


}
