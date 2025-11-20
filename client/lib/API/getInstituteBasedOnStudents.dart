import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:client/screens/instituteScreen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';

List<dynamic> InstituesInterns = [];
Future<List<dynamic>> getInstituesInterns() async {
  try {
    final response = await http.get(
      Uri.parse('$Kurl/api/v1/interns/getInstitutesInternsCount'),
    );
    if (response.statusCode == 201) {
      InstituesInterns = [];
      final jsonData = jsonDecode(response.body);
      final nbr = jsonData['instituteNumber'];
      final list = jsonData['institutesInternsCount'];
      for (var i = 0; i < nbr; i++) {
        InstituesInterns.add({
          'institue': list[i]['_id'],
          'studentNbr': list[i]['count'],
        });
      }
      return list;
    } else {
      throw Exception('Failed to load InstituesInterns');
    }
  } on Exception catch (e) {
    if (e is SocketException) {
      // Display an error message to the user
      throw Exception(
          'Unable to connect to server. Please check your internet connection.');
    } else if (e is TimeoutException) {
      // Display an error message to the user
      throw Exception('Connection timed out. Please try again later.');
    } else {
      // Handle other types of exceptions
      throw Exception('An error occurred: $e');
    }
  }
}
