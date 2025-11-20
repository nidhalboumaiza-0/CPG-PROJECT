import 'dart:convert';

import 'package:client/models/instituteModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants.dart';
import '../../screens/homePage.dart';
import '../../screens/instituteScreen.dart';

class instituteStream extends StatefulWidget {
  const instituteStream({Key? key}) : super(key: key);

  @override
  State<instituteStream> createState() => _instituteStreamState();
}

List toFetchListInstitute = [];

class _instituteStreamState extends State<instituteStream> {
  late String name = '';
  late String email = '';
  late String phoneNumber = '';
  late String adresse = '';
  late String fax = '';
  late String type = '';
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Institute>>(
        stream: StreamInstitute,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  name = snapshot.data![index].name!;
                  email = snapshot.data![index].email!;
                  adresse = snapshot.data![index].adresse!;
                  phoneNumber = snapshot.data![index].phoneNumber!;
                  if (snapshot.data![index].fax != null) {
                    fax = snapshot.data![index].fax!;
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                        child: Text(
                          '${snapshot.data![index].name}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: Color(0xff8B919D),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 18),
                            child: Text(
                              '${snapshot.data![index].adresse}',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: Color(0xffC3C7CD),
                              ),
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                RawMaterialButton(
                                  child: Icon(Icons.edit),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext) {
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(30.0),
                                            ),
                                          ),
                                          title: Text(
                                              'Edit ${snapshot.data![index].name}'),
                                          content: SingleChildScrollView(
                                            child: Wrap(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 8.0,
                                                              top: 8),
                                                      child: Text('Name :'),
                                                    ),
                                                    Container(
                                                      height: 50,
                                                      child: TextField(
                                                        controller:
                                                            TextEditingController()
                                                              ..text = snapshot
                                                                  .data![index]
                                                                  .name!,
                                                        onChanged: (value) {
                                                          name = value;
                                                        },
                                                        decoration:
                                                            KinputDecorationInstitue
                                                                .copyWith(
                                                                    hintText:
                                                                        'Name'),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 8.0,
                                                              top: 8),
                                                      child: Text('Email :'),
                                                    ),
                                                    Container(
                                                      height: 50,
                                                      child: TextField(
                                                        controller:
                                                            TextEditingController()
                                                              ..text = snapshot
                                                                  .data![index]
                                                                  .email!,
                                                        onChanged: (value) {
                                                          email = value;
                                                        },
                                                        decoration:
                                                            KinputDecorationInstitue
                                                                .copyWith(
                                                                    hintText:
                                                                        'Email'),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 8.0,
                                                              top: 8),
                                                      child: Text(
                                                          'Phone number :'),
                                                    ),
                                                    Container(
                                                      height: 50,
                                                      child: TextField(
                                                        controller:
                                                            TextEditingController()
                                                              ..text = snapshot
                                                                  .data![index]
                                                                  .phoneNumber!,
                                                        onChanged: (value) {
                                                          phoneNumber = value;
                                                        },
                                                        decoration:
                                                            KinputDecorationInstitue
                                                                .copyWith(
                                                          hintText:
                                                              'Phone number',
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 8.0,
                                                              top: 8),
                                                      child: Text('Fax :'),
                                                    ),
                                                    Container(
                                                      height: 50,
                                                      child: TextField(
                                                        controller:
                                                            TextEditingController()
                                                              ..text = snapshot
                                                                  .data![index]
                                                                  .fax!,
                                                        onChanged: (value) {
                                                          fax = value;
                                                        },
                                                        decoration:
                                                            KinputDecorationInstitue
                                                                .copyWith(
                                                                    hintText:
                                                                        'Fax'),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 8.0,
                                                              top: 8),
                                                      child: Text('Addresse :'),
                                                    ),
                                                    Container(
                                                      height: 50,
                                                      child: TextField(
                                                        controller:
                                                            TextEditingController()
                                                              ..text = snapshot
                                                                  .data![index]
                                                                  .adresse!,
                                                        onChanged: (value) {
                                                          adresse = value;
                                                        },
                                                        decoration:
                                                            KinputDecorationInstitue
                                                                .copyWith(
                                                          hintText: 'adresse',
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 8.0,
                                                              top: 8),
                                                      child: Text('Type :'),
                                                    ),
                                                    StatefulBuilder(
                                                      builder: (context,
                                                          void Function(
                                                                  void
                                                                      Function())
                                                              setState) {
                                                        return DropdownButton<
                                                                String>(
                                                            items: [
                                                              DropdownMenuItem(
                                                                child: Text(
                                                                    'university'),
                                                                value:
                                                                    'university',
                                                              ),
                                                              DropdownMenuItem(
                                                                child: Text(
                                                                    'training center'),
                                                                value:
                                                                    'training center',
                                                              ),
                                                            ],
                                                            value: snapshot
                                                                        .data![
                                                                            index]
                                                                        .type ==
                                                                    'university'
                                                                ? type =
                                                                    'university'
                                                                : type =
                                                                    'training center',
                                                            onChanged: (value) {
                                                              setState(() {
                                                                type = value
                                                                    .toString();
                                                              });
                                                            });
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
                                                          child: MaterialButton(
                                                            onPressed:
                                                                () async {
                                                              var data = {
                                                                "name": name,
                                                                "email": email,
                                                                "phoneNumber":
                                                                    phoneNumber,
                                                                "fax": fax,
                                                                "adresse":
                                                                    adresse,
                                                                "type": type
                                                              };

                                                              var encodedData =
                                                                  jsonEncode(
                                                                      data);
                                                              http.Response
                                                                  res =
                                                                  await http.patch(
                                                                      Uri.parse(
                                                                          '$Kurl/api/v1/institutes/updateinstitute/${snapshot.data![index].id}'),
                                                                      headers: {
                                                                        'Content-Type':
                                                                            'application/json; charset=UTF-8',
                                                                      },
                                                                      body:
                                                                          encodedData);

                                                              if (res.statusCode ==
                                                                  200) {
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        homePage(
                                                                            i: 3),
                                                                  ),
                                                                );
                                                              }
                                                            },
                                                            height: 40,
                                                            minWidth: 80,
                                                            color: Color(
                                                                0xffFFE699),
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(
                                                                Radius.circular(
                                                                    10.0),
                                                              ),
                                                            ),
                                                            child: Text(
                                                              'Edit',
                                                              style: TextStyle(
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
                                                          child: MaterialButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                SnackBar(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              13),
                                                                  backgroundColor:
                                                                      Color(
                                                                          0xffFFE699),
                                                                  content: Text(
                                                                    'Establishment Edited succefully',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black87,
                                                                    ),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                  ),
                                                                ),
                                                              );
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
                                                                Radius.circular(
                                                                    10.0),
                                                              ),
                                                            ),
                                                            child: Text(
                                                              'Cancel',
                                                              style: TextStyle(
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
                                  elevation: 3.0,
                                  constraints: BoxConstraints.tightFor(
                                    width: 40.0,
                                    height: 40.0,
                                  ),
                                  shape: CircleBorder(),
                                  fillColor: Color(0xffFFE699),
                                ),
                                RawMaterialButton(
                                  child: Icon(
                                    Icons.info,
                                    size: 30,
                                    color: Colors.grey.shade800,
                                  ),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext) {
                                          return AlertDialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(20.0),
                                              ),
                                            ),
                                            title: Text(
                                                'this is all about ${snapshot.data![index].name}'),
                                            content: Container(
                                              height: 300,
                                              width: 310,
                                              margin: EdgeInsets.fromLTRB(
                                                  0, 0, 10, 0),
                                              decoration: BoxDecoration(
                                                color: Color(0xFFFFFFFF),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Expanded(
                                                    child: Column(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                Icons.school,
                                                                color: Color(
                                                                    0xFF3490CC),
                                                                size: 20,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .fromLTRB(
                                                                            7,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                child: Flexible(
                                                                  child: Text(
                                                                    "${snapshot.data![index].name}",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontFamily:
                                                                            'Dubai',
                                                                        fontSize:
                                                                            14),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                Icons.place,
                                                                color: Color(
                                                                    0xFF3490CC),
                                                                size: 20,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .fromLTRB(
                                                                            7,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                child:
                                                                    Container(
                                                                  constraints: BoxConstraints(
                                                                      minHeight:
                                                                          5,
                                                                      maxHeight:
                                                                          40,
                                                                      minWidth:
                                                                          150,
                                                                      maxWidth:
                                                                          150),
                                                                  child: Text(
                                                                    "${snapshot.data![index].adresse}",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontFamily:
                                                                            'Dubai',
                                                                        fontSize:
                                                                            14),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                Icons.email,
                                                                color: Color(
                                                                    0xFF3490CC),
                                                                size: 20,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .fromLTRB(
                                                                            7,
                                                                            7,
                                                                            0,
                                                                            0),
                                                                child:
                                                                    Container(
                                                                  constraints: BoxConstraints(
                                                                      minHeight:
                                                                          5,
                                                                      maxHeight:
                                                                          40,
                                                                      minWidth:
                                                                          150,
                                                                      maxWidth:
                                                                          200),
                                                                  child: Text(
                                                                    "${snapshot.data![index].email} ",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontFamily:
                                                                            'Dubai',
                                                                        fontSize:
                                                                            14),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .phone_rounded,
                                                                color: Color(
                                                                    0xFF3490CC),
                                                                size: 20,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .fromLTRB(
                                                                            7,
                                                                            7,
                                                                            0,
                                                                            0),
                                                                child: Text(
                                                                  "${snapshot.data![index].phoneNumber}",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontFamily:
                                                                          'Dubai',
                                                                      fontSize:
                                                                          14),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                Icons.fax,
                                                                color: Color(
                                                                    0xFF3490CC),
                                                                size: 20,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .fromLTRB(
                                                                            7,
                                                                            7,
                                                                            0,
                                                                            0),
                                                                child: Text(
                                                                  "${snapshot.data![index].fax}",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontFamily:
                                                                        'Dubai',
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  elevation: 3.0,
                                  constraints: BoxConstraints.tightFor(
                                    width: 40.0,
                                    height: 40.0,
                                  ),
                                  shape: CircleBorder(),
                                  fillColor: Color(0xffB1E693),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        height: 15,
                        thickness: 1.5,
                        indent: 10,
                        endIndent: 10,
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  );
                });
          } else {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            );
          }
        });
  }
}
