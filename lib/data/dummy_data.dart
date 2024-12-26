import 'package:lab_1/models/department.dart';
import 'package:flutter/material.dart';

import 'package:lab_1/models/student.dart';

const availableDepartments = [
  Department(id: "1", name: "It", icon: Icons.computer, color: Colors.pink),
  Department(id: "2", name: "Finance", icon: Icons.currency_bitcoin, color: Colors.blue),
  Department(id: "3", name: "Law", icon: Icons.menu_book, color: Colors.green),
  Department(id: "4", name: "Medical", icon: Icons.medical_services, color: Colors.yellow),
];

var students = [
  Student(
      firstName: 'Andriy',
      lastName: 'Omelin',
      department: availableDepartments[1],
      grade: 4,
      gender: Gender.male),
  Student(
      firstName: 'Vladyslava',
      lastName: 'Chaika',
      department: availableDepartments[0],
      grade: 4,
      gender: Gender.female),
  Student(
      firstName: 'Anastasiia',
      lastName: 'Hoisak',
      department: availableDepartments[3],
      grade: 4,
      gender: Gender.female),
  Student(
      firstName: 'Dmytro',
      lastName: 'Bilash',
      department: availableDepartments[2],
      grade: 6,
      gender: Gender.male),
];