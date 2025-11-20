import 'dart:convert';
import 'dart:core';
import 'package:client/models/instituteModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../components/institute Components/instituteStreamBuilder.dart';
import '../constants.dart';

Stream<List<Institute>> getAllInstitutes() async* {
  try {
    final response = await http.get(
      Uri.parse('$Kurl/api/v1/institutes/'),
    );

    if (response.statusCode == 201) {
      var jsonResponse = jsonDecode(response.body);
      toFetchListInstitute = [];

      List<Institute> institutes = [];
      var x = jsonResponse['institutesNumber'];

      for (var i = 0; i < x; i++) {
        Institute institute = Institute(
          id: jsonResponse['institutes'][i]["_id"],
          name: jsonResponse['institutes'][i]["name"],
          email: jsonResponse['institutes'][i]["email"],
          fax: jsonResponse['institutes'][i]["fax"],
          phoneNumber: jsonResponse['institutes'][i]["phoneNumber"],
          adresse: jsonResponse['institutes'][i]["adresse"],
          type: jsonResponse['institutes'][i]["type"],
        );
        toFetchListInstitute.add({
          "name": jsonResponse['institutes'][i]["name"],
          "email": jsonResponse['institutes'][i]["email"],
          "fax": jsonResponse['institutes'][i]["fax"],
          "phoneNumber": jsonResponse['institutes'][i]["phoneNumber"],
          "adresse": jsonResponse['institutes'][i]["adresse"],
          "type": jsonResponse['institutes'][i]["type"],
        });

        institutes.add(institute);
      }
      yield institutes;
    } else {
      throw Exception('Failed to load Interns');
    }
  } on Exception catch (e) {
    print(e);
    throw Exception('errrorororoorororooror');
  }
}
