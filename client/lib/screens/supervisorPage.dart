import 'dart:convert';

import 'dart:core';

import 'package:client/models/sepervisorModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import '../API/getSupervisorDataApi.dart';
import '../components/supervisor Components/SupervisorStreamBuilder.dart';
import 'addEditSupervisorPage.dart';

late dynamic data;

late Stream<List<Supervisor>> StreamSupervisors;
List resultsSup = [];
String ch = '';
List<Supervisor> streaming = [];

class supervisorPage extends StatefulWidget {
  const supervisorPage({Key? key}) : super(key: key);

  @override
  State<supervisorPage> createState() => _supervisorPageState();
}

class _supervisorPageState extends State<supervisorPage> {
  void runFiller(String enteredKeyword) {
    if (enteredKeyword.isNotEmpty) {
      resultsSup = [];
      resultsSup = toFetchList
          .where((o) => o['firstName']
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
      streaming = [];
      if (resultsSup.length >= 1) {
        print(resultsSup.length);
        for (var index = 0; index < resultsSup.length; index++) {
          Supervisor ss = Supervisor(
            lastName: resultsSup[index]['lastName'],
            firstName: resultsSup[index]['firstName'],
            email: resultsSup[index]['email'],
            phoneNumber: resultsSup[index]['phoneNumber'],
            workStation: resultsSup[index]['workStation'],
            matricule: resultsSup[index]['matricule'],
            internNumber: resultsSup[index]['internNumber'],
            id: resultsSup[index]['id'],
          );

          if (ss != null) {
            streaming.add(ss);
          }
        }
        setState(() {
          StreamSupervisors = convertToStream(streaming);
        });
      } else {
        setState(() {
          StreamSupervisors = convertToStream(streaming);
        });
      }
    } else {
      setState(() {
        StreamSupervisors = getAllSupervisors();
      });
    }
  }

  Stream<List<Supervisor>> convertToStream(List<Supervisor> stream) async* {
    yield stream;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    StreamSupervisors = getAllSupervisors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEDF1F5),
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => addEditSupervisorPage(
                  pageType: "add",
                ),
              ),
            );

            // print(toFetchList);
          },
          child: Icon(Icons.add),
          backgroundColor: Color(0xffA5AAB7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 15, top: 20, right: 15),
                height: 60,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Supervisor',
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
                          "Management Of Supervisors",
                          style: TextStyle(
                              color: Color(0xff171D5F),
                              fontWeight: FontWeight.w900),
                        ),
                        Icon(
                          Icons.man_sharp,
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
                    runFiller(value);
                  },
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xffA5AAB7), width: 2.0),
                      borderRadius: BorderRadius.all(
                        Radius.circular(25.0),
                      ),
                    ),
                    hintText: 'Search for supervisor',
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
                      'Supervisors :',
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
                child: supervisorFuture(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Supervisor ss = Supervisor(
//   lastName: "abed",
//   firstName: "eyad",
//   email: "iyad@gmail.com",
//   phoneNumber: "20369841",
//   workStation: "lyce",
//   matricule: "12358",
//   internNumber: 0,
//   id: "78564112365",
// );
