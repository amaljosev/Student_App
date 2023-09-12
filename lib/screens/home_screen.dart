import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentapp/core/constants.dart';
import 'package:studentapp/core/provider/alerts.dart';
import 'package:studentapp/screens/add/add_student.dart';
import 'package:studentapp/screens/profile/screen_profile.dart';
import 'package:studentapp/screens/search/search_screen.dart';
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
        backgroundColor: backgroundColor,
        actions: [
          IconButton(
              onPressed: () => showSearch(context: context, delegate: Search()),
              icon: const Icon(Icons.search)),
        ],
      ),
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
                              trailing: Consumer<AlertProvider>(
                                builder: (context, value, child) => IconButton(
                                    onPressed: () =>
                                        value.dialogBuilder(context, index),
                                    icon: const Icon(Icons.delete)),
                              ),
                              onTap: () => navigateToProfile(context, index),
                            ),
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: value.students.length),
                  )
                : const SizedBox(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: backgroundColor,
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

void navigateToProfile(BuildContext context, int index) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => ScreenProfile(index: index),
    ),
  );
}
