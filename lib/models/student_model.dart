import 'package:hive/hive.dart';
part 'student_model.g.dart'; 

@HiveType(typeId: 1)
class StudentModel {
  @HiveField(0)
  final DateTime id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String email;
  @HiveField(3)
  final int age;
  @HiveField(4)
  final int contact;

  StudentModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.age,
      required this.contact});
}
