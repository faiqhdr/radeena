import 'dart:convert';
import 'package:flutter/services.dart';

class LibraryController {
  List<Map<String, dynamic>> dalilList = [];

  LibraryController() {
    loadDalilData();
  }

  Future<void> loadDalilData() async {
    final String response =
        await rootBundle.loadString('lib/models/dalil.json');
    final data = await json.decode(response);
    dalilList = List<Map<String, dynamic>>.from(data['evidence']);
    print('Dalil data loaded: $dalilList'); // Debugging line
  }

  List getUniqueHeirs() {
    final heirs = dalilList.map((dalil) => dalil['heir']).toSet().toList();
    return heirs;
  }

  List<Map<String, dynamic>> getDalilForHeir(String heir) {
    return dalilList.where((dalil) => dalil['heir'] == heir).toList();
  }
}
