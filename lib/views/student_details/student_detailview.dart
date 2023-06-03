import 'dart:io';
import 'package:flutter/material.dart';
import 'package:student_app/models/student.dart';
import 'package:student_app/views/add_update/student_create_update.dart';

class StudentDetailView extends StatelessWidget {
  final Student student;
  final int index;
  const StudentDetailView({
    super.key,
    required this.student,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => StudentCreateUpdateView(
                    mode: 2,
                    student: student,
                    index: index,
                  ),
                ),
              );
            },
            child: const Text(
              "Edit",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: student.imagePath != null
                ? FileImage(File(student.imagePath!))
                : null,
            child: student.imagePath == null
                ? const Icon(
                    Icons.person,
                  )
                : null,
          ),
          const SizedBox(
            height: 20,
          ),

          //student details page
          Card(
            child: SizedBox(
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: "Name: ",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        TextSpan(
                          text: student.name,
                          style: const TextStyle(
                              color: Colors.black87, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: "Age: ",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        TextSpan(
                          text: student.age.toString(),
                          style: const TextStyle(
                              color: Colors.black87, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: "Phone: ",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        TextSpan(
                          text: student.phone.toString(),
                          style: const TextStyle(
                              color: Colors.black87, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: "Email: ",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        TextSpan(
                          text: student.email,
                          style: const TextStyle(
                              color: Colors.black87, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
