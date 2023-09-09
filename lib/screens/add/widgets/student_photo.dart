import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/provider/image_functions.dart';

class StudentPhoto extends StatelessWidget {
  const StudentPhoto({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Consumer<StudentImage>(
          builder: (context, imageProvider, child) {
            final selectedImage = imageProvider.imgPath;
            return selectedImage == null
                ? GestureDetector(
                    onTap: () => getimage(imageProvider),
                    child: const CircleAvatar(
                      radius: 80,
                      backgroundImage: AssetImage('lib/assests/avatar.png'),
                    ),
                  )
                : GestureDetector(
                    onTap: () => getimage(imageProvider),
                    child: CircleAvatar(
                      radius: 80,
                      backgroundImage: FileImage(File(selectedImage)),
                    ),
                  );
          },
        ), 
        Positioned(
          bottom: 5,
          right: 5,
          child: Consumer<StudentImage>(
            builder: (context, value, child) => GestureDetector(
              onTap: () => getimage(value),
              child: const CircleAvatar( 
                radius: 20,
                child: Icon(Icons.add),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

getimage(StudentImage value) async {
  await value.getImage();
}
