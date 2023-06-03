// ignore_for_file: unnecessary_null_comparison

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_app/views/add_update/student_create_update.dart';
import 'package:student_app/views/profile/profile_view.dart';
import 'package:student_app/views/student_details/student_detailview.dart';

import '../../bloc/student_bloc.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  String? name;
  String? image;

  @override
  void initState() {
    super.initState();
    var box = Hive.box('user');
    name = box.get('userName');
    image = box.get('profileImage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Welcome, $name",
          style: const TextStyle(color: Colors.black),
        ),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const ProfileView(),
                ),
              ),
              child: CircleAvatar(
                backgroundImage: image != null ? FileImage(File(image!)) : null,
                child: image == null
                    ? const Icon(
                        Icons.person,
                      )
                    : null,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        // Widget used to view the values in DB.
        child:
            BlocBuilder<StudentBloc, StudentState>(builder: (context, state) {
          if (state is StudentInitial) {
            context.read<StudentBloc>().add(GetAllData());
          }
          if (state is ViewAllStudents) {
            if (state.students.isNotEmpty) {
              return ListView.separated(
                itemBuilder: (context, index) {
                  // Stores details of student at current index.
                  // final student = students[index];
                  return ListTile(
                    title: Text(state.students[index].name),
                    leading: CircleAvatar(
                      backgroundImage: state.students[index].imagePath != null
                          ? FileImage(File(state.students[index].imagePath!))
                          : null,
                      child: state.students[index].imagePath! == null
                          ? const Icon(
                              Icons.person,
                            )
                          : null,
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => StudentDetailView(
                            student: state.students[index],
                            index: index,
                          ),
                        ),
                      );
                    },
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: state.students.length,
              );
            }
          }
          return const Center(
            child: Text('List is empty'),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => const StudentCreateUpdateView(
                mode: 1,
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
