import 'package:flutter/material.dart';
import 'package:lab_1/models/student.dart';
import 'package:lab_1/widgets/new_student.dart';
import 'package:lab_1/widgets/student_list.dart';

class Students extends StatefulWidget {
  const Students({super.key});

  @override
  State<StatefulWidget> createState() {
    return _StudentsState();
  }
}

class _StudentsState extends State<Students> {
  final List<Student> _myStudents = [
    Student(
        firstName: 'Andriy',
        lastName: 'Omelin',
        department: Department.finance,
        grade: 4,
        gender: Gender.male),
    Student(
        firstName: 'Vladyslava',
        lastName: 'Chaika',
        department: Department.it,
        grade: 4,
        gender: Gender.female),
    Student(
        firstName: 'Anastasiia',
        lastName: 'Hoisak',
        department: Department.medical,
        grade: 4,
        gender: Gender.female),
    Student(
        firstName: 'Dmytro',
        lastName: 'Bilash',
        department: Department.law,
        grade: 6,
        gender: Gender.male),
  ];

  void _addStudent(Student student) {
    setState(() {
      _myStudents.add(student);
    });
  }

  void _editStudent(Student student) {
    int index = _myStudents.indexWhere((std) => std.id == student.id);
    setState(() {
      _myStudents[index] = student;
    });
  }

  void _openAddStudentOverlay() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewStudent(onAdd: _addStudent));
  }

  void _openEditStudentOverlay(Student student) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewStudent(onAdd: _editStudent, student: student));
  }

  void _removeStudent(Student student) {
    final studentIndex = _myStudents.indexOf(student);

    setState(() {
      _myStudents.remove(student);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text("Student was deleted"),
        action: SnackBarAction(
            label: "Undo",
            onPressed: () => {
                  setState(() {
                    _myStudents.insert(studentIndex, student);
                  })
                })));
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(child: Text('No students was found'));

    if (_myStudents.isNotEmpty) {
      mainContent =
          StudentList(students: _myStudents, onRemoveStudent: _removeStudent, onEditStudent: _openEditStudentOverlay);
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Students'), actions: [
        IconButton(
            onPressed: _openAddStudentOverlay, icon: const Icon(Icons.add))
      ]),
      body: Column(children: [Expanded(child: mainContent)]),
    );
  }
}
