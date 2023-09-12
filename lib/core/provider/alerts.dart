import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentapp/core/provider/student_functions.dart';
import '../constants.dart';

class AlertProvider with ChangeNotifier {
    void success(BuildContext context) { 
    final snackBar = SnackBar(
      content: const Text(
        'Updated successfuly!!', 
        style: TextStyle(color: titleColor),
      ),
      backgroundColor: Colors.green, 
      behavior: SnackBarBehavior.floating,
      padding: const EdgeInsets.only(left: 10),
      action: SnackBarAction(
          textColor: titleColor,
          label: 'undo',
          onPressed: () => Navigator.of(context).pop),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  void notSuccess(BuildContext context) {
    final snackBar = SnackBar(
      content: const Text(
        'Image not added!!',
        style: TextStyle(color: titleColor),
      ),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
      padding: const EdgeInsets.only(left: 10),
      action: SnackBarAction(
          textColor: titleColor,
          label: 'undo',
          onPressed: () => Navigator.of(context).pop),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  Future<void> dialogBuilder(BuildContext context,int index) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure!!',style: TextStyle(color: Colors.red),),  
          content: const Text(
            'Do you realy want to delete this entry?', 
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Discard'), 
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Delete'), 
              onPressed: () {
                final student=Provider.of<StudentData>(context,listen: false ); 
                student.deleteStudent(index); 
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
