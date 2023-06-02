import 'package:hive/hive.dart';
part 'user.g.dart';

@HiveType(typeId: 0)
class User {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String? imagePath;

  User({
    required this.name,
    this.imagePath,
  });
}
