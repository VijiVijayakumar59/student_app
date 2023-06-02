// ignore_for_file: avoid_print, no_leading_underscores_for_local_identifiers, body_might_complete_normally_nullable

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final TextEditingController nameController = TextEditingController();
  bool isEditing = false;
  String? imagePath;

  @override
  void initState() {
    super.initState();
    var box = Hive.box('user');
    if (box.get('userName') != null) {
      nameController.text = box.get('userName');
    }
    imagePath = box.get('profileImage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Profile",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                print("TAPPED");

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
                              var box = Hive.box('user');
                              box.put('profileImage', photo?.path);
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
                              var box = Hive.box('user');
                              box.put('profileImage', image?.path);
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
              height: 24,
            ),
            TextFormField(
              controller: nameController,
              readOnly: isEditing ? false : true,
              keyboardType: TextInputType.name,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter name";
                }
              },
              decoration: InputDecoration(
                hintText: "Enter name here",
                hintStyle: const TextStyle(
                  fontSize: 18,
                ),
                prefixIcon: const Icon(
                  Icons.alternate_email,
                  color: Colors.black,
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isEditing = !isEditing;
                    });
                    var box = Hive.box('user');
                    box.put('userName', nameController.text);
                  },
                  icon: Icon(
                    isEditing ? Icons.check : Icons.edit,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
