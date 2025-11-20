import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:client/models/instituteModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

List list = [];
dynamic intern;
Future getInternAbsence(id) async {
  try {
    final res = await http.get(
      Uri.parse('$Kurl/api/v1/interns/getInternAbsences/$id'),
    );
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);

      intern = body['data'];
      list = body['data']['absence'];
      print(intern);
      return intern;
    } else {
      throw Exception('Failed to load Interns');
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
