import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentapp/core/provider/student_functions.dart';
import 'package:studentapp/screens/profile/screen_profile.dart';

class Search extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    final studentProvider = Provider.of<StudentData>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: ListView.builder(
          itemBuilder: (context, index) {
            final data = studentProvider.students[index];
            if (data.name.toLowerCase().contains(query.toLowerCase().trim())) {
              return Column(
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (ctx) {
                        return ScreenProfile(index: index);
                      }));
                    },
                    leading: CircleAvatar(
                      radius: 40,
                      backgroundImage: FileImage(
                        File(data.profile),
                      ),
                    ),
                    title:
                        Text(data.name, style: const TextStyle(fontSize: 20)),
                  ),
                  const Divider()
                ],
              );
            } else {
              return const SizedBox();
            }
          },
          itemCount: studentProvider.students.length),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final studentProvider = Provider.of<StudentData>(context);

    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: ListView.builder(
          itemBuilder: (context, index) {
            final data = studentProvider.students[index];
            if (data.name.toLowerCase().contains(query.toLowerCase().trim())) {
              return Column(
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (ctx) {
                        return ScreenProfile(index: index);
                      }));
                    },
                    leading: CircleAvatar(
                      radius: 40,
                      backgroundImage: FileImage(
                        File(data.profile),
                      ),
                    ),
                    title:
                        Text(data.name, style: const TextStyle(fontSize: 20)),
                  ),
                  const Divider()
                ],
              );
            }
            return const SizedBox();
          },
          itemCount: studentProvider.students.length),
    );
  }
}