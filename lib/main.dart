import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_app/models/student.dart';
import 'package:student_app/views/home/home_view.dart';
import 'bloc/student_bloc.dart';

void main() async {
  // Initialisation of Hive DB.
  await Hive.initFlutter();
  // Registers custom adapter named "StudentAdapter".
  Hive.registerAdapter(StudentAdapter());
  // Opens the box named "students".
  await Hive.openBox<Student>('students');
  // Opens the box named "user".
  await Hive.openBox('user');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StudentBloc(),
      child: MaterialApp(
        title: 'Student App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePageView(),
      ),
    );
  }
}
