import 'package:flutter/material.dart';
import 'package:radeena/controllers/identification_controller.dart';
import 'package:radeena/views/identification_page.dart';
import 'package:radeena/views/menu_page.dart'; // Import the controller

void main() {
  IdentificationController identificationController =
      IdentificationController(); // Initialize the controller

  runApp(MyApp(
    controller: identificationController,
  ));

  WidgetsFlutterBinding.ensureInitialized();
}

class MyApp extends StatelessWidget {
  final IdentificationController controller;
  const MyApp({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Radeena',
        theme: ThemeData(
          primarySwatch: Colors.green,
          useMaterial3: true,
        ),
        home: MenuPage(controller: controller),
        routes: {
          '/identificationPage': (context) =>
              IdentificationPage(controller: controller),
        });
  }
}
