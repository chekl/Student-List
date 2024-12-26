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
  final void Function() onUndo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void removeStudent(Student student) {
      final studentIndex = students.indexOf(student);

      ref.read(studentsProvider.notifier).removeStudent(student);

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text("Student was deleted"),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            ref.read(studentsProvider.notifier).insertStudent(student, studentIndex);
          },
        ),
      ));
    }
    return ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) => Dismissible(
            key: ValueKey(students[index]),
            background: Container(color: Colors.red[900]
            ),
            onDismissed: (direction) => {
              removeStudent(students[index]),
              onUndo()
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
