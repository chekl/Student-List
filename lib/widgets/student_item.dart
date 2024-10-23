import 'package:flutter/material.dart';
import '../models/student.dart';

class StudentItem extends StatelessWidget {
  const StudentItem({super.key, required this.student});

  final Student student;

  @override
  Widget build(BuildContext context) {
    return Card(
      color:
          student.gender == Gender.female ? Colors.pink[50] : Colors.teal[50],
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 16.0,
        ),
        child: Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${student.firstName} ${student.lastName}'),
              ],
            ),
            Row(
              children: [
                Icon(departmentIcons[student.department]),
                Text(student.grade.toString())
              ],
            ),
          ],
        ),
      ),
    );
  }
}
