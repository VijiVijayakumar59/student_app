import 'package:hive/hive.dart';
part 'student.g.dart';

@HiveType(typeId: 0)
class Student {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final int age;

  @HiveField(2)
  final int phone;

  @HiveField(3)
  final String email;

  @HiveField(4)
  final String? imagePath;

  Student({
    required this.name,
    required this.age,
    required this.phone,
    required this.email,
    required this.imagePath,
  });
}
