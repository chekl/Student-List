import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/student.dart';
import 'departments_provider.dart';


class StudentsNotifier extends StateNotifier<List<Student>> {
  StudentsNotifier(super.state);

  Student? _lastDeletedStudent;
  int? _lastDeletedIndex;

  void addStudent(Student student) {
    state = [...state, student];
  }

  void editStudent(Student student, int index) {
    final newState = [...state];
    newState[index].firstName = student.firstName;
    newState[index].lastName = student.lastName;
    newState[index].department = student.department;
    newState[index].gender = student.gender;
    newState[index].grade = student.grade;

    state = newState;
  }

  void insertStudent(Student student, int index) {
    final newState = [...state];
    newState.insert(index, student);
    state = newState;
  }

  void removeStudent(Student student) {
    _lastDeletedStudent = student;
    _lastDeletedIndex = state.indexOf(student);
    state = state.where((m) => m.id != student.id).toList();
  }

  void undoRemoveStudent() {
    if (_lastDeletedStudent != null && _lastDeletedIndex != null) {
      final newState = [...state];
      newState.insert(_lastDeletedIndex!, _lastDeletedStudent!);
      state = newState;
      _lastDeletedStudent = null;
      _lastDeletedIndex = null;
    }
  }
}


final studentsProvider =
StateNotifierProvider<StudentsNotifier, List<Student>>((ref) {
  final departments = ref.read(departmentsProvider);


  return StudentsNotifier([
    Student(
        firstName: 'Andriy',
        lastName: 'Omelin',
        department: departments[1],
        grade: 4,
        gender: Gender.male),
    Student(
        firstName: 'Vladyslava',
        lastName: 'Chaika',
        department: departments[0],
        grade: 4,
        gender: Gender.female),
    Student(
        firstName: 'Anastasiia',
        lastName: 'Hoisak',
        department: departments[3],
        grade: 4,
        gender: Gender.female),
    Student(
        firstName: 'Dmytro',
        lastName: 'Bilash',
        department: departments[2],
        grade: 6,
        gender: Gender.male),
  ]);
});
