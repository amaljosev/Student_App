import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentapp/core/constants.dart';
import 'package:studentapp/core/provider/image_functions.dart';
import 'package:studentapp/models/student_model.dart';
import 'package:studentapp/screens/add/widgets/student_photo.dart';
import '../../core/provider/student_functions.dart';
import 'package:get/get.dart';

class ScreenAdd extends StatelessWidget {
  ScreenAdd({super.key});
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final mailController = TextEditingController();
  final ageController = TextEditingController();
  final contactController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: titleColor),
        title: const Text(
          'New Student',
          style: titleStyle,
        ),
        backgroundColor: backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const StudentPhoto(),
                const SizedBox(
                  height: 20,
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
                  height: 20,
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
                  height: 20,
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
                      ? 'Contact field is empty'
                      : null,
                ),
                const SizedBox(
                  height: 20,
                ),
                Consumer<StudentImage>(
                  builder: (context, value, child) => Consumer<StudentData>(
                    builder: (context, data, child) => Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                if (value.imgPath == null) {
                                  isNotSuccess();
                                } else {
                                  isSccess(value, data, context);
                                }
                              }
                            },
                            child: const Text('Submit'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void isSccess(
      StudentImage value, StudentData data, BuildContext context) async {
    final selectedImage = value.imgPath;
    if (selectedImage == null) {
      return;
    }

    final studentObject = StudentModel(
      id: DateTime.now(),
      profile: selectedImage,
      name: nameController.text.trim(),
      email: mailController.text.trim(),
      age: int.parse(ageController.text),
      contact: int.parse(contactController.text.trim()),
    );

    data.addStudent(studentObject);
    value.imgPath = null;
   
    Navigator.of(context).pop();
  }

  void isNotSuccess() {
    Get.snackbar(
      'Image not added',
      'Please add a image',
      backgroundColor: Colors.red.withOpacity(0.6),   
      colorText: Colors.white,  
       padding: const EdgeInsets.all(10),
       margin: const EdgeInsets.only(top: 60,left: 10,right: 10),      
    );
  }
}
