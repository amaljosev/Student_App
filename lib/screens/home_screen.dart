import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentapp/core/constants.dart';
import 'package:studentapp/screens/add_student.dart';
import 'package:studentapp/screens/screen_profile.dart';

import '../core/provider/student_functions.dart';


class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    final studentProvider = Provider.of<StudentData>(context);
    studentProvider.getStudent();
    return Scaffold(
      appBar: AppBar(
          title: const Text('Students', style: titleStyle),
          backgroundColor: backgroundColor),
      body: Column(
        children: [
          Consumer<StudentData>(
            builder: (context, value, child) => value.students.isNotEmpty
                ? Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) => ListTile(
                              leading: CircleAvatar(
                                backgroundImage: FileImage(
                                    File(value.students[index].profile)),
                              ),
                              title: Text(value.students[index].name),
                              onTap: () => navigateToProfile(context,index),
                            ),
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: value.students.length),
                  )
                : const SizedBox(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => navigateToForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}

void navigateToForm(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => ScreenAdd(),
    ),
  );
}

void navigateToProfile(BuildContext context,int index) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) =>  ScreenProfile(index:index ),
    ),
  );
}
