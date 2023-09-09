import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentapp/core/provider/imageFunctions.dart';
import 'package:studentapp/core/provider/student_functions.dart';
import 'package:studentapp/models/student_model.dart';
import '../../core/constants.dart';

final formKey = GlobalKey<FormState>();
TextEditingController nameController = TextEditingController();
TextEditingController mailController = TextEditingController();
TextEditingController ageController = TextEditingController();
TextEditingController contactController = TextEditingController();
String studentImageEdit = '';

class ScreenEdit extends StatelessWidget {
  const ScreenEdit({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    initialize(context, index);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: titleColor),
        title: const Text(
          'Edit Student Details',
          style: titleStyle,
        ),
        backgroundColor: backgroundColor,
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    Consumer<StudentImage>(builder: (context, value, child) {
                      final selectedImage = value.imgPath;
                      return selectedImage == null
                          ? GestureDetector(
                              onTap: () => getimage(value),
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: FileImage(File(studentImageEdit)),
                              ),
                            )
                          : GestureDetector(
                              onTap: () => getimage(value),
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: FileImage(File(selectedImage)),
                              ),
                            ); 
                    }),
                    const Positioned(
                        bottom: 5,
                        right: 5,
                        child: CircleAvatar( 
                          radius: 15,    
                          child: Icon(Icons.add),
                        )), 
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  keyboardType: TextInputType.name,
                  controller: nameController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => nameController.text.isEmpty
                      ? 'Name field is empty'
                      : null,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: mailController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.mail),
                    hintText: 'Email Address',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => mailController.text.isEmpty
                      ? 'Email field is empty'
                      : null,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: ageController,
                  maxLength: 2,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.calendar_month),
                    hintText: 'Age',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      nameController.text.isEmpty ? 'Age field is empty' : null,
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: contactController,
                  maxLength: 10,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.contact_page),
                    hintText: 'Contact',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => nameController.text.isEmpty
                      ? 'Name field is empty'
                      : null,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Consumer<StudentImage>(
                        builder: (context, value, child) => 
                         ElevatedButton.icon(
                          onPressed: () {
                            if (formKey.currentState!.validate())  {
                             if (value.imgPath==null) {
                               value.imgPath=studentImageEdit;
                               isSuccess(index, context); 
                             } else {
                                isSuccess(index, context);
                             }
                            }
                          },
                          icon: const Icon(Icons.security_update_good_sharp),
                          label: const Text('Update'),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> initialize(BuildContext context, int index) async {
  final studentData = Provider.of<StudentData>(context, listen: false);
  String name = studentData.students[index].name;
  nameController = TextEditingController(text: name);
  String email = studentData.students[index].email;
  mailController = TextEditingController(text: email);
  int age = studentData.students[index].age;
  ageController = TextEditingController(text: age.toString());
  int contact = studentData.students[index].contact;
  contactController = TextEditingController(text: contact.toString());
  studentImageEdit = studentData.students[index].profile;
}

getimage(StudentImage value) async {
  await value.getImage();
}

void isSuccess(int index, BuildContext context) {
  final img = Provider.of<StudentImage>(context, listen: false);
  final data = Provider.of<StudentData>(context, listen: false);
  final studentObject = StudentModel(
      id: DateTime.now(),
      profile: img.imgPath!,
      name: nameController.text.trim(),
      email: mailController.text.trim(),
      age: int.parse(ageController.text.trim()),
      contact: int.parse(contactController.text.trim()));
  data.editStudent(index, studentObject);
  Navigator.of(context).pop();
}

// void isFailed(int index, BuildContext context) {
//   final img = Provider.of<StudentImage>(context, listen: false); 
//   final data = Provider.of<StudentData>(context, listen: false);
//   final studentObject = StudentModel(
//       id: DateTime.now(),
//       profile: img.imgPath!,
//       name: nameController.text.trim(),
//       email: mailController.text.trim(),
//       age: int.parse(ageController.text.trim()),
//       contact: int.parse(contactController.text.trim()));
//   data.editStudent(index, studentObject);
//   Navigator.of(context).pop();
// }
