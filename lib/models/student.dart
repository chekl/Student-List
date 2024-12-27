import 'department.dart';

enum Gender { male, female }

class Student {

  Student({
    required this.firstName,
    required this.lastName,
    required this.department,
    required this.grade,
    required this.gender,
    required this.id
  });

  String id;
  String firstName, lastName;
  Department department;
  int grade;
  Gender gender;
}