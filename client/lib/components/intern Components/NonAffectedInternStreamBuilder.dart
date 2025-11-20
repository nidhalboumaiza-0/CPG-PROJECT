import 'package:client/API/getSupervisorDataApi.dart';
import 'package:client/models/internModel.dart';
import 'package:client/models/sepervisorModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../screens/affectInternPage.dart';
import '../../screens/homePage.dart';

List toFetchListIntern = [];

class internStreamNonAffected extends StatefulWidget {
  const internStreamNonAffected({Key? key}) : super(key: key);

  @override
  State<internStreamNonAffected> createState() =>
      _internStreamNonAffectedState();
}

class _internStreamNonAffectedState extends State<internStreamNonAffected> {
  late Stream<List<Supervisor>> supervisors;
  late DateTime dateStart;
  late DateTime dateFinish;

  late String supervisor = '';
  late String internshipType = 'worker';

  TextEditingController _dateStart = TextEditingController();
  TextEditingController _dateFinish = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Intern>>(
      stream: StreamInternNonAffected,
      builder: (context, snapshot) {
        print("result i want to see : \n");
        //print(snapshot.data![0].firstName);
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
              return ListView.builder(
                itemCount: snapshot.data!.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        height: 128,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 9,
                              left: 9,
                              child: ClipOval(
                                child: Material(
                                  color: Colors.transparent,
                                  child: Ink.image(
                                    image: AssetImage(
                                            'images/${snapshot.data![index].picture}')
                                        as ImageProvider,
                                    fit: BoxFit.cover,
                                    width: 106,
                                    height: 106,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 15,
                              left: 120,
                              child: Text(
                                "${snapshot.data![index].firstName} ${snapshot.data![index].lastName}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 40,
                              left: 128,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.email_rounded,
                                    size: 12,
                                  ),
                                  Text(
                                    " ${snapshot.data![index].email}",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 90,
                              left: 127,
                              child: Row(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.school_rounded,
                                        size: 15,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    " ${snapshot.data![index].instituteName}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 65,
                              left: 128,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.phone_rounded,
                                    size: 15,
                                  ),
                                  Text(
                                    " ${snapshot.data![index].phoneNumber}",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 70,
                              left: 240,
                              child: MaterialButton(
                                onPressed: () {
                                  supervisors = getAllSupervisors();
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return StatefulBuilder(
                                        builder: (BuildContext context,
                                            StateSetter setState) {
                                          return AlertDialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(30.0),
                                              ),
                                            ),
                                            title: Text(
                                                'Affect ${snapshot.data![index].firstName} ${snapshot.data![index].lastName}'),
                                            content: SingleChildScrollView(
                                              child: Wrap(
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 8.0,
                                                                top: 8),
                                                        child: Text(
                                                            'Starting date :'),
                                                      ),
                                                      Container(
                                                        height: 50,
                                                        child: TextField(
                                                          controller:
                                                              _dateStart,
                                                          decoration:
                                                              KinputDecorationInstitue
                                                                  .copyWith(
                                                            hintText:
                                                                'Starting date',
                                                            icon: Icon(
                                                              Icons
                                                                  .calendar_month_rounded,
                                                              color: Color(
                                                                  0xffAACB73),
                                                            ),
                                                          ),
                                                          onTap: () async {
                                                            DateTime?
                                                                pickedDate =
                                                                await showDatePicker(
                                                                    context:
                                                                        context,
                                                                    initialDate:
                                                                        DateTime
                                                                            .now(),
                                                                    firstDate:
                                                                        DateTime
                                                                            .now(),
                                                                    lastDate:
                                                                        DateTime(
                                                                            2025));
                                                            if (pickedDate !=
                                                                null) {
                                                              dateStart =
                                                                  pickedDate;
                                                              print(dateStart
                                                                  .month);
                                                              setState(() {
                                                                _dateStart
                                                                    .text = DateFormat(
                                                                        'yyyy-MM-dd')
                                                                    .format(
                                                                        pickedDate);
                                                              });
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 8.0,
                                                                top: 8),
                                                        child: Text(
                                                            'Finishing date :'),
                                                      ),
                                                      Container(
                                                        height: 50,
                                                        child: TextField(
                                                          controller:
                                                              _dateFinish,
                                                          decoration:
                                                              KinputDecorationInstitue
                                                                  .copyWith(
                                                            hintText:
                                                                'Finishing date',
                                                            icon: Icon(
                                                              Icons
                                                                  .calendar_month_rounded,
                                                              color: Color(
                                                                  0xffE14D2A),
                                                            ),
                                                          ),
                                                          onTap: () async {
                                                            DateTime? pickedDate = await showDatePicker(
                                                                context:
                                                                    context,
                                                                initialDate: DateTime(
                                                                    dateStart
                                                                        .year,
                                                                    dateStart
                                                                        .month,
                                                                    dateStart
                                                                        .day),
                                                                firstDate: DateTime(
                                                                    dateStart
                                                                        .year,
                                                                    dateStart
                                                                        .month,
                                                                    dateStart
                                                                        .day),
                                                                lastDate:
                                                                    DateTime(
                                                                        2080));
                                                            if (pickedDate !=
                                                                null) {
                                                              dateFinish =
                                                                  pickedDate;

                                                              setState(() {
                                                                _dateFinish
                                                                    .text = DateFormat(
                                                                        'yyyy-MM-dd')
                                                                    .format(
                                                                        pickedDate);
                                                              });
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 8.0,
                                                                top: 8),
                                                        child: Text(
                                                            'Internship type :'),
                                                      ),
                                                      DropdownButton(
                                                        icon: Icon(Icons
                                                            .arrow_drop_down_circle_rounded),
                                                        items: [
                                                          DropdownMenuItem(
                                                            value: "worker",
                                                            child:
                                                                Text("Worker"),
                                                          ),
                                                          DropdownMenuItem(
                                                            value: "technician",
                                                            child: Text(
                                                                "Technician"),
                                                          ),
                                                          DropdownMenuItem(
                                                            value: "PFE",
                                                            child: Text("PFE"),
                                                          ),
                                                          DropdownMenuItem(
                                                            value:
                                                                "summer internship",
                                                            child: Text(
                                                                "Summer internship"),
                                                          ),
                                                        ],
                                                        onChanged: (value) {
                                                          setState(() {
                                                            internshipType =
                                                                value
                                                                    .toString();
                                                          });
                                                        },
                                                        value: internshipType,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 8.0,
                                                                top: 8),
                                                        child: Text(
                                                            'Supervisor :'),
                                                      ),
                                                      StreamBuilder<
                                                          List<Supervisor>>(
                                                        stream: supervisors,
                                                        builder: (context,
                                                            snapshot1) {
                                                          if (!snapshot1
                                                              .hasData) {
                                                            return Text(
                                                                'there is not any supervosrs go and add some .');
                                                          } else {
                                                            return StatefulBuilder(
                                                              builder: (context,
                                                                  setState) {
                                                                return DropdownButton(
                                                                  value:
                                                                      snapshot1
                                                                          .data![
                                                                              0]
                                                                          .id,
                                                                  icon: Icon(Icons
                                                                      .arrow_drop_down_circle_rounded),
                                                                  items: [
                                                                    for (var i =
                                                                            0;
                                                                        i < snapshot1.data!.length;
                                                                        i++)
                                                                      DropdownMenuItem(
                                                                        value: snapshot1
                                                                            .data![i]
                                                                            .id,
                                                                        child: Text(
                                                                            "${snapshot1.data![i].firstName} ${snapshot1.data![i].lastName}"),
                                                                      )
                                                                  ],
                                                                  onChanged:
                                                                      (value) {
                                                                    setState(
                                                                        () {
                                                                      supervisor =
                                                                          value
                                                                              .toString();
                                                                    });
                                                                  },
                                                                );
                                                              },
                                                            );
                                                          }
                                                        },
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                              top: 5,
                                                            ),
                                                            child:
                                                                MaterialButton(
                                                              onPressed:
                                                                  () async {
                                                                var data = {
                                                                  "supervisor":
                                                                      supervisor,
                                                                  "dateStart":
                                                                      dateStart
                                                                          .toIso8601String(),
                                                                  "dateFinish":
                                                                      dateFinish
                                                                          .toIso8601String(),
                                                                  "internShipType":
                                                                      internshipType
                                                                };

                                                                var encodedData =
                                                                    jsonEncode(
                                                                        data);
                                                                http.Response
                                                                    res =
                                                                    await http.patch(
                                                                        Uri.parse(
                                                                            '$Kurl/api/v1/interns/affectintern/${snapshot.data![index].id}'),
                                                                        headers: {
                                                                          'Content-Type':
                                                                              'application/json; charset=UTF-8',
                                                                        },
                                                                        body:
                                                                            encodedData);
                                                                if (res.statusCode ==
                                                                    201) {
                                                                  print(res);
                                                                  Navigator
                                                                      .push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          homePage(
                                                                              i: 2),
                                                                    ),
                                                                  );
                                                                }
                                                              },
                                                              height: 40,
                                                              minWidth: 80,
                                                              color: Color(
                                                                  0xffA6BB8D),
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                          10.0),
                                                                ),
                                                              ),
                                                              child: Text(
                                                                'Finish',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                              elevation: 3,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 20,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                              top: 5,
                                                            ),
                                                            child:
                                                                MaterialButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              height: 40,
                                                              minWidth: 80,
                                                              color: Color(
                                                                  0xffECC1C6),
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                          10.0),
                                                                ),
                                                              ),
                                                              child: Text(
                                                                'Cancel',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
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
                                height: 40,
                                minWidth: 80,
                                color: Color(0xffC9F4AA),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                child: Text(
                                  'Affect',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                elevation: 3,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 0,
                        thickness: 1.5,
                        indent: 2,
                        endIndent: 2,
                      ),
                      SizedBox(
                        height: 8,
                      )
                    ],
                  );
                },
              );
            } else {
              return Text("There is not any interns yet.");
            }
          default:
            return Text('Non intern exist.');
        }
      },
    );
  }
}
