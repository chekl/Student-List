import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lab_1/data/dummy_data.dart';
import '../models/department.dart';
import '../models/student.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StudentsNotifier extends StateNotifier<List<Student>> {
  StudentsNotifier(super.state);

  bool isLoading = false;

  final String firebaseUrl =
      'https://students-4de99-default-rtdb.firebaseio.com/students.json';

  void setLoading(bool loading) {
    isLoading = loading;
    state = [...state];
  }


  Future<void> addStudent(String firstName, String lastName,
      Department department, int grade, Gender gender) async {
    setLoading(true);
    try {
      final url = Uri.parse(firebaseUrl);
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'firstName': firstName,
            'lastName': lastName,
            'department': department.id,
            'grade': grade,
            'gender': gender.toString().split('.').last,
          }));

      if (response.statusCode == 200) {
        final newStudent = Student(
            firstName: firstName,
            lastName: lastName,
            department: department,
            grade: grade,
            gender: gender,
            id: json.decode(response.body)['name']);
        state = [...state, newStudent];
      } else {
        throw Exception('Failed to add student to Firebase');
      }
    } catch (e) {
      throw Exception('Failed to add student: $e');
    } finally {
      setLoading(false);
    }
  }


  Future<void> editStudent(Student student, int index) async {
    setLoading(true);
    try {
      final url = Uri.parse(
          'https://students-4de99-default-rtdb.firebaseio.com/students/${student.id}4536.json');
      final response = await http.patch(url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'firstName': student.firstName,
            'lastName': student.lastName,
            'department': student.department.id,
            'grade': student.grade,
            'gender': student.gender.toString().split('.').last,
          }));

      if (response.statusCode == 200) {
        final updatedState = [...state];
        updatedState[index] = student;
        state = updatedState;
      } else {
        throw Exception('Failed to update student');
      }
    } catch (e) {
      throw Exception('Failed to update student: $e');
    } finally {
      setLoading(false);
    }
  }

  Future<void> fetchStudents() async {
    setLoading(true);
    state = [];
    try {
      final url = Uri.parse(firebaseUrl);
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<Student> loadedStudents = [];

        data.forEach((id, studentData) {
          final department = availableDepartments.firstWhere(
                  (dep) => dep.id == studentData['department']
          );
          final gender = Gender.values.firstWhere(
                  (e) => e.toString().split('.').last == studentData['gender']
          );

          loadedStudents.add(Student(
            id: id,
            firstName: studentData['firstName'],
            lastName: studentData['lastName'],
            department: department,
            grade: studentData['grade'],
            gender: gender,
          ));
        });

        state = loadedStudents;
      } else {
        throw Exception('Failed to fetch students');
      }
    } catch (e) {
      print('Error fetching students: $e');
    } finally {
      setLoading(false);
    }
  }

  Future<void> removeStudent(Student student) async {
    final url = Uri.parse(
        'https://students-4de99-default-rtdb.firebaseio.com/students/${student.id}.json');

    final response = await http.delete(url);

    if (response.statusCode == 200) {
      state = state.where((s) => s.id != student.id).toList();
    } else {
      throw Exception('Failed to remove student');
    }
  }

  void removeStudentLocal(Student student) {
    state = state.where((s) => s.id != student.id).toList();
  }

  void insertStudentLocal(Student student, int index) {
    final newState = [...state];
    newState.insert(index, student);
    state = newState;
  }
}

final studentsProvider =
    StateNotifierProvider<StudentsNotifier, List<Student>>((ref) {
  final notifier = StudentsNotifier([]);
  notifier.fetchStudents();
  return notifier;
});
