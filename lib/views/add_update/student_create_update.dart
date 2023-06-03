// ignore_for_file: avoid_print, use_build_context_synchronously, no_leading_underscores_for_local_identifiers, body_might_complete_normally_nullable
import 'dart:io';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_app/bloc/student_bloc.dart';
import 'package:student_app/models/student.dart';
import 'package:student_app/views/home/home_view.dart';

class StudentCreateUpdateView extends StatefulWidget {
  final int mode;
  final Student? student;
  final int? index;
  const StudentCreateUpdateView({
    super.key,
    required this.mode,
    this.student,
    this.index,
  });

  @override
  State<StudentCreateUpdateView> createState() =>
      _StudentCreateUpdateViewState();
}

//to read the values

class _StudentCreateUpdateViewState extends State<StudentCreateUpdateView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  String? imagePath;
  final formKey = GlobalKey<FormState>();

//tasks has to be done in the initialisation part

  @override
  void initState() {
    super.initState();
    if (widget.mode == 2) {
      nameController.text = widget.student!.name;
      ageController.text = widget.student!.age.toString();
      phoneController.text = widget.student!.phone.toString();
      emailController.text = widget.student!.email;
      imagePath = widget.student!.imagePath;
    }
  }

//appbar arrow button
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
        //arrow button ends
        //validations
        actions: [
          TextButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                print("Validated");
                widget.mode == 1
                    ? BlocProvider.of<StudentBloc>(context).add(AddData(
                        Studentsdata: Student(
                            name: nameController.text,
                            age: int.parse(ageController.text),
                            phone: int.parse(phoneController.text),
                            email: emailController.text,
                            imagePath: imagePath)))
                    : BlocProvider.of<StudentBloc>(context).add(EditData(
                        studentModel: Student(
                          name: nameController.text,
                          age: int.parse(ageController.text),
                          phone: int.parse(phoneController.text),
                          email: emailController.text,
                          imagePath: imagePath,
                        ),
                        index: widget.index!));

                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) =>
                        const HomePageView(), //after replacing--gone to home page
                  ),
                );
              } else {
                print("Not Validated");
              }
            },
            //check whether details needs to edit or create
            child: Text(
              widget.mode == 1 ? "create" : "update",
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        //single widget scrolling
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  log("TAPPED");

                  showModalBottomSheet(
                    context: context,
                    builder: (ctx) {
                      return SizedBox(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: const Icon(Icons.camera_alt),
                              title: const Text("Pick from Camera"),
                              onTap: () async {
                                // It closes the Bottom Sheet.
                                Navigator.of(ctx).pop();

                                // instance of image picker
                                final ImagePicker _picker = ImagePicker();

                                //to get camera image
                                final XFile? photo = await _picker.pickImage(
                                  source: ImageSource.camera,
                                );
                                // to set the path of image, build fn called(UI rebuild)
                                setState(() {
                                  imagePath = photo?.path;
                                });
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.collections),
                              title: const Text("Pick from Gallery"),
                              onTap: () async {
                                Navigator.of(ctx).pop();
                                final ImagePicker _picker = ImagePicker();

                                final XFile? image = await _picker.pickImage(
                                    source: ImageSource.gallery);
                                setState(() {
                                  imagePath = image?.path;
                                });
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },

                //add icon for create

                child: CircleAvatar(
                  radius: 70,
                  backgroundImage:
                      imagePath != null ? FileImage(File(imagePath!)) : null,
                  child: imagePath == null
                      ? const Icon(
                          Icons.add_photo_alternate_outlined,
                          size: 60,
                        )
                      : null,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter a name";
                        }
                      },
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.brown),
                        ),
                        hintText: "Enter name",
                        hintStyle: TextStyle(
                          fontSize: 18,
                        ),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: ageController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter age";
                        }
                      },
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.brown),
                        ),
                        hintText: "Enter age",
                        hintStyle: TextStyle(
                          fontSize: 18,
                        ),
                        prefixIcon: Icon(
                          Icons.numbers,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter phone number";
                        }
                      },
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.brown),
                        ),
                        hintText: "Phone",
                        hintStyle: TextStyle(
                          fontSize: 18,
                        ),
                        prefixIcon: Icon(
                          Icons.call,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter email id";
                        }
                      },
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.brown),
                        ),
                        hintText: "Email address",
                        hintStyle: TextStyle(
                          fontSize: 18,
                        ),
                        prefixIcon: Icon(
                          Icons.mail,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
