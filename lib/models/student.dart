import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum Department { finance, law, it, medical }

const departmentIcons = {
  Department.finance: Icons.currency_bitcoin,
  Department.it: Icons.computer,
  Department.law: Icons.menu_book,
  Department.medical: Icons.medical_services
};
 // cruelty_free_outlined

enum Gender { male, female }

class Student {

  Student({
    required this.firstName,
    required this.lastName,
    required this.department,
    required this.grade,
    required this.gender
  }) : id = uuid.v4();

  final String id, firstName, lastName;
  final Department department;
  final int grade;
  final Gender gender;
}