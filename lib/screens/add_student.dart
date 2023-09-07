import 'package:flutter/material.dart';
import 'package:studentapp/core/constants.dart';

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
          title: const Text('New Student'),
          backgroundColor: backgroundColor,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('lib/assests/avatar.png'),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey, 
                  child: Column(
                    children: [
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
                        validator: (value) => nameController.text.isEmpty
                            ? 'Age field is empty'
                            : null,
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
                            child: ElevatedButton(
                              onPressed: () {
                                formKey.currentState!.validate();
                              },
                              child: const Text('Submit'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
