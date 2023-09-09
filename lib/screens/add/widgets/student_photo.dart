import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/provider/imageFunctions.dart';

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
                      backgroundImage:
                          AssetImage('lib/assests/avatar.png'),
                    ),
                  )
                : GestureDetector(
                    onTap: () => getimage(imageProvider),
                    child: CircleAvatar(
                      radius: 80,
                      backgroundImage:
                          FileImage(File(selectedImage)),
                    ),
                  );
          },
        ),
        const Positioned(
            bottom: 5,
            right: 5,
            child: CircleAvatar(
              child: Icon(Icons.add),
            )),
      ],
    );
  }
}

getimage(StudentImage value) async {
  await value.getImage();
}