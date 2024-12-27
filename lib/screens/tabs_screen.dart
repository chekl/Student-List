import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lab_1/models/department.dart';
import 'package:lab_1/providers/departments_provider.dart';
import 'package:lab_1/widgets/department_grid_item.dart';
import 'package:lab_1/widgets/students.dart';
import 'package:lab_1/providers/students_provider.dart';

import '../models/student.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    ref.read(studentsProvider.notifier).fetchStudents();
  }

  @override
  Widget build(BuildContext context) {
    final dummyDepartments = ref.watch(departmentsProvider);
    final students = ref.watch(studentsProvider);
    final isLoading =
        ref.watch(studentsProvider.notifier.select((state) => state.isLoading));

    void callUndo(Student student) {
      final studentIndex = students.indexOf(student);

      final notifier = ref.read(studentsProvider.notifier);
      notifier.removeStudentLocal(student);

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context)
          .showSnackBar(
            SnackBar(
              duration: const Duration(seconds: 3),
              content: const Text("Student was deleted"),
              action: SnackBarAction(
                label: "Undo",
                onPressed: () {
                  notifier.insertStudentLocal(student, studentIndex);
                },
              ),
            ),
          )
          .closed
          .then((value) {
        if (value != SnackBarClosedReason.action) {
          notifier.removeStudent(student);
        }
      });
    }

    void selectDepartment(BuildContext context, Department department) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (ctx) =>
                  Students(department: department, onUndo: callUndo)));
    }

    List<Widget> content = [
      isLoading
          ? const Center(child: CircularProgressIndicator())
          : GridView(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20),
              children: [
                for (final department in dummyDepartments)
                  DepartmentGridItem(
                    department: department,
                    onSelectDepartment: () {
                      selectDepartment(context, department);
                    },
                  )
              ],
            ),
      Students(onUndo: callUndo)
    ];

    return Scaffold(
        appBar: _selectedIndex == 0
            ? AppBar(
                title: const Text("Departments"),
              )
            : null,
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            backgroundColor: Theme.of(context).primaryColor,
            selectedItemColor: Theme.of(context).cardColor,
            elevation: 0,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Departments',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people),
                label: 'Students',
              ),
            ]),
        body: content[_selectedIndex]);
  }
}
