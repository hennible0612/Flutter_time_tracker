
import 'package:flutter/cupertino.dart';

class Job{
  Job({@required this.name, @required this.ratePerHour});
  final String name;
  final int ratePerHour;

  Map<String, dynamic> toMap(){
    return {
      'name': name,
      'ratePerHour': ratePerHour,
    };
  }
}