import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lab_1/models/department.dart';
import 'package:lab_1/providers/students_provider.dart';

class DepartmentGridItem extends ConsumerWidget {
  const DepartmentGridItem({super.key, required this.department, required this.onSelectDepartment});

  final Department department;
  final void Function() onSelectDepartment;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dummyStudents = ref.watch(studentsProvider).where((std) => std.department.id == department.id).toList();

    return  InkWell(
      onTap: onSelectDepartment,
      splashColor: Theme.of(context).primaryColor,
      child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          department.color.withOpacity(0.55),
          department.color.withOpacity(0.9),
        ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(department.name, style: Theme.of(context).textTheme.titleLarge!),
          Text("Number of students: ${dummyStudents.length}"),
          Align(
            alignment: Alignment.centerRight,
            child: Icon(department.icon),
          ),
        ],
      )
    ),
    );
  }
}