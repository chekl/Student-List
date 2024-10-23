
import 'package:flutter/material.dart';
import 'package:lab_1/models/student.dart';
import 'package:lab_1/widgets/student_list.dart';

class Students extends StatefulWidget {

  const Students({super.key});

  @override
  State<StatefulWidget> createState() {
    return _StudentsState();
  }
}

class _StudentsState extends State<Students> {

  final List<Student>  _myStudents = [
    Student(firstName: 'Andriy', lastName: 'Omelin', department: Department.finance, grade: 4, gender: Gender.male),
    Student(firstName: 'Vladyslava', lastName: 'Chaika', department: Department.it, grade: 4, gender: Gender.female),
    Student(firstName: 'Anastasiia', lastName: 'Hoisak', department: Department.medical, grade: 4, gender: Gender.female),
    Student(firstName: 'Dmytro', lastName: 'Bilash', department: Department.law, grade: 6, gender: Gender.male),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            children: [
              AppBar(title: const Text('Students')),
              Expanded(child: StudentList(students: _myStudents))
            ]
        ),
    );
  }
}