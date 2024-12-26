import 'package:uuid/uuid.dart';
import 'department.dart';

const uuid = Uuid();

enum Gender { male, female }

class Student {

  Student({
    required this.firstName,
    required this.lastName,
    required this.department,
    required this.grade,
    required this.gender
  }) : id = uuid.v4();

  String id, firstName, lastName;
  Department department;
  int grade;
  Gender gender;
}