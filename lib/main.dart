import 'package:flutter/material.dart';
import 'package:radeena/views/menu_page.dart';
import 'package:radeena/views/division/identification_page.dart';
import 'package:radeena/views/history/history_page.dart';
import 'package:radeena/views/information/library_page.dart';
import 'package:radeena/views/information/chatbot_page.dart';
import 'package:radeena/controllers/identification_controller.dart';
import 'package:radeena/controllers/impediment_controller.dart';

void main() {
  IdentificationController identificationController =
      IdentificationController();
  ImpedimentController impedimentController =
      ImpedimentController(identificationController.deceased);

  runApp(MyApp(
    identificationController: identificationController,
    impedimentController: impedimentController,
  ));

  WidgetsFlutterBinding.ensureInitialized();
}

class MyApp extends StatelessWidget {
  final IdentificationController identificationController;
  final ImpedimentController impedimentController;
  const MyApp({
    Key? key,
    required this.identificationController,
    required this.impedimentController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Radeena',
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      home: MenuPage(
        identificationController: identificationController,
        impedimentController: impedimentController,
      ),
      routes: {
        '/identificationPage': (context) => IdentificationPage(
              controller: identificationController,
              impedimentController: impedimentController,
            ),
        '/historyPage': (context) => HistoryPage(),
        '/libraryPage': (context) => LibraryPage(),
        '/chatbotPage': (context) => ChatbotPage(),
      },
    );
  }
}
