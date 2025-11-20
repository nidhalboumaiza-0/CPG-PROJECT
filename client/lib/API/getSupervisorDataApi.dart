import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../components/supervisor Components/SupervisorStreamBuilder.dart';
import '../constants.dart';
import '../models/sepervisorModel.dart';

List toFetchList = [];

Stream<List<Supervisor>> getAllSupervisors() async* {
  try {

    final response = await http.get(
      Uri.parse('$Kurl/api/v1/supervisors/'),

    );

    if (response.statusCode == 201) {
      var jsonResponse = jsonDecode(response.body);

      List<Supervisor> supervisors = [];
      var x = jsonResponse['SupervisprNumber'];
      toFetchList = [];
      for (var i = 0; i < x; i++) {
        Supervisor supervisor = Supervisor(
          picture: jsonResponse['supervisors'][i]["picture"],
          id: jsonResponse['supervisors'][i]["_id"],
          firstName: jsonResponse['supervisors'][i]["firstName"],
          lastName: jsonResponse['supervisors'][i]["lastName"],
          email: jsonResponse['supervisors'][i]["email"],
          phoneNumber: jsonResponse['supervisors'][i]["phoneNumber"],
          workStation: jsonResponse['supervisors'][i]["workStation"],
          matricule: jsonResponse['supervisors'][i]["matricule"],
          internNumber: jsonResponse['supervisors'][i]["internNumber"],
        );
        toFetchList.add({
          "id": jsonResponse['supervisors'][i]["_id"],
          "firstName": jsonResponse['supervisors'][i]["firstName"],
          "lastName": jsonResponse['supervisors'][i]["lastName"],
          "email": jsonResponse['supervisors'][i]["email"],
          "phoneNumber": jsonResponse['supervisors'][i]["phoneNumber"],
          "workStation": jsonResponse['supervisors'][i]["workStation"],
          "matricule": jsonResponse['supervisors'][i]["matricule"],
          "internNumber": jsonResponse['supervisors'][i]["internNumber"],
        });

        supervisors.add(supervisor);
      }
      yield supervisors;
    } else {
      throw Exception('Failed to load Supervisors');
    }
  } on Exception catch (e) {
    print(e);
    throw Exception('errrorororoorororooror');
  }
}
