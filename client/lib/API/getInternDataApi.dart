import 'dart:convert';
import 'dart:core';
import 'package:client/models/internModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../components/intern Components/InternStreamBuilder.dart';
import '../constants.dart';

Stream<List<Intern>> getAllInterns(String restOfUrl) async* {
  try {
    final response = await http.get(
      Uri.parse('$Kurl/api/v1/interns$restOfUrl'),
    );

    if (response.statusCode == 201) {
      var jsonResponse = jsonDecode(response.body);
      toFetchListIntern = [];

      List<Intern> interns = [];
      var x = jsonResponse['internNumber'];

      for (var i = 0; i < x; i++) {
        if (jsonResponse['interns'][i]["affected"] != false) {
          print(
              "000000000000000000000000000000 : ${jsonResponse['interns'][i]["supervisor"]["_id"]}");
          Intern intern = Intern(
            picture: jsonResponse['interns'][i]["picture"],
            id: jsonResponse['interns'][i]["_id"],
            firstName: jsonResponse['interns'][i]["firstName"],
            lastName: jsonResponse['interns'][i]["lastName"],
            email: jsonResponse['interns'][i]["email"],
            phoneNumber: jsonResponse['interns'][i]["phoneNumber"],
            cin: jsonResponse['interns'][i]["cin"],
            genre: jsonResponse['interns'][i]["genre"],
            instituteName: jsonResponse['interns'][i]["institute"]["name"],
            instituteId: jsonResponse['interns'][i]["institute"]["_id"],
            internShipType: jsonResponse['interns'][i]["internShipType"],
            supervisorId: jsonResponse['interns'][i]["supervisor"]["_id"],
            supervisorfirstName: jsonResponse['interns'][i]["supervisor"]
                ["firstName"],
            supervisorlastName: jsonResponse['interns'][i]["supervisor"]
                ["lastName"],
            dateStart: DateTime.parse(jsonResponse['interns'][i]["dateStart"]),
            dateFinish:
                DateTime.parse(jsonResponse['interns'][i]["dateFinish"]),
            status: jsonResponse['interns'][i]["Status"],
            affected: jsonResponse['interns'][i]["affected"],
            absent: jsonResponse['interns'][i]["absence"],
          );

          toFetchListIntern.add({
            "picture": jsonResponse['interns'][i]["picture"],
            "id": jsonResponse['interns'][i]["_id"],
            "firstName": jsonResponse['interns'][i]["firstName"],
            "lastName": jsonResponse['interns'][i]["lastName"],
            "email": jsonResponse['interns'][i]["email"],
            "phoneNumber": jsonResponse['interns'][i]["phoneNumber"],
            "cin": jsonResponse['interns'][i]["cin"],
            "genre": jsonResponse['interns'][i]["genre"],
            "institute": jsonResponse['interns'][i]["institute"]["name"],
            "internShipType": jsonResponse['interns'][i]["internShipType"],
            "supervisorfirstName": jsonResponse['interns'][i]["supervisor"]
                ["firstName"],
            "supervisorlastName": jsonResponse['interns'][i]["supervisor"]
                ["firstName"],
            "dateStart":
                DateTime.parse(jsonResponse['interns'][i]["dateStart"]),
            "dateFinish":
                DateTime.parse(jsonResponse['interns'][i]["dateFinish"]),
            "status": jsonResponse['interns'][i]["Status"],
            "affected": jsonResponse['interns'][i]["affected"],
          });
          interns.add(intern);
        } else {
          Intern intern = Intern(
            picture: jsonResponse['interns'][i]["picture"],
            id: jsonResponse['interns'][i]["_id"],
            firstName: jsonResponse['interns'][i]["firstName"],
            lastName: jsonResponse['interns'][i]["lastName"],
            email: jsonResponse['interns'][i]["email"],
            phoneNumber: jsonResponse['interns'][i]["phoneNumber"],
            cin: jsonResponse['interns'][i]["cin"],
            genre: jsonResponse['interns'][i]["genre"],
            instituteName: jsonResponse['interns'][i]["institute"]["name"],
            instituteId: jsonResponse['interns'][i]["institute"]["_id"],
            affected: false,
          );
          print(intern);
          toFetchListIntern.add({
            "picture": jsonResponse['interns'][i]["picture"],
            "id": jsonResponse['interns'][i]["_id"],
            "firstName": jsonResponse['interns'][i]["firstName"],
            "lastName": jsonResponse['interns'][i]["lastName"],
            "email": jsonResponse['interns'][i]["email"],
            "phoneNumber": jsonResponse['interns'][i]["phoneNumber"],
            "cin": jsonResponse['interns'][i]["cin"],
            "genre": jsonResponse['interns'][i]["genre"],
            "institute": jsonResponse['interns'][i]["institute"]["name"],
            "affected": false,
          });
          interns.add(intern);
        }
      }

      yield interns;
    } else {
      throw Exception('Failed to load Interns');
    }
  } on Exception catch (e) {
    print(e);
    throw Exception('errrorororoorororooror');
  }
}
