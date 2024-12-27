import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lab_1/models/student.dart';
import 'package:lab_1/widgets/student_item.dart';

import '../providers/students_provider.dart';

class StudentList extends ConsumerWidget {
  const StudentList({super.key, required this.students,
  required this.onEditStudent,
    required this.onUndo
  });

  final List<Student> students;

  final void Function(Student student) onEditStudent;
  final void Function(Student student) onUndo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) => Dismissible(
            key: ValueKey(students[index]),
            background: Container(color: Colors.red[900]
            ),
            onDismissed: (direction) => {
              onUndo(students[index])
            },
            child: InkWell(
              key: ValueKey(students[index]),
              child: StudentItem(student: students[index]),
              onTap: () { onEditStudent(students[index]); }
            )
        )
    );
  }
}
