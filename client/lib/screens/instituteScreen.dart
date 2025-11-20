import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import '../API/getInstituteDataApi.dart';
import '../components/institute Components/instituteStreamBuilder.dart';
import '../constants.dart';
import 'dart:convert';

import '../models/instituteModel.dart';
import 'homePage.dart';

late dynamic dataInstitute;
late Stream<List<Institute>> StreamInstitute;
List resultsInstitute = [];
String chh = '';
List<Institute> streamingIns = [];

class instituteScreen extends StatefulWidget {
  const instituteScreen({Key? key}) : super(key: key);

  @override
  State<instituteScreen> createState() => _instituteScreenState();
}

class _instituteScreenState extends State<instituteScreen> {
  late String _Errorname = '';
  late String _Erroremail = '';
  late String _ErrorphoneNumber = '';
  late String _Erroradresse = '';
  late String _Errorfax = '';
  late String name = '';
  late String email = '';
  late String phoneNumber = '';
  late String adresse = '';
  late String fax = '';
  late String type = 'university';
  void runFiller(String enteredKeyword) {
    if (enteredKeyword.isNotEmpty) {
      resultsInstitute = [];
      resultsInstitute = toFetchListInstitute
          .where((o) =>
              o['name'].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      streamingIns = [];
      if (resultsInstitute.length >= 1) {
        print(resultsInstitute.length);
        for (var index = 0; index < resultsInstitute.length; index++) {
          Institute ss = Institute(
            name: resultsInstitute[index]["name"],
            email: resultsInstitute[index]["email"],
            fax: resultsInstitute[index]["fax"],
            phoneNumber: resultsInstitute[index]["phoneNumber"],
            adresse: resultsInstitute[index]["adresse"],
            type: resultsInstitute[index]["type"],
          );

          if (ss != null) {
            streamingIns.add(ss);
          }
        }
        setState(() {
          StreamInstitute = convertToStream(streamingIns);
        });
      } else {
        setState(() {
          StreamInstitute = convertToStream(streamingIns);
        });
      }
    } else {
      setState(() {
        StreamInstitute = getAllInstitutes();
      });
    }
  }

  Stream<List<Institute>> convertToStream(List<Institute> stream) async* {
    yield stream;
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    StreamInstitute = getAllInstitutes();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext) {
                  return StatefulBuilder(
                    builder:
                        (context, void Function(void Function()) setState) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30.0),
                          ),
                        ),
                        title: Text('Add Institute'),
                        content: SingleChildScrollView(
                          child: Wrap(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 8.0, top: 8),
                                    child: Text('Name :'),
                                  ),
                                  TextField(
                                    style: TextStyle(
                                      fontSize: 13,
                                    ),
                                    onChanged: (value) {
                                      name = value;
                                      setState(() {
                                        _Errorname = '';
                                      });
                                    },
                                    decoration:
                                        KinputDecorationInstitue.copyWith(
                                            hintText: 'Name',
                                            errorText: _Errorname.isEmpty
                                                ? null
                                                : _Errorname),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 8.0, top: 8),
                                    child: Text('Email :'),
                                  ),
                                  TextField(
                                    keyboardType: TextInputType.emailAddress,
                                    style: TextStyle(
                                      fontSize: 13,
                                    ),
                                    onChanged: (value) {
                                      email = value;
                                      setState(() {
                                        _Erroremail = '';
                                      });
                                    },
                                    decoration:
                                        KinputDecorationInstitue.copyWith(
                                            hintText: 'Email',
                                            errorText: _Erroremail.isEmpty
                                                ? null
                                                : _Erroremail),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 8.0, top: 8),
                                    child: Text('Phone number :'),
                                  ),
                                  TextField(
                                    maxLength: 8,
                                    style: TextStyle(
                                      fontSize: 13,
                                    ),
                                    onChanged: (value) {
                                      phoneNumber = value;
                                      setState(() {
                                        _ErrorphoneNumber = '';
                                      });
                                    },
                                    decoration:
                                        KinputDecorationInstitue.copyWith(
                                            hintText: 'Phone number',
                                            errorText: _ErrorphoneNumber.isEmpty
                                                ? null
                                                : _ErrorphoneNumber),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 8.0, top: 8),
                                    child: Text('Fax :'),
                                  ),
                                  TextField(
                                    style: TextStyle(
                                      fontSize: 13,
                                    ),
                                    onChanged: (value) {
                                      fax = value;
                                      setState(() {
                                        _Errorfax = '';
                                      });
                                    },
                                    decoration:
                                        KinputDecorationInstitue.copyWith(
                                      hintText: 'Fax',
                                      errorText:
                                          _Errorfax.isEmpty ? null : _Errorfax,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 8.0, top: 8),
                                    child: Text('Addresse :'),
                                  ),
                                  TextField(
                                    style: TextStyle(
                                      fontSize: 11,
                                    ),
                                    onChanged: (value) {
                                      adresse = value;
                                      setState(() {
                                        _Erroradresse = '';
                                      });
                                    },
                                    decoration:
                                        KinputDecorationInstitue.copyWith(
                                      hintText: 'adresse',
                                      errorText: _Erroradresse.isEmpty
                                          ? null
                                          : _Erroradresse,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 8.0, top: 8),
                                    child: Text('Type :'),
                                  ),
                                  StatefulBuilder(
                                    builder: (context,
                                        void Function(void Function())
                                            setState) {
                                      return DropdownButton(
                                        items: [
                                          DropdownMenuItem(
                                            child: Text('university'),
                                            value: 'university',
                                          ),
                                          DropdownMenuItem(
                                            child: Text('training center'),
                                            value: 'training center',
                                          ),
                                        ],
                                        onChanged: (value) {
                                          setState(() {
                                            type = value.toString();
                                          });
                                        },
                                        value: type,
                                      );
                                    },
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: 5,
                                        ),
                                        child: MaterialButton(
                                          onPressed: () async {
                                            setState(() {
                                              if (name.isEmpty || name == ' ') {
                                                _Errorname =
                                                    "Please provide your Email .";
                                              } else {
                                                _Errorname = '';
                                              }
                                              if (email.isEmpty ||
                                                  email == ' ') {
                                                _Erroremail =
                                                    "Please provide your Email .";
                                              } else {
                                                _Erroremail = '';
                                              }
                                              if (phoneNumber.isEmpty ||
                                                  phoneNumber == ' ') {
                                                _ErrorphoneNumber =
                                                    "Please provide your Email .";
                                              } else {
                                                _ErrorphoneNumber = '';
                                              }
                                              if (fax.isEmpty || fax == ' ') {
                                                _Errorfax =
                                                    "Please provide your Email .";
                                              } else {
                                                _ErrorphoneNumber = '';
                                              }
                                              if (adresse.isEmpty ||
                                                  adresse == ' ') {
                                                _Erroradresse =
                                                    "Please provide your Email .";
                                              } else {
                                                _Erroradresse = '';
                                              }
                                            });
                                            var data = {
                                              "name": name,
                                              "email": email,
                                              "phoneNumber": phoneNumber,
                                              "fax": fax,
                                              "adresse": adresse,
                                              "type": type
                                            };

                                            var encodedData = jsonEncode(data);
                                            http.Response res = await http.post(
                                                Uri.parse(
                                                    '$Kurl/api/v1/institutes/createinstitute/'),
                                                headers: {
                                                  'Content-Type':
                                                      'application/json; charset=UTF-8',
                                                },
                                                body: encodedData);

                                            if (res.statusCode == 200) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      homePage(i: 3),
                                                ),
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  padding: EdgeInsets.all(13),
                                                  backgroundColor: Colors.green,
                                                  content: Text(
                                                    'Establishment added succefully',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                          height: 40,
                                          minWidth: 80,
                                          color: Color(0xffBCE29E),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10.0),
                                            ),
                                          ),
                                          child: Text(
                                            'Add',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          elevation: 3,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: 5,
                                        ),
                                        child: MaterialButton(
                                          onPressed: () {
                                            _Errorname = '';
                                            _ErrorphoneNumber = '';
                                            _Erroremail = '';
                                            _Errorfax = '';
                                            _Erroradresse = '';
                                            Navigator.pop(context);
                                          },
                                          height: 40,
                                          minWidth: 80,
                                          color: Color(0xffECC1C6),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10.0),
                                            ),
                                          ),
                                          child: Text(
                                            'Cancel',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          elevation: 3,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              );
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
                      'Institute',
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
                          "Management Of Establishments",
                          style: TextStyle(
                              color: Color(0xff171D5F),
                              fontWeight: FontWeight.w900),
                        ),
                        Icon(
                          Icons.school,
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
                    hintText: 'Search for establishment',
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
                      'Establishments :',
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
                child: instituteStream(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
