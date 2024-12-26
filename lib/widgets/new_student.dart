import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lab_1/data/dummy_data.dart';
import 'package:lab_1/models/student.dart';
import '../models/department.dart';
import '../providers/students_provider.dart';

class NewStudent extends ConsumerStatefulWidget {
  const NewStudent({super.key, this.student});

  final Student? student;

  @override
  _NewStudentState createState() {
    return _NewStudentState();
  }
}

class _NewStudentState extends ConsumerState<NewStudent> {
  late final _firstNameController =
      TextEditingController(text: widget.student?.firstName ?? '');
  late final _lastNameController =
      TextEditingController(text: widget.student?.lastName ?? '');
  late final _gradeController =
      TextEditingController(text: widget.student?.grade.toString() ?? '');
  Department _selectedDepartment = availableDepartments[0];
  Gender _selectedGender = Gender.female;

  @override
  void initState() {
    super.initState();
    if (widget.student != null) {
      _selectedDepartment = widget.student!.department;
      _selectedGender = widget.student!.gender;
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _gradeController.dispose();
    super.dispose();
  }

  void _submitStudentData() {
    final enteredGrade = int.tryParse(_gradeController.text);
    final gradeIsInvalid =
        enteredGrade == null || enteredGrade <= 0 || enteredGrade > 6;
    final firstNameIsInvalid = _firstNameController.text.trim().isEmpty;
    final lastNameIsInvalid = _lastNameController.text.trim().isEmpty;

    if (gradeIsInvalid || firstNameIsInvalid || lastNameIsInvalid) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text(
              "Please make sure a valid firstName, lastName and grade was entered"),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(ctx), child: const Text('OK'))
          ],
        ),
      );

      return;
    }

    final student = Student(
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      department: _selectedDepartment,
      grade: int.tryParse(_gradeController.text)!,
      gender: _selectedGender,
    );

    if (widget.student != null) {
      ref.read(studentsProvider.notifier).editStudent(
          student, ref.read(studentsProvider).indexOf(widget.student!));
    } else {
      ref.read(studentsProvider.notifier).addStudent(student);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
      child: Column(children: [
        TextField(
          maxLength: 50,
          controller: _firstNameController,
          decoration: const InputDecoration(label: Text('First Name')),
        ),
        TextField(
          maxLength: 50,
          controller: _lastNameController,
          decoration: const InputDecoration(label: Text('Last Name')),
        ),
        TextField(
          maxLength: 1,
          keyboardType: TextInputType.number,
          controller: _gradeController,
          decoration: const InputDecoration(label: Text('Grade')),
        ),
        Row(
          children: [
            Expanded(
              child: DropdownButton<Department>(
                isExpanded: true,
                value: _selectedDepartment,
                items: availableDepartments
                    .map((item) => DropdownMenuItem(
                        value: item,
                        child: Row(
                          children: [Text(item.name), Icon(item.icon)],
                        )))
                    .toList(),
                onChanged: (value) {
                  if (value == null) return;
                  setState(() {
                    _selectedDepartment = value;
                  });
                },
              ),
            ),
            const Spacer(),
            Expanded(
              child: DropdownButton<Gender>(
                isExpanded: true,
                value: _selectedGender,
                items: Gender.values
                    .map((item) =>
                        DropdownMenuItem(value: item, child: Text(item.name)))
                    .toList(),
                onChanged: (value) {
                  if (value == null) return;
                  setState(() {
                    _selectedGender = value;
                  });
                },
              ),
            ),
          ],
        ),
        ElevatedButton(onPressed: _submitStudentData, child: const Text('Save'))
      ]),
    );
  }
}
