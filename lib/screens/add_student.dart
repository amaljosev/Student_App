import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentapp/core/constants.dart';
import '../core/provider/functions.dart';

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
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () async {
                  final imageFile = await Provider.of<ProviderFunctions>(
                          context,
                          listen: false)
                      .getImage();
                  if (imageFile != null) {
                    Provider.of<ProviderFunctions>(context, listen: false)
                        .setImage(imageFile);
                  }
                },
                child: Consumer<ProviderFunctions>(
                  builder: (context, imageProvider, child) {
                    final selectedImage = imageProvider.selectedImage;
                    return selectedImage == null
                        ? const CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                AssetImage('lib/assests/avatar.png'),
                          )
                        : CircleAvatar(
                            radius: 50,
                            backgroundImage: FileImage(selectedImage),
                          );
                  },
                ),
              ),
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
                validator: (value) =>
                    nameController.text.isEmpty ? 'Name field is empty' : null,
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
                validator: (value) =>
                    mailController.text.isEmpty ? 'Email field is empty' : null,
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
                validator: (value) =>
                    nameController.text.isEmpty ? 'Name field is empty' : null,
              ),
              const SizedBox(
                height: 10,
              ),
              Consumer<ProviderFunctions>(
                builder: (context, value, child) => Consumer(
                  builder: (context, value2, child) => Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            formKey.currentState!.validate();
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
    );
  }
}
