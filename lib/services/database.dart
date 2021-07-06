//database.dart
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:time_traker_flutter_course/home/models/job.dart';
import 'APIPath.dart';

abstract class Database{
  Future<void> createJob(Job job);
  void jobsStream();
}

class FirestoreDatabase implements Database{
  FirestoreDatabase({@required this.uid}) : assert(uid != null);
  final String uid;

  Future<void> createJob(Job job) => _setData(
      path: APIPath.job(uid,'job_abc'),
      data: job.toMap(),
    );

  Stream<List<Job>> jobsStream(){
    final path = APIPath.jobs(uid);
    final reference = FirebaseFirestore.instance.collection(path);
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot)=> snapshot.docs.map( //map 사용해서 list만듬
        (snapshot){
          final data = snapshot.data(); //각각 job을 넣음음
            return data != null ? Job( //null이 아닐시 아래 데이터 job으로
            name: data['name'],
            ratePerHour: data['ratePerHour'],
          ): null;
        }
    ));
  }

  Future<void> _setData({String path, Map<String, dynamic>data}) async{
    final reference = FirebaseFirestore.instance.doc(path);
    print('$path: $data');
    await reference.set(data);
  }
}