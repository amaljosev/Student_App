import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../models/student_model.dart';

class StudentData extends ChangeNotifier { 
  List<StudentModel> students = [];

  Future<void> addStudent(StudentModel student) async {
    final studentDB = await Hive.openBox<StudentModel>('studentDb');
    students.add(student);
    await studentDB.add(student);
    notifyListeners();
  }

  Future<void> getStudent() async {
    final studentDB = await Hive.openBox<StudentModel>('studentDb');
    students.clear();
    students.addAll(studentDB.values);
    notifyListeners();
  }

  Future<void> deleteStudent(int index) async {
    final studentDB = await Hive.openBox<StudentModel>('studentDb');
    await studentDB.deleteAt(index);
    getStudent();
  }

  Future<void> editStudent(int index, StudentModel student) async {
    final studentDB = await Hive.openBox<StudentModel>('studentDb');
    await studentDB.putAt(index, student);
    getStudent();
    notifyListeners();
  }
}