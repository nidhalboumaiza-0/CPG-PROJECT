import 'package:client/API/getInstituteDataApi.dart';
import 'package:client/API/getInternDataApi.dart';
import 'package:client/models/internModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

import '../components/intern Components/InternStreamBuilder.dart';
import '../components/intern Components/NonAffectedInternStreamBuilder.dart';
import '../constants.dart';
import 'dart:convert';

import '../models/instituteModel.dart';
import 'homePage.dart';

late dynamic dataIntern;
late Stream<List<Intern>> StreamInternNonAffected;
List resultsIntern = [];
String chhh = '';
List<Intern> streamingInt = [];

class affectInternScreen extends StatefulWidget {
  const affectInternScreen({Key? key}) : super(key: key);

  @override
  State<affectInternScreen> createState() => _affectInternScreenState();
}

class _affectInternScreenState extends State<affectInternScreen> {
  late Stream<List<Institute>> institutes;

  late String id = '';
  late String firstName = '';
  late String lastName = '';
  late String email = '';
  late String phoneNumber = '';
  late String cin = '';
  late String genre = '';
  late String institute = '';

  bool? status;
  bool? affected;
  String _gendre = "Male";
  // void runFiller(String enteredKeyword) {
  //   if (enteredKeyword.isNotEmpty) {
  //     Intern ss = Intern();
  //     resultsIntern = [];
  //     resultsIntern = toFetchListIntern
  //         .where((o) => o['firstName']
  //             .toLowerCase()
  //             .contains(enteredKeyword.toLowerCase()))
  //         .toList();
  //     streamingInt = [];
  //     if (resultsIntern.length >= 1) {
  //       for (var index = 0; index < resultsIntern.length; index++) {
  //         ss = Intern(
  //           id: resultsIntern[index]["_id"],
  //           firstName: resultsIntern[index]["firstName"],
  //           lastName: resultsIntern[index]["lastName"],
  //           email: resultsIntern[index]["email"],
  //           phoneNumber: resultsIntern[index]["phoneNumber"],
  //           cin: resultsIntern[index]["cin"],
  //           genre: resultsIntern[index]["genre"],
  //           instituteName: resultsIntern[index]["institute"]["name"],
  //           instituteId: resultsIntern[index]["institute"]["_id"],
  //         );
  //
  //         if (ss != null) {
  //           streamingInt.add(ss);
  //         }
  //       }
  //       setState(() {
  //         StreamInternNonAffected = convertToStream(streamingInt);
  //       });
  //     } else {
  //       setState(() {
  //         StreamInternNonAffected = convertToStream(streamingInt);
  //       });
  //     }
  //   } else {
  //     setState(() {
  //       StreamInternNonAffected = getAllInterns('/getnonaffectedintern');
  //     });
  //   }
  // }

  Stream<List<Intern>> convertToStream(List<Intern> stream) async* {
    yield stream;
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    StreamInternNonAffected = getAllInterns('/getnonaffectedintern');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Non affected interns',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          elevation: 0,
          backgroundColor: Colors.black87,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 15, top: 10, right: 15),
                  height: 60,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Intern',
                        style: TextStyle(
                          color: Color(0xffCCCFD4),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Management Of Non Affected interns",
                            style: TextStyle(
                                color: Color(0xff171D5F),
                                fontWeight: FontWeight.w900),
                          ),
                          Icon(
                            Icons.hail,
                            color: Color(0xffA5AAB7),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    onChanged: (value) {
                      //runFiller(value);
                    },
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xffA5AAB7), width: 2.0),
                        borderRadius: BorderRadius.all(
                          Radius.circular(25.0),
                        ),
                      ),
                      hintText: 'Search for intern',
                      hintStyle: TextStyle(fontSize: 15),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Color(0xffA5AAB7),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 13.0),
                  child: Flexible(
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      child: Text(
                        'Non Affected Interns :',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff171D5F),
                        ),
                      ),
                    ),
                  ),
                ),
                Divider(
                  height: 0,
                  thickness: 1.5,
                  indent: 18,
                  endIndent: 18,
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: internStreamNonAffected(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
