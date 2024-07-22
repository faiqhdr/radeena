//  Created by Muhammad Faiq Haidar on 22/07/2024.
//  Copyright © 2024 Muhammad Faiq Haidar. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:radeena/views/menu_page.dart';
import 'package:radeena/views/division/identification_page.dart';
import 'package:radeena/views/history/history_page.dart';
import 'package:radeena/views/information/library_page.dart';
import 'package:radeena/views/information/chatbot_page.dart';
import 'package:radeena/controllers/identification_controller.dart';
import 'package:radeena/controllers/impediment_controller.dart';

void main() {
  // Initial Controllers
  IdentificationController identificationController =
      IdentificationController();
  ImpedimentController impedimentController =
      ImpedimentController(identificationController.deceased);

  WidgetsBinding widgetBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetBinding);
  runApp(MyApp(
    identificationController: identificationController,
    impedimentController: impedimentController,
  ));

  WidgetsFlutterBinding.ensureInitialized();
}

class MyApp extends StatefulWidget {
  final IdentificationController identificationController;
  final ImpedimentController impedimentController;
  const MyApp({
    Key? key,
    required this.identificationController,
    required this.impedimentController,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    // Splash Screen
    await Future.delayed(Duration(seconds: 3));
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Radeena',
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      home: MenuPage(
        identificationController: widget.identificationController,
        impedimentController: widget.impedimentController,
      ),
      // Navigation in Menu Page
      routes: {
        '/identificationPage': (context) => IdentificationPage(
              controller: widget.identificationController,
              impedimentController: widget.impedimentController,
            ),
        '/historyPage': (context) => HistoryPage(),
        '/libraryPage': (context) => LibraryPage(),
        '/chatbotPage': (context) => ChatbotPage(),
      },
    );
  }
}
