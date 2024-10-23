import 'package:flutter/material.dart';
import 'package:lab_1/models/student.dart';
import 'package:lab_1/widgets/student_item.dart';

class StudentList extends StatelessWidget {
  const StudentList({
    super.key,
    required this.students
  });

  final List<Student> students;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) => StudentItem(student: students[index])
    );
  }
}