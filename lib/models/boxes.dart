import 'package:hive/hive.dart';
import 'package:student_app/models/student.dart';

class StudentBox {
  static Box<Student> getstudentData() => Hive.box<Student>('student_db');
}
