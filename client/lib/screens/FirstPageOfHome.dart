import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:client/API/getSupervisorDataApi.dart';
import 'package:client/components/supervisor%20Components/SupervisorStreamBuilder.dart';
import 'package:client/models/internModel.dart';
import 'package:client/models/sepervisorModel.dart';
import 'package:client/screens/homePage.dart';
import 'package:client/screens/supervisorPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:d_chart/d_chart.dart';
import '../API/getInstituteBasedOnStudents.dart';
import '../API/getInternDataApi.dart';
import 'affectInternPage.dart';

late Stream<List<Supervisor>> Streamsup;
late Stream<List<Intern>> Streamint;
late Future<List<dynamic>> instituteInt;

class FirstPageOfHome extends StatefulWidget {
  const FirstPageOfHome({Key? key}) : super(key: key);

  @override
  State<FirstPageOfHome> createState() => _FirstPageOfHomeState();
}

class _FirstPageOfHomeState extends State<FirstPageOfHome> {
  void initState() {
    super.initState();
    instituteInt = getInstituesInterns();
    Streamsup = getAllSupervisors();
    Streamint = getAllInterns('/getnonaffectedintern');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 20, 5, 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Hello ',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w400,
                        color: Color(0xffCCCFE1),
                      ),
                    ),
                    Text(
                      'Admin !',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff443C68),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Supervisors",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff171D5F),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => homePage(i: 1)),
                        );
                      },
                      child: Text(
                        "See all",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff171D5F).withOpacity(0.6),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                StreamBuilder<List<Supervisor>>(
                  stream: Streamsup,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return Text("The stream is null .");
                      case ConnectionState.waiting:
                        return Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.lightBlueAccent,
                          ),
                        );
                      case ConnectionState.done:
                        if (snapshot.hasData) {
                          return SizedBox(
                            height: 110,
                            width: double.infinity,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                  child: Container(
                                    height: 120,
                                    width: 180,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          top: 10,
                                          left: 10,
                                          child: ClipOval(
                                            child: Material(
                                              color: Colors.transparent,
                                              child: Ink.image(
                                                image: AssetImage(
                                                        'images/${snapshot.data![index].picture}')
                                                    as ImageProvider,
                                                fit: BoxFit.cover,
                                                width: 50,
                                                height: 50,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 15,
                                          left: 65,
                                          child: Text(
                                            '${snapshot.data![index].firstName}\n${snapshot.data![index].lastName}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 65,
                                          left: 10,
                                          child: RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'Phone: ',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text:
                                                      '${snapshot.data![index].phoneNumber}',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 85,
                                          left: 10,
                                          child: RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'Intern\'s number : ',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text:
                                                      '${snapshot.data![index].internNumber}',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        } else {
                          return Text('data');
                        }
                        break;
                      default:
                        return Text('Non intern Exist');
                    }
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Non Affected Interns",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff171D5F),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => affectInternScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "See all",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff171D5F).withOpacity(0.6),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                StreamBuilder<List<Intern>>(
                  stream: Streamint,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return Text("The stream is null .");
                      case ConnectionState.waiting:
                        return Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.lightBlueAccent,
                          ),
                        );
                      case ConnectionState.done:
                        if (snapshot.hasData) {
                          return SizedBox(
                            height: 110,
                            width: double.infinity,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.length,
                              //physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                  child: Container(
                                    constraints: BoxConstraints(
                                      // minWidth: 200,
                                      // maxWidth: double.infinity,
                                      minHeight: 120,
                                      maxHeight: double.infinity,
                                    ),
                                    width: 200,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          top: 10,
                                          left: 10,
                                          child: ClipOval(
                                            child: Material(
                                              color: Colors.transparent,
                                              child: Ink.image(
                                                image: AssetImage(
                                                        'images/${snapshot.data![index].picture}')
                                                    as ImageProvider,
                                                fit: BoxFit.cover,
                                                width: 50,
                                                height: 50,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 15,
                                          left: 65,
                                          child: Text(
                                            '${snapshot.data![index].firstName}\n${snapshot.data![index].lastName}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 65,
                                          left: 10,
                                          child: RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'Phone: ',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text:
                                                      '${snapshot.data![index].phoneNumber}',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 85,
                                          left: 10,
                                          child: Container(
                                            width: 180,
                                            child: RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'Establishment: ',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        '${snapshot.data![index].instituteName}',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        } else {
                          return Text('data');
                        }
                        break;
                      default:
                        return Text('Non intern Exist');
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Establishments: ",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff171D5F),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                FutureBuilder(
                  future: instituteInt,
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasError) {
                      Object? e = snapshot.error;
                      String errorMessage = '';
                      if (e is SocketException) {
                        errorMessage =
                            'Unable to connect to server. Please check your internet connection.';
                      } else if (e is TimeoutException) {
                        errorMessage =
                            'Connection timed out. Please try again later.';
                      } else {
                        errorMessage = 'An error occurred: $e';
                      }
                      // Display an error message
                      return Text(errorMessage);
                    }
                    if (!snapshot.hasData &&
                        snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Color(0xff284F7B),
                        ),
                      );
                    }
                    if (!snapshot.hasData &&
                        snapshot.connectionState == ConnectionState.done) {
                      return Text('No data available');
                    }
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          AspectRatio(
                            aspectRatio: 18 / 8,
                            child: DChartPie(
                              data: InstituesInterns.map((g) {
                                return {
                                  'domain': g['institue'],
                                  'measure': g['studentNbr']
                                };
                              }).toList(),
                              fillColor: (pieData, index) {
                                Random random = Random();
                                return Color.fromRGBO(
                                    random.nextInt(256),
                                    random.nextInt(256),
                                    random.nextInt(256),
                                    1);
                              },
                              labelPosition: PieLabelPosition.outside,
                              labelColor: Colors.black,
                              labelFontSize: 12,
                              labelLineColor: Colors.black,
                              labelLineThickness: 1,
                              labelLinelength: 11,
                              pieLabel:
                                  (Map<dynamic, dynamic> pieData, int? index) {
                                return pieData['domain'].toString() +
                                    ': \n' +
                                    pieData['measure'].toString();
                              },
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Number of interns from each Establishment',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        color: Color(0xff284F7B),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 18 / 8,
                      child: DChartPie(
                        data: toFetchList.map((g) {
                          return {
                            'domain': g['firstName'],
                            'measure': g['internNumber']
                          };
                        }).toList(),
                        fillColor: (pieData, index) {
                          Random random = Random();
                          return Color.fromRGBO(random.nextInt(256),
                              random.nextInt(256), random.nextInt(256), 1);
                        },
                        labelPosition: PieLabelPosition.outside,
                        labelColor: Colors.black,
                        labelFontSize: 12,
                        labelLineColor: Colors.black,
                        labelLineThickness: 1,
                        labelLinelength: 11,
                        pieLabel: (Map<dynamic, dynamic> pieData, int? index) {
                          return pieData['domain'].toString() +
                              ': \n' +
                              pieData['measure'].toString();
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      alignment: Alignment.center,
                      child: Text(
                        'Number of interns affected to each supervisor ',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
