import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studentapp/core/constants.dart';
import 'package:studentapp/screens/add_student.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Students',style: titleStyle),backgroundColor: backgroundColor),
        body: const Center(child: Text('data')), 
        floatingActionButton: FloatingActionButton(onPressed: () => navigation(),child: const Icon(Icons.add),),  
      ),
    );
  } 
}
void navigation(){
  Get.to( ScreenAdd());
}